import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_event.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_state.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_state.dart';
import 'package:noctambuls/core/presentation/widgets/map_preview_widget.dart';
import 'package:noctambuls/core/presentation/widgets/no_internet_placeholder_widget.dart';
import 'package:noctambuls/core/presentation/widgets/time_text.dart'; // NOU IMPORT
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class CensusDetailPage extends StatefulWidget {
  const CensusDetailPage({required this.census, super.key});

  final Census census;

  @override
  State<CensusDetailPage> createState() => _CensusDetailPageState();
}

class _CensusDetailPageState extends State<CensusDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectivityBloc>().add(const CheckInternetConnectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final census = widget.census;

    return BlocListener<UrlBloc, UrlState>(
      listenWhen: (previous, current) => current is UrlActionFailure,
      listener: (context, state) {
        if (state is UrlActionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.errorUnknown),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(l10n.censusDetailTitle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  census.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppDimensions.md),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.xs),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSm,
                        ),
                      ),
                      child: Icon(
                        Icons.event_note,
                        size: AppDimensions.iconSm,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.sm),
                    Expanded(
                      child: TimeText.dateTime(
                        census.startTime,
                        formatStyle: DateTimeFormatStyle.dateLong,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.xl),

                if (census.geoPosition != null) ...[
                  Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMd,
                      ),
                    ),
                    child: ColoredBox(
                      color: colorScheme.surfaceContainerLow,
                      child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
                        builder: (context, networkState) {
                          if (networkState is NetworkActionInitial ||
                              networkState is NetworkActionLoading) {
                            return const SizedBox(
                              height: 180,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          if (networkState is! NetworkActionSuccess) {
                            return const NoInternetPlaceholderWidget();
                          }
                          return SizedBox(
                            height: 180,
                            child: MapPreviewWidget(
                              isReadOnly: false,
                              showEditOverlay: false,
                              onTap: () => context.read<UrlBloc>().add(
                                OpenMapsUrlRequested(
                                  latitude: census.geoPosition!.latitude,
                                  longitude: census.geoPosition!.longitude,
                                ),
                              ),
                              points: [
                                LatLng(
                                  census.geoPosition!.latitude,
                                  census.geoPosition!.longitude,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                ],

                if (census.locationName != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.md),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMd,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: AppDimensions.iconMd,
                          color: colorScheme.secondary,
                        ),
                        const SizedBox(width: AppDimensions.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.censusDirectionLabel,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                census.locationName!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.xl),
                ],

                Text(
                  l10n.censusDescriptionTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppDimensions.sm),

                if (census.description != null &&
                    census.description!.trim().isNotEmpty)
                  Text(
                    census.description!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.md),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorScheme.outlineVariant,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMd,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: colorScheme.outline,
                          size: AppDimensions.iconMd,
                        ),
                        const SizedBox(width: AppDimensions.sm),
                        Expanded(
                          child: Text(
                            l10n.censusNoDescription,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.outline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
