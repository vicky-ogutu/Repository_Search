

//provider for repo service

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repo_app/Models/repository.dart';
import 'package:repo_app/Service/repository_service.dart';

final repositoryServiceProvider =Provider<RepositoryService>((ref) => RepositoryService());

// Provider for repository state management

final repositoryProvider = StateNotifierProvider<RepositoryNotifier, AsyncValue<List<Repository>>>(
      (ref) => RepositoryNotifier(ref),
);

class RepositoryNotifier extends StateNotifier<AsyncValue<List<Repository>>> {
  RepositoryNotifier(this.ref) : super(const AsyncValue.data([]));

  final Ref ref;
  int page = 1;
  bool hasMore = true;

  Future<void> fetchRepositories(String username, {bool loadMore = false}) async {
    if (state.isLoading || (!hasMore && loadMore)) return;

    try {
      if (!loadMore) {
        page = 1;
        hasMore = true;
      }

      final service = ref.read(repositoryServiceProvider);
      final fetchedRepos = await service.fetchRepositories(username, page, 10);

      if (fetchedRepos.length < 10) {
        hasMore = false;
      }

      state = AsyncValue.data(loadMore ? [...state.value!, ...fetchedRepos] : fetchedRepos);

      if (loadMore) page++;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}