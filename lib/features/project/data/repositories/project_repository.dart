import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/models/project_model.dart';

/// Repository for CRUD operations on excavation projects.
class ProjectRepository {
  ProjectRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  /// Returns all projects sorted by name ascending.
  Future<List<ProjectModel>> getAll() async {
    final rows = await (_db.select(_db.projectsTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc),
          ]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  /// Returns a single project by [id], or null if not found.
  Future<ProjectModel?> getById(String id) async {
    final row = await (_db.select(_db.projectsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  /// Creates a new project.
  Future<ProjectModel> create({
    required String name,
    String? rubiconCode,
    String? licenceNumber,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    final companion = ProjectsTableCompanion.insert(
      id: id,
      name: name.trim(),
      rubiconCode: Value(rubiconCode?.trim().isNotEmpty == true ? rubiconCode!.trim() : null),
      licenceNumber: Value(licenceNumber?.trim().isNotEmpty == true ? licenceNumber!.trim() : null),
      createdAt: now,
      updatedAt: now,
    );
    await _db.into(_db.projectsTable).insert(companion);
    return (await getById(id))!;
  }

  /// Updates an existing project.
  Future<ProjectModel> update({
    required String id,
    required String name,
    String? rubiconCode,
    String? licenceNumber,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.projectsTable)..where((t) => t.id.equals(id))).write(
      ProjectsTableCompanion(
        name: Value(name.trim()),
        rubiconCode: Value(rubiconCode?.trim().isNotEmpty == true ? rubiconCode!.trim() : null),
        licenceNumber: Value(licenceNumber?.trim().isNotEmpty == true ? licenceNumber!.trim() : null),
        updatedAt: Value(now),
      ),
    );
    return (await getById(id))!;
  }

  /// Deletes a project by [id].
  Future<void> delete(String id) async {
    await (_db.delete(_db.projectsTable)..where((t) => t.id.equals(id))).go();
  }

  ProjectModel _rowToModel(ProjectsTableData row) => ProjectModel(
        id: row.id,
        name: row.name,
        rubiconCode: row.rubiconCode,
        licenceNumber: row.licenceNumber,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
