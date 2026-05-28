import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String email;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String role;
  String? avatar;
  @JsonKey(name: 'date_joined')
  final String dateJoined;
  @JsonKey(name: 'tier_level')
  int? tierLevel;
  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.avatar,
    required this.dateJoined,
    this.tierLevel,
  });
  UserModel copyWith({
    int? id,
    String? email,
    String? fullName,
    String? role,
    String? avatar,
    String? dateJoined,
    int? tierLevel,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      dateJoined: dateJoined ?? this.dateJoined,
      tierLevel: tierLevel ?? this.tierLevel,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
