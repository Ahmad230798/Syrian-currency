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
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
