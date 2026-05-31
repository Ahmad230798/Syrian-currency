// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileRequestBody _$EditProfileRequestBodyFromJson(
  Map<String, dynamic> json,
) => EditProfileRequestBody(
  fullName: json['full_name'] as String,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$EditProfileRequestBodyToJson(
  EditProfileRequestBody instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'avatar': instance.avatar,
};
