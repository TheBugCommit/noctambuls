import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_assets.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/presentation/widgets/notification_bell_button.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/theme_event.dart';
import 'package:vector_graphics/vector_graphics.dart';

class TaxusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaxusAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surfaceContainer,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SvgPicture(
            AssetBytesLoader(AppAssets.taxusIcon),
            height: AppDimensions.xl,
          ),
          const SizedBox(width: AppDimensions.sm),
          SvgPicture(
            const AssetBytesLoader(AppAssets.taxusText),
            height: AppDimensions.xl,
            colorFilter: ColorFilter.mode(
              colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),

      actions: [
        const NotificationBellButton(),
        const _ThemeToggleButon(),
        IconButton(
          icon: const Icon(Icons.settings),
          color: colorScheme.onSurface,
          onPressed: () async {
            await context.push(AppRoutes.settings);
          },
        ),
        const SizedBox(width: AppDimensions.sm),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ThemeToggleButon extends StatelessWidget {
  const _ThemeToggleButon();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: () =>
          context.read<ThemeBloc>().add(const ToggleThemeRequested()),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );

          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween(begin: 0.8, end: 1.0).animate(curved),
              child: RotationTransition(
                turns: Tween(begin: 0.25, end: 1.0).animate(curved),
                child: child,
              ),
            ),
          );
        },
        child: Icon(
          Theme.of(context).brightness == Brightness.dark
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
          key: ValueKey(Theme.of(context).brightness),
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
