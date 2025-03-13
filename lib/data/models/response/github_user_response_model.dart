import 'package:equatable/equatable.dart';
import 'package:weighted_auto_complete_search/data/data_sources/local/constants/local_constants.dart';

class GithubUserResponseModel extends Equatable {
  final String? userName;
  final String? name;
  final int? id;
  final String? avatarUrl;
  final String? profileUrl;
  final int? publicReposCount;
  final DateTime? updatedAt;
const  GithubUserResponseModel({
    required this.name,
    required this.id,
    required this.avatarUrl,
    required this.profileUrl,
    required this.publicReposCount,
    required this.updatedAt,
    required this.userName,
  });

  factory GithubUserResponseModel.fromJson(Map<String, dynamic>? json) {
    return GithubUserResponseModel(
      userName: json?['login'],
      name: json?['name'],
      id: json?['id'],
      avatarUrl: json?['avatar_url'],
      profileUrl: json?['html_url'],
      publicReposCount: json?['public_repos'],
      updatedAt: DateTime.tryParse(
        json?['updated_at']?.toString() ?? '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': userName,
      'name': name,
      'id': id,
      'avatar_url': avatarUrl,
      'html_url': profileUrl,
      'public_repos': publicReposCount,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        userName,
        name,
        id,
        avatarUrl,
        profileUrl,
        publicReposCount,
        updatedAt,
      ];
}
