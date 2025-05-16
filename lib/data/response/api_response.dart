import 'package:roamsavvy/data/response/status.dart';

class Apiresponse<T> {
  final Status status;
  final T? data;
  final String? message;

  Apiresponse._({required this.status, this.data, this.message});

  factory Apiresponse.loading() => Apiresponse._(status: Status.LOADING);

  factory Apiresponse.initial() => Apiresponse._(status: Status.initial);

  factory Apiresponse.completed(T data) =>
      Apiresponse._(status: Status.COMPLETE, data: data);

  factory Apiresponse.error(String message) =>
      Apiresponse._(status: Status.ERROR, message: message);

  @override
  String toString() {
    return 'Status: $status\nMessage: $message\nData: $data';
  }
}
