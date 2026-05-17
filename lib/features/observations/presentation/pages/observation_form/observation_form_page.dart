import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_event.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_state.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_quantity_selector.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_bloc.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_state.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/contact_type_selector_field.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/date_time_range_selector.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/location_selector_card.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/notes_field.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/orientation_selector_field.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/species_selector_field.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/location_auto_capture_mixin.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/location_permissions_dialog.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_bloc.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ObservationFormArgs {
  const ObservationFormArgs({
    required this.session,
    this.existingRecord,
  });

  final ObservationSession session;
  final ObservationRecord? existingRecord;
}

class ObservationFormPage extends StatefulWidget {
  const ObservationFormPage({
    required this.session,
    this.existingRecord,
    super.key,
  });

  final ObservationSession session;
  final ObservationRecord? existingRecord;

  @override
  State<ObservationFormPage> createState() => _ObservationFormPageState();
}

class _ObservationFormPageState extends State<ObservationFormPage>
    with WidgetsBindingObserver, LocationAutoCaptureMixin {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _notesController;
  late TextEditingController _quantityController;
  late ContactType _selectedContactType;
  late DateTime _startTime;
  late DateTime _endTime;
  double? _selectedBearing;
  String? _selectedSpeciesId;
  bool _hasChangedGlobalDate = false;

  // Location state (incidental sessions only)
  bool _isAtLocation = false;
  bool _pendingInitialCapture = false;

  @override
  bool get shouldRetryLocationCapture {
    final state = context.read<ObservationFormBloc>().state;
    if (state is ObservationFormReady) {
      return _isAtLocation && state.geoPosition == null;
    }
    return false;
  }

  @override
  Future<void> onResumedLocationCapture() async {
    context.read<LocationBloc>().add(LocationRequested());
  }

  LocationErrorType _mapFailureToType(Failure failure) {
    if (failure is PermissionDeniedFailure) {
      return LocationErrorType.permissionDenied;
    } else if (failure is GpsDisabledFailure) {
      return LocationErrorType.gpsDisabled;
    } else {
      return LocationErrorType.timeoutNoSignal;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    _notesController = TextEditingController(
      text: widget.existingRecord?.notes ?? '',
    );
    _quantityController = TextEditingController(
      text: widget.existingRecord?.quantity.toString() ?? '1',
    );
    _selectedSpeciesId = widget.existingRecord?.speciesId;
    _selectedContactType =
        widget.existingRecord?.contactType ?? ContactType.auditive;
    _selectedBearing = widget.existingRecord?.bearing;

    final existingLoc = widget.existingRecord?.location;
    if (existingLoc != null) {
      _isAtLocation = existingLoc.locationSource == LocationSource.gps;
    } else {
      _isAtLocation = false;
    }

    if (widget.existingRecord == null && widget.session.isIncidental) {
      _isAtLocation = true;
      _pendingInitialCapture = true;
    }

    if (widget.existingRecord != null) {
      _startTime = widget.existingRecord!.startTime.toLocal();
      _endTime = widget.existingRecord!.endTime.toLocal();
    } else if (widget.session.canEditObservationDate) {
      final date = widget.session.startTime?.toLocal() ?? now;
      final initial = DateTime(
        date.year,
        date.month,
        date.day,
        now.hour,
        now.minute,
      );
      _startTime = initial;
      _endTime = initial;
    } else {
      final min = widget.session.observationTimeMin?.toLocal();
      final max = widget.session.observationTimeMax?.toLocal() ?? now;
      var initial = now;
      if (initial.isAfter(max)) initial = max;
      if (min != null && initial.isBefore(min)) initial = min;

      _startTime = initial;
      _endTime = initial;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final langCode = context
          .read<LanguageBloc>()
          .state
          .appLanguage
          .toLanguageCode;

      context.read<ObservationFormBloc>().add(
        LoadFormDataRequested(
          langCode: langCode,
          existingLocation: widget.existingRecord?.location,
        ),
      );
    });
  }

  Future<void> _openMapPicker(GeoPosition? currentPos) async {
    final result = await context.push<GeoPosition>(
      AppRoutes.mapPicker,
      extra: currentPos,
    );
    if (!mounted || result == null) return;

    setState(() => _isAtLocation = false);
    context.read<ObservationFormBloc>().add(FormLocationUpdated(result));
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final state = context.read<ObservationFormBloc>().state;
      if (state is! ObservationFormReady) return;

      context.read<ObservationFormBloc>().add(
        SaveObservationRequested(
          sessionId: widget.session.id,
          speciesId: _selectedSpeciesId!,
          contactType: _selectedContactType,
          quantity: int.tryParse(_quantityController.text) ?? 1,
          notes: _notesController.text.isNotEmpty
              ? _notesController.text
              : null,
          bearing: _selectedBearing!,
          location: state.geoPosition,
          locationError: state.locationError,
          startTime: _startTime,
          endTime: _endTime,
          existingRecord: widget.existingRecord,
          newGlobalDate: _hasChangedGlobalDate ? _startTime : null,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.existingRecord != null;
    final isReadOnly = widget.session.isFinished;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? l10n.editObservationTitle : l10n.newObservationTitle,
        ),
        actions: [
          if (!isReadOnly)
            Padding(
              padding: const EdgeInsets.only(right: AppDimensions.md),
              child: AppButton.primary(
                onPressed: _onSave,
                label: l10n.saveObservation,
                icon: Icons.save_outlined,
                size: AppButtonSize.sm,
              ),
            ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocationBloc, LocationState>(
            listener: (context, state) {
              if (!_isAtLocation) return;

              if (state is LocationLoadSuccess) {
                context.read<ObservationFormBloc>().add(
                  FormLocationUpdated(state.position),
                );
              } else if (state is LocationLoadFailure) {
                final errorType = _mapFailureToType(state.failure);
                context.read<ObservationFormBloc>().add(
                  FormLocationErrorOccurred(errorType),
                );

                if (errorType == LocationErrorType.permissionDenied ||
                    errorType == LocationErrorType.gpsDisabled) {
                  unawaited(
                    LocationPermissionsDialog.showLocationErrorDialog(
                      context,
                      errorType,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.locationErrorTimeout),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
          ),
          BlocListener<ObservationFormBloc, ObservationFormState>(
            listenWhen: (prev, current) =>
                current is ObservationFormSuccess ||
                current is ObservationFormError ||
                (prev is ObservationFormLoading &&
                    current is ObservationFormReady),
            listener: (context, state) {
              if (state is ObservationFormReady && _pendingInitialCapture) {
                _pendingInitialCapture = false;
                context.read<LocationBloc>().add(LocationRequested());
              } else if (state is ObservationFormSuccess) {
                context.pop();
              } else if (state is ObservationFormError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.errorSavingObservation),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ObservationFormBloc, ObservationFormState>(
          buildWhen: (prev, current) =>
              current is ObservationFormReady ||
              current is ObservationFormLoading,
          builder: (context, state) {
            if (state is! ObservationFormReady) {
              return const Center(child: CircularProgressIndicator());
            }

            final isLocLoading =
                context.watch<LocationBloc>().state is LocationLoadInProgress;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.lg),
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ObservationDateHeader(
                        session: widget.session,
                        startTime: _startTime,
                        endTime: _endTime,
                        isReadOnly: isReadOnly,
                        onChanged: (start, end) {
                          setState(() {
                            _startTime = start;
                            _endTime = end;
                          });
                        },
                        onGlobalDateChanged: isReadOnly
                            ? null
                            : (date) {
                                setState(() {
                                  _hasChangedGlobalDate = true;
                                });
                              },
                      ),
                      const SizedBox(height: AppDimensions.lg),

                      if (widget.session.isIncidental) ...[
                        LocationSelectorCard(
                          isAtLocation: _isAtLocation,
                          location: state.geoPosition,
                          locationError: state.locationError,
                          isReadOnly: isReadOnly,
                          isLoading: isLocLoading,
                          onToggleChange: (value) {
                            if (isReadOnly) return;
                            setState(() => _isAtLocation = value);
                            if (value) {
                              context.read<LocationBloc>().add(
                                LocationRequested(),
                              );
                            } else {
                              context.read<ObservationFormBloc>().add(
                                const ClearLocationRequested(),
                              );
                            }
                          },
                          onOpenMap: () => _openMapPicker(state.geoPosition),
                        ),
                        const SizedBox(height: AppDimensions.lg),
                      ],

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SpeciesSelectorField(
                              birds: state.birds,
                              selectedSpeciesId: _selectedSpeciesId,
                              isReadOnly: isReadOnly,
                              onChanged: (value) => setState(
                                () => _selectedSpeciesId = value,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.md),
                          Expanded(
                            child: AppQuantitySelector(
                              controller: _quantityController,
                              label: l10n.quantityLabel,
                              minValue: 1,
                              enabled: !isReadOnly,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.xs),
                      DateTimeRangeSelectorField(
                        session: widget.session,
                        startTime: _startTime,
                        endTime: _endTime,
                        isReadOnly: isReadOnly,
                        onChanged: (start, end) {
                          setState(() {
                            _startTime = start;
                            _endTime = end;
                          });
                        },
                      ),
                      const SizedBox(height: AppDimensions.lg),

                      ContactTypeSelectorField(
                        selectedContactType: _selectedContactType,
                        isReadOnly: isReadOnly,
                        onChanged: (value) =>
                            setState(() => _selectedContactType = value),
                      ),
                      const SizedBox(height: AppDimensions.lg),

                      OrientationSelectorField(
                        selectedBearing: _selectedBearing,
                        isReadOnly: isReadOnly,
                        onChanged: (value) =>
                            setState(() => _selectedBearing = value),
                      ),
                      const SizedBox(height: AppDimensions.xs),

                      NotesField(
                        controller: _notesController,
                        enabled: !isReadOnly,
                      ),
                      const SizedBox(height: AppDimensions.xl),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
