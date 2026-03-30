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
import '../../features/sample/data/tables/samples_table.dart';

part 'app_database.g.dart';

/// Main Drift database for ContextLog.
/// All tables are registered here and the database is opened via [openConnection].
@DriftDatabase(
  tables: [
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
          // Future migrations go here
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
