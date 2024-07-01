// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDetail {
  final String name;
  final String userId;
  UserDetail({
    required this.name,
    required this.userId,
  });

  UserDetail copyWith({
    String? name,
    String? userId,
  }) {
    return UserDetail(
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(
      name: map['name'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetail.fromJson(String source) =>
      UserDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserDetail(name: $name, userId: $userId)';

  @override
  bool operator ==(covariant UserDetail other) {
    if (identical(this, other)) return true;

    return other.name == name && other.userId == userId;
  }

  @override
  int get hashCode => name.hashCode ^ userId.hashCode;
}
