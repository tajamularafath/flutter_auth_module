import 'package:flutter/material.dart';

class AppFormValidation {

  static bool isConfirmPasswordValidate = false;


  /// Email field Validation
  static String? validateEmail(String? value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{3,3}))$');
    if(value == null || value.isEmpty){
      return 'Please enter email';
    } else if(!regex.hasMatch(value)){
      return 'Enter valid email';
    } else{
      return null;
    }
  }
  static String? passwordFieldEmpty(String? value){
    return value == null || value.isEmpty ?  'Please enter password':  null;
    }

  /// Password Fields Validation
  static String? validatePassword(String? value) {
    RegExp regExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    if(value == null || value.isEmpty){
      return 'Please enter password';
    } else if(!regExp.hasMatch(value)){
      return 'Enter valid password';
    } else{
      return null;
    }
  }

  /// Password field validation
  static String? passwordValidation(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 8) {
      return 'Password must have minimum 8 characters';
    } else if (!regex.hasMatch(value)) {
      return 'Password must have one capital letter and\none special character';
    } else {
      return null;
    }
  }

  /// ConfirmPassword field validation.
  static String? confirmPasswordValidation(String? value, TextEditingController password) {
    if (value!.isEmpty) {
      isConfirmPasswordValidate = false;
      return 'Please enter confirm new password';
    } else if (password.text != value) {
      isConfirmPasswordValidate = false;
      return 'Passwords not matched';
    } else {
      isConfirmPasswordValidate = true;
      return null;
    }
  }

  /// Old password field validation
  static String? oldPasswordValidation(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter old password';
    } else if (value.length < 8) {
      return 'Password must have minimum 8 characters';
    } else if (!regex.hasMatch(value)) {
      return 'Password must have one capital letter and\none special character';
    } else {
      return null;
    }
  }

  /// Full Name field validation
  static String? fullNameFieldEmpty(String? data) {
    return data!.isEmpty ? "Please Enter Full Name" : null;
  }

  /// Mobile field validation
  static String? mobileValidation(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  /// Address 1 Name validation
  static String? addressOneValidation(String? data) {
    if (data!.isEmpty) {
      return 'Please enter address';
    } else if (data.length < 8) {
      return 'Please enter valid address';
    } else {
      return null;
    }
  }
  /// Address 2 Name validation
  static String? addressTwoValidation(String? data) {
    if (data!.isEmpty) {
      return 'Please enter address';
    } else {
      return null;
    }
  }
  /// State validation
  static String? stateValidation(String? data) {
    if (data!.isEmpty) {
      return 'Please enter state';
    } else if (data.length < 2) {
      return 'Please enter valid state';
    } else {
      return null;
    }
  }
  /// City validation
  static String? cityValidation(String? data) {
    if (data!.isEmpty) {
      return 'Please enter city';
    } else if (data.length < 3) {
      return 'Please enter valid city';
    } else {
      return null;
    }
  }
  /// PinCode validation
  static String? pinCodeValidation(String? data) {
    if (data!.isEmpty) {
      return 'Please enter postal code';
    } else if (data.length < 6 || data.length > 6) {
      return 'Please enter valid postal code';
    } else {
      return null;
    }
  }
  /// Comment
  static String? commentValidation(String? data) {
    if (data!.isEmpty) {
      return 'Please enter message';
    } else {
      return null;
    }
  }


  static String? validateResidencyType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a residence type';
    }
    return null;
  }

}