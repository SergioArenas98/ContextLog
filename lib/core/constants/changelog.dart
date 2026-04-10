/// In-app changelog entries.
/// Add new entries at the top of the list.
/// Each entry maps to one app release.
abstract final class AppChangelog {
  static const List<ChangelogEntry> entries = [
    ChangelogEntry(
      version: '1.2.0',
      date: '2026-04-09',
      changes: [
        ChangelogItem(
          type: ChangeType.feature,
          text: 'Projects — create reusable excavation projects with site name, '
              'site code, and licence number.',
        ),
        ChangelogItem(
          type: ChangeType.change,
          text: 'Feature creation now requires selecting a project. Site metadata '
              'is no longer typed per feature.',
        ),
        ChangelogItem(
          type: ChangeType.feature,
          text: 'Settings — Light / Dark / System theme with persistent preference.',
        ),
        ChangelogItem(
          type: ChangeType.feature,
          text: 'New PROBE design system — instrument-panel aesthetic with Space '
              'Grotesk and JetBrains Mono typography.',
        ),
        ChangelogItem(
          type: ChangeType.feature,
          text: 'Redesigned Site Roster — single-column roster replacing the '
              '2-column feature grid.',
        ),
        ChangelogItem(
          type: ChangeType.feature,
          text: 'Excavation Station — interactive Harris Matrix nodes with overlay '
              'context panels instead of screen pushes.',
        ),
        ChangelogItem(
          type: ChangeType.feature,
          text: 'Full-screen Harris Matrix with legend bar and relation builder.',
        ),
      ],
    ),
    ChangelogEntry(
      version: '1.0.0',
      date: '2026-01-01',
      changes: [
        ChangelogItem(
          type: ChangeType.feature,
          text: 'Initial release — features, contexts (cuts and fills), finds, '
              'samples, drawings, photos, and Harris Matrix.',
        ),
      ],
    ),
  ];
}

/// A single release entry in the changelog.
class ChangelogEntry {
  const ChangelogEntry({
    required this.version,
    required this.date,
    required this.changes,
  });

  final String version;
  final String date;
  final List<ChangelogItem> changes;
}

/// A single change bullet within a release.
class ChangelogItem {
  const ChangelogItem({required this.type, required this.text});

  final ChangeType type;
  final String text;
}

enum ChangeType { feature, fix, change, removal }
