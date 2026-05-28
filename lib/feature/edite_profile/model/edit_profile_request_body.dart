import 'package:json_annotation/json_annotation.dart';
part 'edit_profile_request_body.g.dart';

@JsonSerializable()
class EditProfileRequestBody {
  @JsonKey(name: "full_name")
  final String fullName;
  final String? avatar;

  EditProfileRequestBody({required this.fullName, required this.avatar});

  Map<String, dynamic> toJson() => _$EditProfileRequestBodyToJson(this);
}
