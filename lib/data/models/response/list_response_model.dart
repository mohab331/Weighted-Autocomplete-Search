class ListResponseModel<T> {
  final List<T> items;

  ListResponseModel({
    required this.items,
  });

  factory ListResponseModel.fromJson(
    List? list,
    T Function(Map<String, dynamic>?) fromJsonFunc,
  ) {
    final items = list?.map((item) => fromJsonFunc(item)).toList() ?? [];
    return ListResponseModel<T>(items: items);
  }
}
