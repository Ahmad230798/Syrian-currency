// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScannerResponseModel _$ScannerResponseModelFromJson(
  Map<String, dynamic> json,
) => ScannerResponseModel(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : ScanDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScannerResponseModelToJson(
  ScannerResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

ScanDataModel _$ScanDataModelFromJson(Map<String, dynamic> json) =>
    ScanDataModel(
      id: (json['id'] as num).toInt(),
      image: json['image'] as String,
      heatmap: json['heatmap'] as String?,
      heatmapUrl: json['heatmap_url'] as String?,
      status: json['status'] as String,
      result: json['result'] as String,
      mseScore: (json['mse_score'] as num?)?.toDouble(),
      threshold: (json['threshold'] as num?)?.toDouble(),
      confidence: (json['confidence'] as num?)?.toDouble(),
      isGenuine: json['is_genuine'] as bool,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$ScanDataModelToJson(ScanDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'heatmap': instance.heatmap,
      'heatmap_url': instance.heatmapUrl,
      'status': instance.status,
      'result': instance.result,
      'mse_score': instance.mseScore,
      'threshold': instance.threshold,
      'confidence': instance.confidence,
      'is_genuine': instance.isGenuine,
      'notes': instance.notes,
      'created_at': instance.createdAt,
    };
