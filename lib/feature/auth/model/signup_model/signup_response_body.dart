import 'package:json_annotation/json_annotation.dart';
part 'signup_response_body.g.dart';

@JsonSerializable()
class SignupResponseBody {
  final String email;
  @JsonKey(name: 'full_name')
  final String fullName;
  SignupResponseBody({required this.email, required this.fullName});
  factory SignupResponseBody.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseBodyFromJson(json);
}
