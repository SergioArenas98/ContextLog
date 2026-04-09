import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/project_repository.dart';
import '../../domain/models/project_model.dart';
import '../../domain/validators/project_validator.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository(ref.watch(databaseProvider));
});

final projectValidatorProvider = Provider<ProjectValidator>((ref) {
  return const ProjectValidator();
});

/// All projects sorted by name.
final projectListProvider =
    AsyncNotifierProvider<ProjectListNotifier, List<ProjectModel>>(
  ProjectListNotifier.new,
);

class ProjectListNotifier extends AsyncNotifier<List<ProjectModel>> {
  @override
  Future<List<ProjectModel>> build() async {
    return ref.watch(projectRepositoryProvider).getAll();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(projectRepositoryProvider).getAll(),
    );
  }
}

/// Single project by id.
final projectDetailProvider =
    FutureProvider.family<ProjectModel?, String>((ref, id) async {
  return ref.watch(projectRepositoryProvider).getById(id);
});
