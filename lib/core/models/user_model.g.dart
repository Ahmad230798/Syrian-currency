// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  fullName: json['full_name'] as String,
  role: json['role'] as String,
  avatar: json['avatar'] as String?,
  dateJoined: json['date_joined'] as String,
  tierLevel: (json['tier_level'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'full_name': instance.fullName,
  'role': instance.role,
  'avatar': instance.avatar,
  'date_joined': instance.dateJoined,
  'tier_level': instance.tierLevel,
};
