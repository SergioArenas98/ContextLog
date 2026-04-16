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
          if (from < 4) {
            // v3→v4: Drawings table: added referenceImagePath for optional
            // per-drawing reference images stored as local file paths.
            await m.addColumn(drawingsTable, drawingsTable.referenceImagePath);
          }
          if (from < 5) {
            // v4→v5:
            // Finds: added optional localImagePath for attaching a photo.
            // Samples: added storageCount (default 1) to record units stored.
            // Contexts: composition and compaction are now stored as enum
            //   names (FillComposition / FillCompaction). The columns remain
            //   TEXT; existing NULL values stay NULL; any legacy free-text
            //   values are silently returned as null by the converter.
            await m.addColumn(findsTable, findsTable.localImagePath);
            await m.addColumn(samplesTable, samplesTable.storageCount);
          }
          if (from < 6) {
            // v5→v6: Features: added isNonArchaeological (BOOLEAN DEFAULT FALSE).
            // Existing rows default to false (archaeological).
            await m.addColumn(
                featuresTable, featuresTable.isNonArchaeological);
          }
          if (from < 7) {
            // v6→v7: Features: added featureType (TEXT DEFAULT 'standard').
            // Existing rows default to 'standard' (cut+fill recording).
            // 'spread' features allow fill-only recording without a parent cut.
            await m.addColumn(featuresTable, featuresTable.featureType);
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
