import 'package:json_annotation/json_annotation.dart';
part 'signup_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  final String email;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String password;
  SignupRequestBody({
    required this.email,
    required this.fullName,
    required this.password,
  });
  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}
