enum NetworkRequestTypeEnum {
  POST(value: 'POST'),
  GET(value: 'GET'),
  PUT(value: 'PUT'),
  DELETE(value: 'DELETE');

  const NetworkRequestTypeEnum({
    required this.value,
  });

  final String value;
}
