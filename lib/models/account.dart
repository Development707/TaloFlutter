class Account {
  final String username;
  final String password;

  Account({
    required this.username,
    required this.password,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json["username"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  static List<Account> listFromJsonArray(List<dynamic> list) =>
      List<Account>.from(list.map((acc) => Account.fromJson(acc)));
}
