class GithubUserDetailsEndpoints {
  static String userDetailsEndpoint({
    required String? userName,
  }) =>
      'users/$userName';
}
