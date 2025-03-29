import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Provider/repository_provider.dart';

class RepositorySearchScreen extends ConsumerStatefulWidget {
  const RepositorySearchScreen({super.key});

  @override
  ConsumerState<RepositorySearchScreen> createState() => _RepositorySearchScreenState();
}

class _RepositorySearchScreenState extends ConsumerState<RepositorySearchScreen> {
  final TextEditingController searchField = TextEditingController();
  String currentUser = '';


  void _search() {
    final username = searchField.text.trim();
    if (username.isNotEmpty) {
      currentUser = username;
      ref.read(repositoryProvider.notifier).fetchRepositories(username);
    }


  @override
  Widget build(BuildContext context) {

    final repoState = ref.watch(repositoryProvider);
    return Scaffold(
      appBar: AppBar(
      title: Text("Search Repository"),


    );
  }
}
