class ApiResponse<T> {
  ApiResponse({this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic>)? parser,
  }) {
    return ApiResponse(
      data: parser != null ? parser(json) : null,
    );
  }
  T? data;
}
