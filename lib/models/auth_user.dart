class AuthUser {
  static const String collectionName = 'users_collection';
  String? id;
  String? email;

  AuthUser({required this.id, required this.email});

  /// From Firestore
  AuthUser.fromJson(Map<String, dynamic>? jsonData)
      : this(
          id: jsonData?['id'] as String,
          email: jsonData?['email'] as String,
        );

  /// To Firestore
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email};
  }
}
