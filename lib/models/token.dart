class Token {
  final String token;
  final String refreshToken;

  Token({
    required this.token,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json["token"],
      refreshToken: json["refreshToken"],
    );
  }
}
