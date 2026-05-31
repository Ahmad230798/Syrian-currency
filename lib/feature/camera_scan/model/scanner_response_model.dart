import 'package:json_annotation/json_annotation.dart';

part 'scanner_response_model.g.dart';

@JsonSerializable()
class ScannerResponseModel {
  final bool success;
  final String? message;
  final ScanDataModel? data;

  ScannerResponseModel({required this.success, this.message, this.data});

  factory ScannerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ScannerResponseModelFromJson(json);
}

@JsonSerializable()
class ScanDataModel {
  final int id;
  final String image;
  final String? heatmap;
  @JsonKey(name: 'heatmap_url')
  final String? heatmapUrl;
  final String status;
  final String result;

  @JsonKey(name: 'mse_score')
  final double? mseScore;
  final double? threshold;
  final double? confidence;
  @JsonKey(name: 'is_genuine')
  final bool isGenuine;
  final String? notes;
  @JsonKey(name: 'created_at')
  final String createdAt;

  ScanDataModel({
    required this.id,
    required this.image,
    this.heatmap,
    this.heatmapUrl,
    required this.status,
    required this.result,
    this.mseScore,
    required this.threshold,
    this.confidence,
    required this.isGenuine,
    this.notes,
    required this.createdAt,
  });

  factory ScanDataModel.fromJson(Map<String, dynamic> json) =>
      _$ScanDataModelFromJson(json);
}
