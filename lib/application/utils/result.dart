import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  Result({
    required this.data,
    required this.message,
    required this.isSuccess,
  });

  final T data;
  final String message;
  final bool isSuccess;

  factory Result.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) => _$ResultToJson(this, toJsonT);
}
