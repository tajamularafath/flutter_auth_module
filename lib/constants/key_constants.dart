import 'package:authication_module/constants/image_names.dart';

const int requestTimeOut = 1;
final List<String> residenceName = ['Home', 'Office', 'Other'];
final List<String> residenceIcon = [
  ImageNames.icHome2,
  ImageNames.icOffice,
  ImageNames.icLocation,
];
final List<String> residenceKey = ['1', '2', '3'];

String setResidencyType(String value) {
  switch (value) {
    case 'Home':
      return '1';
    case 'Office':
      return '2';
    default:
      return '3';
  }
}

String getResidencyType(String? value) {
  switch (value) {
    case '1':
      return 'Home';
    case '2':
      return 'Office';
    default:
      return 'Other';
  }
}

String setDefaultAddress(bool value) {
  switch (value) {
    case true:
      return '1';
    default:
      return '0';
  }
}

bool getDefaultAddress(String value) {
  switch (value) {
    case '1':
      return true;
    default:
      return false;
  }
}