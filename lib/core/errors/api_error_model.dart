import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final bool? success;
  final String? message;
  final Map<String, List<String>>? errors;
  ApiErrorModel(this.errors, this.message, this.success);
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
  String get primaryErrorMessage {
    if (errors != null && errors!.isNotEmpty) {
      for (var entry in errors!.entries) {
        if (entry.value.isNotEmpty) {
          return entry.value.first;
        }
      }
    }
    if (message != null && message!.isNotEmpty) {
      return message!;
    }
    return "حدث خطأ غير معروف، يرجى المحاولة لاحقاً.";
  }
}
