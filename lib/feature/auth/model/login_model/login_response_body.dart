import 'package:json_annotation/json_annotation.dart';
part 'login_response_body.g.dart';
@JsonSerializable()
class LoginResponseBody {
  final String refresh;
  final String access;
  LoginResponseBody({required this.access, required this.refresh});
  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);
}
