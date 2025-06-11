class GetUserByFilterParams {
  final String filter;
  final String type;

  GetUserByFilterParams({required this.filter, required this.type})
    : assert(
        type == 'username' || type == 'email',
        'type must be email or username',
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'filter': filter, 'type': type};
  }
}
