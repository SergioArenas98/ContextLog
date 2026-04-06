import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/design/app_colors.dart';
import '../core/design/app_theme_extension.dart';
import '../core/design/app_tokens.dart';
import '../core/design/app_typography.dart';

/// STRATUM theme — premium dark fieldwork tool.
///
/// Design language: warm-earth surfaces, terracotta primary, generous radius,
/// JetBrains Mono identifiers + DM Sans prose.
abstract final class AppTheme {
  // ── Dark ──────────────────────────────────────────────────────────────────

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: AppTypography.sansFontFamily,
        textTheme: AppTypography.textTheme,
        extensions: const [AppThemeExtension.dark],
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primaryDark,
          onPrimary: AppColors.onPrimaryDark,
          primaryContainer: AppColors.primaryContainerDark,
          onPrimaryContainer: AppColors.onPrimaryContainerDark,
          secondary: AppColors.secondaryDark,
          onSecondary: AppColors.onSecondaryDark,
          secondaryContainer: AppColors.secondaryContainerDark,
          onSecondaryContainer: AppColors.onSecondaryContainerDark,
          tertiary: AppColors.tertiaryDark,
          onTertiary: AppColors.onTertiaryDark,
          tertiaryContainer: AppColors.tertiaryContainerDark,
          onTertiaryContainer: AppColors.onTertiaryContainerDark,
          error: AppColors.errorDark,
          onError: AppColors.onErrorDark,
          errorContainer: AppColors.errorContainerDark,
          onErrorContainer: AppColors.onErrorContainerDark,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.onSurfaceDark,
          surfaceContainerLowest: AppColors.surfaceContainerLowestDark,
          surfaceContainerLow: AppColors.surfaceContainerLowDark,
          surfaceContainer: AppColors.surfaceContainerDark,
          surfaceContainerHigh: AppColors.surfaceContainerHighDark,
          surfaceContainerHighest: AppColors.surfaceContainerHighestDark,
          onSurfaceVariant: AppColors.onSurfaceVariantDark,
          outline: AppColors.outlineDark,
          outlineVariant: AppColors.outlineVariantDark,
          inverseSurface: AppColors.inverseSurfaceDark,
          onInverseSurface: AppColors.onInverseSurfaceDark,
          inversePrimary: AppColors.inversePrimaryDark,
          scrim: AppColors.scrimDark,
          shadow: AppColors.shadowDark,
        ),

        // ── Scaffold ────────────────────────────────────────────────────────
        scaffoldBackgroundColor: AppColors.s0,

        // ── AppBar ──────────────────────────────────────────────────────────
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.s0,
          foregroundColor: AppColors.t0,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: AppTypography.textTheme.titleMedium?.copyWith(
            color: AppColors.t0,
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.s0,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          iconTheme: const IconThemeData(color: AppColors.t1, size: 22),
          actionsIconTheme: const IconThemeData(color: AppColors.t1, size: 22),
          surfaceTintColor: Colors.transparent,
        ),

        // ── Cards ────────────────────────────────────────────────────────────
        cardTheme: CardThemeData(
          color: AppColors.s1,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.mdBorderRadius,
            side: BorderSide(color: AppColors.rule, width: AppBorder.thin),
          ),
        ),

        // ── Dividers ─────────────────────────────────────────────────────────
        dividerTheme: const DividerThemeData(
          color: AppColors.rule,
          thickness: 1,
          space: 1,
        ),

        // ── Inputs ───────────────────────────────────────────────────────────
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.s2,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space16,
            vertical: AppSpacing.space16,
          ),
          border: OutlineInputBorder(
            borderRadius: AppRadius.smBorderRadius,
            borderSide: const BorderSide(color: AppColors.ruleMid, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.smBorderRadius,
            borderSide: const BorderSide(color: AppColors.ruleMid, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.smBorderRadius,
            borderSide:
                const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.smBorderRadius,
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: AppRadius.smBorderRadius,
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          labelStyle: TextStyle(
            color: AppColors.t1,
            fontSize: 11,
            fontFamily: AppTypography.monoFontFamily,
            letterSpacing: 0.6,
          ),
          hintStyle: TextStyle(
            color: AppColors.t2,
            fontSize: 13,
            fontFamily: AppTypography.sansFontFamily,
          ),
          floatingLabelStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 11,
            fontFamily: AppTypography.monoFontFamily,
            letterSpacing: 0.6,
          ),
        ),

        // ── Buttons ──────────────────────────────────────────────────────────
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.s0,
            minimumSize: const Size(64, 52),
            textStyle: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 0,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.smBorderRadius,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.t1,
            side: const BorderSide(color: AppColors.ruleStrong, width: 1),
            minimumSize: const Size(64, 48),
            textStyle: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.smBorderRadius,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),

        // ── FAB ──────────────────────────────────────────────────────────────
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.s0,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.lgBorderRadius,
          ),
          extendedTextStyle: TextStyle(
            fontFamily: AppTypography.sansFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0,
          ),
        ),

        // ── Bottom navigation ────────────────────────────────────────────────
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.s1,
          indicatorColor: AppColors.primaryContainer,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.onPrimaryContainer, size: 24);
            }
            return const IconThemeData(color: AppColors.t2, size: 24);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              fontSize: 11,
              color: selected ? AppColors.onPrimaryContainer : AppColors.t2,
            );
          }),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          height: 72,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),

        // ── Icon buttons ─────────────────────────────────────────────────────
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: AppColors.t1,
            minimumSize: const Size(44, 44),
          ),
        ),

        // ── List tiles ───────────────────────────────────────────────────────
        listTileTheme: const ListTileThemeData(
          tileColor: Colors.transparent,
          contentPadding:
              EdgeInsets.symmetric(horizontal: AppSpacing.space16),
          minVerticalPadding: AppSpacing.space12,
          iconColor: AppColors.t1,
          textColor: AppColors.t0,
        ),

        // ── Bottom sheets ────────────────────────────────────────────────────
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.s2,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.xl),
            ),
          ),
          dragHandleColor: AppColors.ruleStrong,
          showDragHandle: true,
          elevation: 0,
        ),

        // ── Dialogs ──────────────────────────────────────────────────────────
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.s3,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.lgBorderRadius,
            side: BorderSide(color: AppColors.ruleMid, width: 1),
          ),
          titleTextStyle: AppTypography.textTheme.titleMedium?.copyWith(
            color: AppColors.t0,
          ),
          contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
            color: AppColors.t1,
          ),
        ),

        // ── Chips ────────────────────────────────────────────────────────────
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.s2,
          side: const BorderSide(color: AppColors.ruleMid, width: 1),
          labelStyle: TextStyle(
            fontFamily: AppTypography.sansFontFamily,
            fontSize: 12,
            color: AppColors.t1,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.smBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space8,
            vertical: AppSpacing.space4,
          ),
        ),

        // ── SegmentedButton ──────────────────────────────────────────────────
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: SegmentedButton.styleFrom(
            backgroundColor: AppColors.s2,
            selectedBackgroundColor: AppColors.primaryContainer,
            selectedForegroundColor: AppColors.onPrimaryContainer,
            foregroundColor: AppColors.t1,
            side: const BorderSide(color: AppColors.ruleMid, width: 1),
            textStyle: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.smBorderRadius,
            ),
          ),
        ),

        // ── TabBar (kept for possible edge cases) ────────────────────────────
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColors.primary,
          labelColor: AppColors.t0,
          unselectedLabelColor: AppColors.t2,
          dividerColor: AppColors.rule,
          labelStyle: TextStyle(
            fontFamily: AppTypography.sansFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: AppTypography.sansFontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
        ),

        // ── Search bar ───────────────────────────────────────────────────────
        searchBarTheme: SearchBarThemeData(
          backgroundColor: WidgetStatePropertyAll(AppColors.s2),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          elevation: const WidgetStatePropertyAll(0),
          side: WidgetStatePropertyAll(
            const BorderSide(color: AppColors.ruleMid, width: 1),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.smBorderRadius),
          ),
          textStyle: WidgetStatePropertyAll(
            AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.t0),
          ),
          hintStyle: WidgetStatePropertyAll(
            AppTypography.textTheme.bodyMedium?.copyWith(color: AppColors.t2),
          ),
        ),

        // ── Popup menu ───────────────────────────────────────────────────────
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.s3,
          surfaceTintColor: Colors.transparent,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.mdBorderRadius,
            side: BorderSide(color: AppColors.ruleMid, width: 1),
          ),
          textStyle: AppTypography.textTheme.bodyMedium?.copyWith(
            color: AppColors.t0,
          ),
        ),

        // ── Snack bar ────────────────────────────────────────────────────────
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.s4,
          contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
            color: AppColors.t0,
          ),
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.mdBorderRadius,
          ),
          elevation: 0,
        ),

        // ── Progress indicator ───────────────────────────────────────────────
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
        ),

        // ── Switch / checkbox / radio ────────────────────────────────────────
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.t2;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primaryContainer;
            }
            return AppColors.s2;
          }),
        ),

        // ── Dropdown ────────────────────────────────────────────────────────
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.s2,
            border: OutlineInputBorder(
              borderRadius: AppRadius.smBorderRadius,
              borderSide: const BorderSide(color: AppColors.ruleMid, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.smBorderRadius,
              borderSide: const BorderSide(color: AppColors.ruleMid, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.smBorderRadius,
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: AppSpacing.space16,
            ),
          ),
          menuStyle: MenuStyle(
            backgroundColor: const WidgetStatePropertyAll(AppColors.s4),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            elevation: const WidgetStatePropertyAll(8),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: AppRadius.smBorderRadius,
                side: const BorderSide(color: AppColors.ruleMid, width: 1),
              ),
            ),
          ),
        ),

        // ── Scrollbar ────────────────────────────────────────────────────────
        scrollbarTheme: const ScrollbarThemeData(
          thumbColor: WidgetStatePropertyAll(AppColors.ruleStrong),
        ),
      );

  // ── Light (minimal — app is dark-primary) ─────────────────────────────────

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: AppTypography.sansFontFamily,
        textTheme: AppTypography.textTheme,
        extensions: const [AppThemeExtension.light],
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryLight,
          onPrimary: AppColors.onPrimaryLight,
          primaryContainer: AppColors.primaryContainerLight,
          onPrimaryContainer: AppColors.onPrimaryContainerLight,
          secondary: AppColors.secondaryLight,
          onSecondary: AppColors.onSecondaryLight,
          secondaryContainer: AppColors.secondaryContainerLight,
          onSecondaryContainer: AppColors.onSecondaryContainerLight,
          tertiary: AppColors.tertiaryLight,
          onTertiary: AppColors.onTertiaryLight,
          tertiaryContainer: AppColors.tertiaryContainerLight,
          onTertiaryContainer: AppColors.onTertiaryContainerLight,
          error: AppColors.errorLight,
          onError: AppColors.onErrorLight,
          errorContainer: AppColors.errorContainerLight,
          onErrorContainer: AppColors.onErrorContainerLight,
          surface: AppColors.surfaceLight,
          onSurface: AppColors.onSurfaceLight,
          outlineVariant: AppColors.outlineVariantLight,
          outline: Color(0xFF8A7060),
          surfaceContainerLowest: Color(0xFFFFFFFF),
          surfaceContainerLow: Color(0xFFF0EBE6),
          surfaceContainer: Color(0xFFE8E2DC),
          surfaceContainerHigh: Color(0xFFE0D8D2),
          surfaceContainerHighest: Color(0xFFD8CEC8),
          onSurfaceVariant: Color(0xFF5A4A3A),
          inverseSurface: Color(0xFF2A1E18),
          onInverseSurface: Color(0xFFF5EEE8),
          inversePrimary: AppColors.primaryDark,
          scrim: Color(0xFF000000),
          shadow: Color(0xFF000000),
        ),
        scaffoldBackgroundColor: AppColors.surfaceLight,
      );
}
