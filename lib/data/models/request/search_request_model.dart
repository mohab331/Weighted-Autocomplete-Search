import 'package:equatable/equatable.dart';

class SearchRequestModel extends Equatable {
  const SearchRequestModel({
    required this.query,
  });
  final String? query;

  Map<String, dynamic> toJson() {
    return {
      'q': query,
    };
  }

  @override
  List<Object?> get props => [
        query,
      ];
}
