import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          onPrimary: AppColors.textWhite,
          surface: AppColors.surface,
          background: AppColors.background,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: AppTextStyles.appBarTitle,
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: AppColors.textWhite,
          unselectedLabelColor: Color(0xCCFFFFFF),
          indicatorColor: AppColors.textWhite,
          indicatorSize: TabBarIndicatorSize.label,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textWhite,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: AppTextStyles.buttonText,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 50),
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle:
                AppTextStyles.buttonText.copyWith(color: AppColors.primary),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          hintStyle: AppTextStyles.bodyMedium,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 2,
          shadowColor: AppColors.primary.withValues(alpha: 0.08),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.primaryDark,
          indicatorColor: AppColors.primary,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.textWhite, size: 24);
            }
            return const IconThemeData(color: Color(0xAAFFFFFF), size: 24);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppTextStyles.labelMedium
                  .copyWith(color: AppColors.textWhite);
            }
            return AppTextStyles.labelMedium
                .copyWith(color: const Color(0xAAFFFFFF));
          }),
        ),
      );
}
