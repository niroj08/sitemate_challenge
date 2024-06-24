class BaseResponseModel<T> {
  final bool status;
  final T data;

  BaseResponseModel({required this.status, required this.data});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      status: json.containsKey("status") ? json["status"] == "ok" : false,
      data: json.containsKey("articles") ? json["articles"] : [],
    );
  }
}
