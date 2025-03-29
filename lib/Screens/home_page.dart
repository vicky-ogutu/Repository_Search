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
    }else{
      throw Exception("Enter username");
    }
  }

  @override
  Widget build(BuildContext context) {
    final repoState = ref.watch(repositoryProvider);
    return Scaffold(
      appBar: AppBar(
      title: Text("Repository search screen"),
        backgroundColor: Theme.of(context).colorScheme.primary, // Uses seedColor (0xff2bb6aa)
        foregroundColor: Theme.of(context).colorScheme.onPrimary, // Ensures text/icons contrast well
    ),

      body:Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [

            TextField(
              controller: searchField,
              decoration: InputDecoration(
                labelText: "Enter username",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: search,  // Calls search function when clicked
                  icon: Container(
                    padding: const EdgeInsets.all(8), // Adds spacing inside the container
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,  // Background color
                      borderRadius: BorderRadius.circular(8),  // Rounded corners
                    ),
                    child: Image.asset(
                      "assets/icons/search_icon.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              onSubmitted: (_) => search(),
            ),

            const SizedBox(height: 8),
            Expanded(
              child: repoState.when(
                data: (data) {
                  if(data.isEmpty){
                    return const Center(child: Text("Search Repository."));
                  }


                  return ListView.builder(
                    itemCount: data.isNotEmpty && ref.read(repositoryProvider.notifier).hasMore ? data.length + 1 : data.length,
                    itemBuilder: (context, index) {
                      if (index < data.length) {
                        final repo = data[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(repo.avatarUrl ?? ""),
                          ),
                          title: Text(repo.name ?? "Unknown Repo"),
                          subtitle: Text(repo.owner ?? "Unknown User"),
                        );
                      } else if (ref.read(repositoryProvider.notifier).hasMore) {
                        return Center(
                          child: TextButton(
                            onPressed: () => ref.read(repositoryProvider.notifier).fetchRepositories(currentUser, loadMore: true),
                            child: const Text('Load More'),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),



          ],
        ),
      )

    );
  }
}
