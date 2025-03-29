class Repository {
  String login;
  int? id;
  String? nodeId;
  String avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  String? userViewType;
  bool? siteAdmin;

Repository({
    required this.login,
    this.id,
    this.nodeId,
    required this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    required this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.userViewType,
    this.siteAdmin,
  });




factory Repository.fromJson(Map<String, dynamic> json) => Repository(
  avatarUrl: json["avatar_url"],
  login: json["login"],
  reposUrl: json["repos_url"]
);

Map<String, dynamic> toJson()=>{
  "avatar_url":avatarUrl,
  "login":login,
  "repos_url":reposUrl
};

}