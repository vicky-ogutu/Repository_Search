import 'dart:convert';

import 'package:repo_app/Models/repository.dart';
import 'package:repo_app/Utils/constants.dart';
import 'package:http/http.dart' as http;

class RepositoryService{
  Future<List<Repository>> fetchRepo(String username, int page, int per_page) async{

    final url = Uri.parse('${Constants.baseURL}/$username/repos?page=$page&per_page=$per_page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((repo) => Repository.fromJson(repo)).toList();
    } else {
      throw Exception('Failed to fetch repositories');
    }
  }

}
