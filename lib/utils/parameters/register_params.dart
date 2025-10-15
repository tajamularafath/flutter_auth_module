class RegisterParam{
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final String fullName;
  final String countryCode;

  RegisterParam({required this.fullName, required this.countryCode, required this.firstName, required this.lastName, required this.email, required this.confirmPassword, required this.phone, required this.password});
}