import 'package:equatable/equatable.dart';

class NetworkResponse extends Equatable {
  const NetworkResponse({
    required this.payload,
    required this.message,
    required this.success,
  });
  final bool? success;
  final String? message;
  final dynamic payload;
  @override
  List<Object?> get props => [
        success,
        message,
        payload,
      ];
}
