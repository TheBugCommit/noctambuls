import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_dropdown.dart';
import 'package:noctambuls/features/settings/domain/entities/app_theme.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_event.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppDimensions.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.palette_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: AppDimensions.md),
                  Text(
                    l10n.themeLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),

              SizedBox(
                width: 140,
                child: AppDropdown<AppTheme>(
                  value: state.appTheme,
                  items: [
                    DropdownMenuItem(
                      value: AppTheme.system,
                      child: Text(l10n.themeSystemLabel),
                    ),
                    DropdownMenuItem(
                      value: AppTheme.light,
                      child: Text(l10n.themeLightLabel),
                    ),
                    DropdownMenuItem(
                      value: AppTheme.dark,
                      child: Text(l10n.themeDarkLabel),
                    ),
                  ],
                  onChanged: (newTheme) {
                    if (newTheme != null) {
                      context.read<ThemeBloc>().add(
                        SetThemeRequested(newTheme),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
