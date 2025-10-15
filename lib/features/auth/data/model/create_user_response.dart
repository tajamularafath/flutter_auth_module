import 'package:equatable/equatable.dart';

class CreateUserResponse extends Equatable{
  final int? status;
  final String? message;
  final String? error;
  final String? errorDescription;

  const CreateUserResponse({this.status, this.message, this.error, this.errorDescription});

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
        status: json['status'].toInt(),
        message: json['message'],
        error: json['error'],
        errorDescription: json['error_description']
    );
  }

  @override
  List<Object?> get props => [status,message, error, errorDescription];

}
