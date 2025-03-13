import 'package:equatable/equatable.dart';

class BaseResponseModel<T> extends Equatable {
  const BaseResponseModel({
    required this.message,
    required this.model,
  });
  final String? message;
  final T model;

  @override
  List<Object?> get props => [
        message,
        model,
      ];
}
