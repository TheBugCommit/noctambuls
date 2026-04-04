import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/features/settings/domain/entities/app_language.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_cubit.dart';
import 'package:noctambuls/features/settings/presentation/cubit/language_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({required this.l10n, super.key});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return ListTile(
          title: Text(l10n.languageLabel),
          trailing: DropdownButton<AppLanguage>(
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
            onChanged: (newLang) async {
              if (newLang != null) {
                await context.read<LanguageCubit>().changeLanguage(newLang);
              }
            },
          ),
        );
      },
    );
  }
}
