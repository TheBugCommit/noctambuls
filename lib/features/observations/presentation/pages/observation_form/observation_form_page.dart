import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_quantity_selector.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_bloc.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/bloc/observation_form_state.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/contact_type_selector_field.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/date_time_range_selector.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/notes_field.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/orientation_selector_field.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/widgets/species_selector_field.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_bloc.dart';
import 'package:noctambuls/features/settings/presentation/utils/language_mapper.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ObservationFormArgs {
  const ObservationFormArgs({
    required this.sessionId,
    required this.sessionBloc,
    this.existingRecord,
  });

  final String sessionId;
  final SessionObservationBloc sessionBloc;
  final ObservationRecord? existingRecord;
}

class ObservationFormPage extends StatefulWidget {
  const ObservationFormPage({
    required this.sessionId,
    required this.sessionBloc,
    this.existingRecord,
    super.key,
  });

  final String sessionId;
  final SessionObservationBloc sessionBloc;
  final ObservationRecord? existingRecord;

  @override
  State<ObservationFormPage> createState() => _ObservationFormPageState();
}

class _ObservationFormPageState extends State<ObservationFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _notesController;
  late TextEditingController _quantityController;
  late ContactType _selectedContactType;
  late DateTime _startTime;
  late DateTime _endTime;
  double? _selectedBearing;
  String? _selectedSpeciesId;
  double? _latitude;
  double? _longitude;

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
    _latitude = widget.existingRecord?.latitude;
    _longitude = widget.existingRecord?.longitude;
    _startTime = widget.existingRecord?.startTime ?? now;
    _endTime = widget.existingRecord?.endTime ?? now;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final langCode = context
          .read<LanguageBloc>()
          .state
          .appLanguage
          .toLanguageCode;
      context.read<ObservationFormBloc>().add(LoadFormDataRequested(langCode));
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      context.read<ObservationFormBloc>().add(
        SaveObservationRequested(
          sessionId: widget.sessionId,
          speciesId: _selectedSpeciesId!,
          contactType: _selectedContactType,
          quantity: int.tryParse(_quantityController.text) ?? 1,
          notes: _notesController.text.isNotEmpty
              ? _notesController.text
              : null,
          bearing: _selectedBearing!,
          latitude: _latitude ?? 0.0,
          //TODO: CAMBIAR ES PER TEST
          longitude: _longitude ?? 0.0,
          startTime: _startTime,
          endTime: _endTime,
          existingRecord: widget.existingRecord,
          sessionBloc: widget.sessionBloc,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.existingRecord != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? l10n.editObservationTitle : l10n.newObservationTitle,
        ),
        actions: [
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
      body: BlocConsumer<ObservationFormBloc, ObservationFormState>(
        listenWhen: (previous, current) =>
            current is ObservationFormSuccess ||
            current is ObservationFormError,
        listener: (context, state) {
          if (state is ObservationFormSuccess) {
            context.pop();
          } else if (state is ObservationFormError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.errorSavingObservation),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ObservationFormLoading ||
              state is ObservationFormInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          final birds = state is ObservationFormReady ? state.birds : <Bird>[];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.lg),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SpeciesSelectorField(
                            birds: birds,
                            selectedSpeciesId: _selectedSpeciesId,
                            onChanged: (value) =>
                                setState(() => _selectedSpeciesId = value),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.md),
                        Expanded(
                          child: AppQuantitySelector(
                            controller: _quantityController,
                            label: l10n.quantityLabel,
                            minValue: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimensions.md),
                    DateTimeRangeSelectorField(
                      startTime: _startTime,
                      endTime: _endTime,
                      onChanged: (start, end) {
                        setState(() {
                          _startTime = start;
                          _endTime = end;
                        });
                      },
                    ),
                    const SizedBox(height: AppDimensions.md),

                    ContactTypeSelectorField(
                      selectedContactType: _selectedContactType!,
                      onChanged: (value) =>
                          setState(() => _selectedContactType = value),
                    ),
                    const SizedBox(height: AppDimensions.md),

                    OrientationSelectorField(
                      selectedBearing: _selectedBearing,
                      onChanged: (value) =>
                          setState(() => _selectedBearing = value),
                    ),

                    const SizedBox(height: AppDimensions.md),
                    NotesField(controller: _notesController),
                    const SizedBox(height: AppDimensions.xl),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
