class Repository {
  final String name;
  final String owner;
  final String avatarUrl;

  Repository({
    required this.name,
    required this.owner,
    required this.avatarUrl,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'] ?? 'Repo Unavailable',
      owner: json['owner']['login'] ?? 'Unavailable',
      avatarUrl: json['owner']['avatar_url'] ?? 'https://via.placeholder.com/150',
    );
  }
}

