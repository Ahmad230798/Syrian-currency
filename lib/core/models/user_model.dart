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

  // 👈 الحقول الجديدة التي يرسلها الباك إند
  @JsonKey(name: 'total_scans')
  final int? totalScans;

  @JsonKey(name: 'genuine_scans')
  final int? genuineScans;

  @JsonKey(name: 'counterfeit_scans')
  final int? counterfeitScans;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.avatar,
    required this.dateJoined,
    this.tierLevel,
    this.totalScans, // 👈 إضافة للـ Constructor
    this.genuineScans, // 👈 إضافة للـ Constructor
    this.counterfeitScans, // 👈 إضافة للـ Constructor
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? fullName,
    String? role,
    String? avatar,
    String? dateJoined,
    int? tierLevel,
    int? totalScans,
    int? genuineScans,
    int? counterfeitScans,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      dateJoined: dateJoined ?? this.dateJoined,
      tierLevel: tierLevel ?? this.tierLevel,
      totalScans: totalScans ?? this.totalScans,
      genuineScans: genuineScans ?? this.genuineScans,
      counterfeitScans: counterfeitScans ?? this.counterfeitScans,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
