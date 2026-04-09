import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';
import '../constants/enums.dart';
import 'converters/enum_converters.dart';
import '../../features/context/data/tables/contexts_table.dart';
import '../../features/drawing/data/tables/drawings_table.dart';
import '../../features/feature/data/tables/features_table.dart';
import '../../features/find/data/tables/finds_table.dart';
import '../../features/harris_matrix/data/tables/harris_relations_table.dart';
import '../../features/photo/data/tables/photos_table.dart';
import '../../features/project/data/tables/projects_table.dart';
import '../../features/sample/data/tables/samples_table.dart';

part 'app_database.g.dart';

/// Main Drift database for ContextLog.
/// All tables are registered here and the database is opened via [openConnection].
@DriftDatabase(
  tables: [
    ProjectsTable,
    FeaturesTable,
    PhotosTable,
    DrawingsTable,
    ContextsTable,
    FindsTable,
    SamplesTable,
    HarrisRelationsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => AppConstants.databaseVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            // v1→v2: Features table redesigned (removed site/trench/excavator/notes,
            // added rubiconCode/license; area made nullable).
            // Drawings table: added drawingType and facing columns.
            await m.drop(featuresTable);
            await m.createTable(featuresTable);
            await m.addColumn(drawingsTable, drawingsTable.drawingType);
            await m.addColumn(drawingsTable, drawingsTable.facing);
          }
          if (from < 3) {
            // v2→v3: Projects introduced. Features now reference a project.
            // rubiconCode and license moved from features to projects.
            // NOTE: existing rubiconCode/license data in the SQLite file is
            // preserved in the raw DB but no longer accessed by the app.
            await m.createTable(projectsTable);
            await m.addColumn(featuresTable, featuresTable.projectId);
            // rubicon_code and license columns remain in SQLite but are no longer
            // part of the Drift table class — they become inert dead columns.
          }
        },
        beforeOpen: (OpeningDetails details) async {
          // Enable foreign keys enforcement
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.databaseFileName));
    return NativeDatabase.createInBackground(file);
  });
}
