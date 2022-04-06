class CreateConversation {
  final String conversationId;
  final bool isExists;

  CreateConversation({
    required this.conversationId,
    required this.isExists,
  });

  factory CreateConversation.fromeJson(Map<String, dynamic> json) {
    return CreateConversation(
      conversationId: json["conversationId"],
      isExists: json["isExists"],
    );
  }

  Map<String, dynamic> toJson() => {
        "conversationId": conversationId,
        "isExists": isExists,
      };
}
