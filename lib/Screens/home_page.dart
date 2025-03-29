import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/repository.dart';
import '../Provider/repository_provider.dart';

class RepositorySearchScreen extends ConsumerStatefulWidget {
  const RepositorySearchScreen({super.key});

  @override
  ConsumerState<RepositorySearchScreen> createState() => _RepositorySearchScreenState();
}

class _RepositorySearchScreenState extends ConsumerState<RepositorySearchScreen> {
  final TextEditingController searchField = TextEditingController();
  String currentUser = '';


  void search() {
    final username = searchField.text.trim();
    if (username.isNotEmpty) {
      currentUser = username;
      ref.read(repositoryProvider.notifier).fetchRepositories(username);
    }
  }

  @override
  Widget build(BuildContext context) {

    final repoState = ref.watch(repositoryProvider);
    return Scaffold(
      appBar: AppBar(
      title: Text("Search Repository"),
    ),

      body:Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: searchField,
              decoration: InputDecoration(
                labelText: "Enter Github Username",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ),
              onSubmitted: (_) =>search(),
            ),
            const SizedBox(height: 8),
            Expanded(child: repoState.when(
                data: (data){
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){

                        if (index < data.length) {
                          final repo = data[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(repo.avatarUrl ?? "unknown image"),
                            ),
                            title: Text(repo.reposUrl ?? "unknown repo"),
                            subtitle: Text(repo.login ?? "unknown login"),
                          );
                        } else if (ref.read(repositoryProvider.notifier).hasMore) {
                          return TextButton(
                            onPressed: () => ref.read(repositoryProvider.notifier).fetchRepositories(currentUser, loadMore: true),
                            child: const Text('Load More'),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }

                      });
                },
                error: (error, stackTrace)=> Text(error.toString()),
                loading: ()=> const CircularProgressIndicator()))

          ],
        ),
      )

    );
  }
}
