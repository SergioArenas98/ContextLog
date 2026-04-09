import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/changelog.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/preferences/theme_notifier.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final themeAsync = ref.watch(themeNotifierProvider);
    final currentTheme = themeAsync.valueOrNull ?? ThemeMode.dark;

    return Scaffold(
      backgroundColor: colors.s0,
      appBar: AppBar(
        backgroundColor: colors.s0,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 20),
          color: colors.t1,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'SETTINGS',
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 2.5,
            color: colors.t0,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: colors.rule),
        ),
      ),
      body: ListView(
        children: [
          // ── Appearance ─────────────────────────────────────────────────
          _SectionLabel(label: 'APPEARANCE'),
          _ThemeSetting(currentTheme: currentTheme, ref: ref),
          Container(height: 1, color: colors.rule),

          // ── About ──────────────────────────────────────────────────────
          _SectionLabel(label: 'ABOUT'),
          _VersionTile(),
          Container(height: 1, color: colors.rule),
          _SettingsTile(
            icon: Icons.history_rounded,
            title: 'Changelog',
            onTap: () => context.push('/settings/changelog'),
          ),
          Container(height: 1, color: colors.rule),

          // ── Data ───────────────────────────────────────────────────────
          _SectionLabel(label: 'DATA'),
          _SettingsTile(
            icon: Icons.folder_outlined,
            title: 'Projects',
            subtitle: 'Manage excavation projects',
            onTap: () => context.push('/projects'),
          ),
          Container(height: 1, color: colors.rule),
        ],
      ),
    );
  }
}

// ── Changelog screen ──────────────────────────────────────────────────────────

class ChangelogScreen extends StatelessWidget {
  const ChangelogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.s0,
      appBar: AppBar(
        backgroundColor: colors.s0,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 20),
          color: colors.t1,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'CHANGELOG',
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 2.5,
            color: colors.t0,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: colors.rule),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: AppSpacing.space80),
        itemCount: AppChangelog.entries.length,
        itemBuilder: (context, index) {
          final entry = AppChangelog.entries[index];
          return _ChangelogEntryTile(entry: entry);
        },
      ),
    );
  }
}

class _ChangelogEntryTile extends StatelessWidget {
  const _ChangelogEntryTile({required this.entry});

  final ChangelogEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'v${entry.version}',
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  letterSpacing: 0.5,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Text(
                entry.date,
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontSize: 10,
                  color: colors.t2,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          ...entry.changes.map((item) => _ChangelogItemRow(item: item)),
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.space16),
            height: 1,
            color: colors.rule,
          ),
        ],
      ),
    );
  }
}

class _ChangelogItemRow extends StatelessWidget {
  const _ChangelogItemRow({required this.item});

  final ChangelogItem item;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final typeColor = switch (item.type) {
      ChangeType.feature => colors.primary,
      ChangeType.fix => colors.success,
      ChangeType.change => colors.t1,
      ChangeType.removal => colors.error,
    };
    final typeLabel = switch (item.type) {
      ChangeType.feature => 'NEW',
      ChangeType.fix => 'FIX',
      ChangeType.change => 'CHG',
      ChangeType.removal => 'DEL',
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            margin: const EdgeInsets.only(top: 2, right: AppSpacing.space8),
            child: Text(
              typeLabel,
              style: TextStyle(
                fontFamily: AppTypography.monoFontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 8,
                letterSpacing: 1.0,
                color: typeColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              item.text,
              style: TextStyle(
                fontFamily: AppTypography.sansFontFamily,
                fontSize: 13,
                height: 1.4,
                color: colors.t1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Internal widgets ──────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space6,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: AppTypography.monoFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 9,
          letterSpacing: 2.0,
          color: colors.t2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        color: colors.s0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: colors.t1),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppTypography.sansFontFamily,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: colors.t0,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontFamily: AppTypography.sansFontFamily,
                        fontSize: 12,
                        color: colors.t2,
                      ),
                    ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: colors.t2,
              ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSetting extends StatelessWidget {
  const _ThemeSetting({required this.currentTheme, required this.ref});

  final ThemeMode currentTheme;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      color: colors.s0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space12,
      ),
      child: Row(
        children: [
          Icon(Icons.brightness_6_rounded, size: 18, color: colors.t1),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              'Theme',
              style: TextStyle(
                fontFamily: AppTypography.sansFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: colors.t0,
              ),
            ),
          ),
          _ThemeSegment(
            label: 'Light',
            mode: ThemeMode.light,
            current: currentTheme,
            ref: ref,
          ),
          const SizedBox(width: AppSpacing.space6),
          _ThemeSegment(
            label: 'Dark',
            mode: ThemeMode.dark,
            current: currentTheme,
            ref: ref,
          ),
          const SizedBox(width: AppSpacing.space6),
          _ThemeSegment(
            label: 'Auto',
            mode: ThemeMode.system,
            current: currentTheme,
            ref: ref,
          ),
        ],
      ),
    );
  }
}

class _ThemeSegment extends StatelessWidget {
  const _ThemeSegment({
    required this.label,
    required this.mode,
    required this.current,
    required this.ref,
  });

  final String label;
  final ThemeMode mode;
  final ThemeMode current;
  final WidgetRef ref;

  bool get _selected => current == mode;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return GestureDetector(
      onTap: () => ref.read(themeNotifierProvider.notifier).setTheme(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space8,
          vertical: AppSpacing.space4,
        ),
        decoration: BoxDecoration(
          color: _selected ? colors.primary : colors.s2,
          borderRadius: AppRadius.xsBorderRadius,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 9,
            letterSpacing: 1.0,
            color: _selected ? colors.s0 : colors.t1,
          ),
        ),
      ),
    );
  }
}

class _VersionTile extends StatefulWidget {
  @override
  State<_VersionTile> createState() => _VersionTileState();
}

class _VersionTileState extends State<_VersionTile> {
  String _version = '—';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _version = '${info.version} (${info.buildNumber})');
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      color: colors.s0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space12,
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 18, color: colors.t1),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              'Version',
              style: TextStyle(
                fontFamily: AppTypography.sansFontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: colors.t0,
              ),
            ),
          ),
          Text(
            _version,
            style: TextStyle(
              fontFamily: AppTypography.monoFontFamily,
              fontSize: 12,
              color: colors.t2,
            ),
          ),
        ],
      ),
    );
  }
}
