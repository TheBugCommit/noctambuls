import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_dropdown.dart'; // Importa el nou component
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_event.dart';
import 'package:noctambuls/features/settings/presentation/bloc/language_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppDimensions.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.language_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: AppDimensions.md),

                  Text(
                    l10n.languageLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(
                width: 140,
                child: AppDropdown<AppLanguage>(
                  value: state.appLanguage,
                  items: [
                    DropdownMenuItem(
                      value: AppLanguage.system,
                      child: Text(l10n.systemLabel),
                    ),
                    DropdownMenuItem(
                      value: AppLanguage.catalan,
                      child: Text(l10n.catalanLabel),
                    ),
                    DropdownMenuItem(
                      value: AppLanguage.spanish,
                      child: Text(l10n.spanishLabel),
                    ),
                  ],
                  onChanged: (newLang) {
                    if (newLang != null) {
                      context.read<LanguageBloc>().add(
                        ChangeLanguageRequested(newLang),
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
