import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_event.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_state.dart';
import 'package:noctambuls/features/profile/presentation/pages/widgets/profile_form_fields.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({required this.profile, super.key});

  final UserProfile profile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _phoneController = TextEditingController(text: widget.profile.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileBloc>().add(
        ProfileUpdateRequested(
          userId: widget.profile.id,
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileEditTitle),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (_, curr) =>
            curr is ProfileUpdateSuccess || curr is ProfileUpdateError,
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            context.pop();
          } else if (state is ProfileUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.profileEditError),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ProfileUpdating;

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.lg),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProfileFormFields(
                            nameController: _nameController,
                            phoneController: _phoneController,
                            isLoading: isLoading,
                            onSubmit: _submit,
                          ),

                          const Spacer(),
                          const SizedBox(height: AppDimensions.lg),

                          _SaveButton(isLoading: isLoading, onSubmit: _submit),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.isLoading, required this.onSubmit});

  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: AppDimensions.buttonHeightLg,
      child: AppButton.primary(
        onPressed: isLoading ? null : onSubmit,
        customIcon: isLoading
            ? SizedBox(
                width: AppDimensions.iconMd,
                height: AppDimensions.iconMd,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.onPrimary,
                ),
              )
            : const Icon(Icons.save),
        label: isLoading
            ? l10n.profileEditSaveButtonLoading
            : l10n.profileEditSaveButton,
      ),
    );
  }
}
