import 'package:flutter/material.dart';

class TextStyles {
  //TextStyle? _getDisplayLarge(context) => Theme.of(context).textTheme.displayLarge;

  //TextStyle? _getDisplayMedium(context) => Theme.of(context).textTheme.displayMedium;

  //TextStyle? _getDisplaySmall(context) => Theme.of(context).textTheme.displaySmall;

  TextStyle? _getHeadlineLarge(context) => Theme.of(context).textTheme.headlineLarge;

  TextStyle? _getHeadlineMedium(context) => Theme.of(context).textTheme.headlineMedium;

  TextStyle? _getHeadlineSmall(context) => Theme.of(context).textTheme.headlineSmall;

  TextStyle? _getTitleLarge(context) => Theme.of(context).textTheme.titleLarge;

  TextStyle? _getTitleMedium(context) => Theme.of(context).textTheme.titleMedium;

  TextStyle? _getTitleSmall(context) => Theme.of(context).textTheme.titleSmall;

  TextStyle? _getLabelLarge(context) => Theme.of(context).textTheme.labelLarge;

  TextStyle? _getLabelMedium(context) => Theme.of(context).textTheme.labelMedium;

  TextStyle? _getLabelSmall(context) => Theme.of(context).textTheme.labelSmall;

  TextStyle? _getBodyLarge(context) => Theme.of(context).textTheme.bodyLarge;

  TextStyle? _getBodyMedium(context) => Theme.of(context).textTheme.bodyMedium;

  TextStyle? _getBodySmall(context) => Theme.of(context).textTheme.bodySmall;

  /// this file is used to define custom text style.
  /// the above is the base config settings for font style and we customize using copyWith() method and re-using the style.
  /// Syntax:
  /// TextStyle MethodName (context) => getParentStyle(context)!.copyWith( Customize Settings )

  /// headText1 -> TitleLarge
  TextStyle? headText1(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getTitleLarge(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// headText2 -> TitleMedium
  TextStyle? headText2(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getTitleMedium(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// headText3 -> TitleSmall
  TextStyle? headText3(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getTitleSmall(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// headTextCustom -> HeadlineLarge
  TextStyle? headTextCustom(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight,
        required double fontSize}) =>
      _getHeadlineLarge(context)!.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight);

  /// headText4 -> HeadlineMedium
  TextStyle? headText4(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getHeadlineMedium(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// headText5 -> HeadlineSmall
  TextStyle? headText5(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getHeadlineSmall(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// headText6 -> HeadlineLarge
  TextStyle? headText6(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getHeadlineLarge(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// subtitleText1 -> TitleMedium
  TextStyle? subtitleText1(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getTitleMedium(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// subtitleText2 -> TitleSmall
  TextStyle? subtitleText2(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getTitleSmall(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// bodyText1 -> BodyLarge
  TextStyle? bodyText1(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getBodyLarge(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// bodyText2 -> BodyMedium
  TextStyle? bodyText2(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getBodyMedium(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// caption -> BodySmall
  TextStyle? caption(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getBodySmall(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// buttonText -> LabelLarge
  TextStyle? buttonText(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getLabelLarge(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// labelCustom -> LabelMedium
  TextStyle? labelCustom(
      {required BuildContext context,
        required Color? color,
        required FontWeight fontWeight,
        required double fontSize}) =>
      _getLabelMedium(context)!.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight);

  /// overLineText -> LabelSmall
  TextStyle? overLineText(
      {required BuildContext context,
        Color? color,
        required FontWeight fontWeight}) =>
      _getLabelSmall(context)!.copyWith(
          color: color,
          fontWeight: fontWeight);

  /// Custom -> Customize
  TextStyle? custom({required BuildContext context,
    required Color? color, required double fontSize,
    required FontWeight fontWeight, TextDecoration? decoration}) =>
      _getLabelSmall(context)!.copyWith(
          fontFamily: 'Outfit',
          color: color,
          fontSize: fontSize,
          decoration: decoration,
          decorationColor: color,
          fontWeight: fontWeight);
}
