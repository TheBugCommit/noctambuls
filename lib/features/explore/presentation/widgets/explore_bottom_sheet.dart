import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_dropdown.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_bloc.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_event.dart';
import 'package:noctambuls/features/explore/presentation/bloc/explore_state.dart';
import 'package:noctambuls/features/explore/presentation/widgets/species_breakdown.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ExploreBottomSheet extends StatelessWidget {
  const ExploreBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: DraggableScrollableSheet(
        initialChildSize: 0.35,
        minChildSize: 0.1,
        builder: (context, scrollController) {
          return _SheetContent(scrollController: scrollController);
        },
      ),
    );
  }
}

class _SheetContent extends StatelessWidget {
  const _SheetContent({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXl),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _DragHandle(),
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                slivers: const [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppDimensions.lg,
                        right: AppDimensions.lg,
                        bottom: AppDimensions.lg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _SpeciesDropdown(),
                          SizedBox(height: AppDimensions.sm),
                          _FilterChipsRow(),
                          SizedBox(height: AppDimensions.md),
                          _KpiRow(),
                          SizedBox(height: AppDimensions.md),
                          _DataSection(),
                          SizedBox(height: AppDimensions.xl),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.sm),
        child: Container(
          width: AppDimensions.lg + AppDimensions.md,
          height: AppDimensions.xs,
          decoration: BoxDecoration(
            color: colorScheme.outline,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
        ),
      ),
    );
  }
}

class _SpeciesDropdown extends StatelessWidget {
  const _SpeciesDropdown();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ExploreBloc>();

    return BlocBuilder<ExploreBloc, ExploreState>(
      buildWhen: (previous, current) =>
          previous.filters.speciesId != current.filters.speciesId ||
          previous.speciesNames != current.speciesNames,
      builder: (context, state) {
        final items = <DropdownMenuItem<String?>>[
          DropdownMenuItem<String?>(
            child: Text(l10n.exploreAllSpecies),
          ),
          ...state.speciesNames.entries.map(
            (e) => DropdownMenuItem<String?>(
              value: e.key,
              child: Text(e.value.commonName, overflow: TextOverflow.ellipsis),
            ),
          ),
        ];

        return AppDropdown<String?>(
          value: state.filters.speciesId,
          items: items,
          onChanged: (value) {
            bloc.add(
              ExploreFilterChanged(
                filters: state.filters.copyWith(speciesId: value),
              ),
            );
          },
          hint: l10n.exploreAllSpecies,
        );
      },
    );
  }
}

class _FilterChipsRow extends StatelessWidget {
  const _FilterChipsRow();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ExploreBloc>();

    return BlocBuilder<ExploreBloc, ExploreState>(
      buildWhen: (previous, current) =>
          previous.filters.selectedYears != current.filters.selectedYears ||
          previous.availableYears != current.availableYears,
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: l10n.exploreHistoric,
                isSelected: state.filters.isHistoric,
                onTap: () => bloc.add(
                  ExploreFilterChanged(
                    filters: state.filters.copyWith(selectedYears: {}),
                  ),
                ),
              ),
              ...state.availableYears.map(
                (year) => Padding(
                  padding: const EdgeInsets.only(left: AppDimensions.xs),
                  child: _FilterChip(
                    label: year.toString(),
                    isSelected: state.filters.selectedYears.contains(year),
                    onTap: () {
                      final current = state.filters.selectedYears;
                      final updated = Set<int>.from(current);
                      if (updated.contains(year)) {
                        updated.remove(year);
                      } else {
                        updated.add(year);
                      }
                      bloc.add(
                        ExploreFilterChanged(
                          filters: state.filters.copyWith(
                            selectedYears: updated,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
    );
  }
}

class _KpiRow extends StatelessWidget {
  const _KpiRow();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ExploreBloc, ExploreState>(
      buildWhen: (previous, current) =>
          previous.filteredBubbles != current.filteredBubbles,
      builder: (context, state) {
        final speciesCount = state.filteredBubbles
            .map((b) => b.speciesId)
            .toSet()
            .length;
        final totalObservations = state.filteredBubbles.fold(
          0,
          (sum, b) => sum + b.count,
        );

        return Row(
          children: [
            Expanded(
              child: _KpiCard(
                value: speciesCount.toString(),
                label: l10n.exploreKpiSpecies,
              ),
            ),
            const SizedBox(width: AppDimensions.sm),
            Expanded(
              child: _KpiCard(
                value: totalObservations.toString(),
                label: l10n.exploreKpiObservations,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.lg,
        horizontal: AppDimensions.lg,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _DataSection extends StatelessWidget {
  const _DataSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ExploreBloc, ExploreState>(
      buildWhen: (previous, current) =>
          previous.isSyncing != current.isSyncing ||
          previous.syncError != current.syncError ||
          previous.filteredBubbles != current.filteredBubbles ||
          previous.allBubbles != current.allBubbles,
      builder: (context, state) {
        if (state.isSyncing && !state.hasLocalData) {
          return const _LoadingSection();
        }

        if (state.syncError != null && !state.hasLocalData) {
          return _ErrorSection(error: l10n.exploreSyncError);
        }

        if (!state.hasLocalData) {
          return _EmptySection(message: l10n.exploreNoData);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.exploreBreakdownTitle,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimensions.md),
            SpeciesBreakdown(
              filteredBubbles: state.filteredBubbles,
              speciesNames: state.speciesNames,
            ),
          ],
        );
      },
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: AppDimensions.sm),
        Text(
          l10n.exploreSyncing,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ErrorSection extends StatelessWidget {
  const _ErrorSection({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          error,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.md),
        AppButton.primary(
          label: l10n.exploreRetry,
          onPressed: () =>
              context.read<ExploreBloc>().add(const ExploreRetrySync()),
        ),
      ],
    );
  }
}

class _EmptySection extends StatelessWidget {
  const _EmptySection({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.xl),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
