class Avatar {
  final String? url;
  final String? name;

  Avatar({this.url, this.name});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      url: json["url"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
      };
}
