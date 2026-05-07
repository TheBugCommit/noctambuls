import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_bottom_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_text_field.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class AdaptiveManualCodeModal extends StatefulWidget {
  const AdaptiveManualCodeModal({super.key});

  @override
  State<AdaptiveManualCodeModal> createState() =>
      _AdaptiveManualCodeModalState();
}

class _AdaptiveManualCodeModalState extends State<AdaptiveManualCodeModal> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.pop(_controller.text.toUpperCase());
    }
  }

  Widget _buildTextField(AppLocalizations l10n) {
    return AppTextField(
      controller: _controller,
      hintText: l10n.codeHint,
      autofocus: true,
      textCapitalization: TextCapitalization.characters,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return l10n.emptyCodeError;
        final regex = RegExp(r'^#OR-[A-Za-z]{1,4}-\d{4}$');
        if (!regex.hasMatch(value)) return l10n.invalidCodeFormat;
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (isPortrait) {
      return _PortraitBottomSheet(
        formKey: _formKey,
        theme: theme,
        l10n: l10n,
        textField: _buildTextField(l10n),
        onSubmit: _submit,
      );
    } else {
      return _LandscapeFullScreen(
        formKey: _formKey,
        theme: theme,
        l10n: l10n,
        textField: _buildTextField(l10n),
        onSubmit: _submit,
      );
    }
  }
}

class _PortraitBottomSheet extends StatelessWidget {
  const _PortraitBottomSheet({
    required this.formKey,
    required this.theme,
    required this.l10n,
    required this.textField,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final ThemeData theme;
  final AppLocalizations l10n;
  final Widget textField;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppDimensions.sm),
          Container(
            width: AppDimensions.xxl,
            height: AppDimensions.xs,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            ),
          ),
          const SizedBox(height: AppDimensions.sm),

          AppBottomSheet(
            title: l10n.enterCodeTitle,
            content: Form(key: formKey, child: textField),
            secondaryButton: AppButton.outline(
              label: l10n.cancel,
              onPressed: () => context.pop(),
            ),
            primaryButton: AppButton.primary(
              label: l10n.add,
              onPressed: onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

class _LandscapeFullScreen extends StatelessWidget {
  const _LandscapeFullScreen({
    required this.formKey,
    required this.theme,
    required this.l10n,
    required this.textField,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final ThemeData theme;
  final AppLocalizations l10n;
  final Widget textField;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colorScheme.surface,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(l10n.enterCodeTitle),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.pop(),
            ),
            actions: [
              AppButton.primary(
                onPressed: onSubmit,
                label: l10n.add,
              ),
              const SizedBox(width: AppDimensions.md),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.lg),
            child: Form(key: formKey, child: textField),
          ),
        ),
      ),
    );
  }
}
