import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_state.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/widgets/review_content.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({required this.session, super.key});

  final ObservationSession session;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late final TextEditingController _listeningPointController;

  @override
  void initState() {
    super.initState();
    _listeningPointController = TextEditingController(
      text: widget.session.listeningPoint?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _listeningPointController.dispose();
    super.dispose();
  }

  Future<void> _onDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await AppSheet.showConfirm(
      context: context,
      title: l10n.confirmDeleteSessionTitle,
      message: l10n.confirmDeleteSessionMessage,
      confirmText: l10n.confirmDelete,
      cancelText: l10n.cancel,
      isDestructive: true,
    );
    if (!context.mounted) return;
    if (confirmed == true) {
      context.read<SessionReviewBloc>().add(ReviewDeleteSession());
    }
  }

  Future<void> _onFinalize(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await AppSheet.showConfirm(
      context: context,
      title: l10n.confirmFinalizeTitle,
      message: l10n.confirmFinalizeMessage,
      confirmText: l10n.confirmFinalizeConfirm,
      cancelText: l10n.cancel,
    );
    if (!context.mounted) return;

    if (confirmed == true) {
      context.read<SessionReviewBloc>().add(const ReviewFinalizeSession());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionReviewBloc, SessionReviewState>(
      listenWhen: (prev, curr) {
        return curr is SessionReviewFinalized ||
            curr is SessionReviewDeleted ||
            curr is SessionReviewError;
      },
      listener: (context, state) {
        switch (state) {
          case SessionReviewDeleted():
            context.go(AppRoutes.home);
          case SessionReviewFinalized():
            context.go(AppRoutes.profile);
          case SessionReviewError():
            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.reviewErrorSaving),
                behavior: SnackBarBehavior.floating,
              ),
            );
          default:
        }
      },
      child: BlocBuilder<SessionReviewBloc, SessionReviewState>(
        builder: (context, state) {
          if (state is! SessionReviewEditing) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final session = state.session;
          final validationError = state.validationError;

          final showSessionLocationError =
              validationError?.missingSessionLocation ?? false;
          final showListeningPointError =
              validationError?.missingListeningPoint ?? false;
          final missingLocationIds =
              validationError?.missingObservationLocationIds ??
              const <String>{};

          return ReviewContent(
            session: session,
            birdsMap: state.birdsMap,
            isReadOnly: session.isFinished,
            isValid: state.isValid,
            showSessionLocationError: showSessionLocationError,
            showListeningPointError: showListeningPointError,
            missingLocationIds: missingLocationIds,
            listeningPointController: _listeningPointController,
            onDelete: _onDelete,
            onFinalize: _onFinalize,
          );
        },
      ),
    );
  }
}
