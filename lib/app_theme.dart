import 'package:flutter/material.dart';

class KAppColors extends ThemeExtension<KAppColors> {
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final Color unselectionColor;

  const KAppColors({
    required this.backgroundColor,
    required this.buttonColor,
    required this.textColor,
    required this.unselectionColor,
  });

  @override
  KAppColors copyWith({
    Color? backgroundColor,
    Color? buttonColor,
    Color? textColor,
    Color? unselectionColor,
  }) {
    return KAppColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonColor: buttonColor ?? this.buttonColor,
      textColor: textColor ?? this.textColor,
      unselectionColor: unselectionColor ?? this.unselectionColor,
    );
  }

  @override
  KAppColors lerp(ThemeExtension<KAppColors>? other, double t) {
    if (other is! KAppColors) {
      return this;
    }
    return KAppColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? other.backgroundColor,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t) ?? other.buttonColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? other.textColor,
      unselectionColor: Color.lerp(unselectionColor, other.unselectionColor, t) ?? other.unselectionColor,
    );
  }
}

class AppTheme {
  static KAppColors? colors(BuildContext context) => Theme.of(context).extension<KAppColors>();

  static ThemeData get light => ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          KAppColors(
            backgroundColor: Color(0xFFFFFFFF),
            buttonColor: Colors.grey.shade100,
            textColor: Colors.black,
            unselectionColor: Color(0xff6B6F80),
          ),
        ],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xff6982FF),
          secondary: Color(0xff242424),
          tertiary: Color(0xff6B6F80),
        ),
      );

  static ThemeData get dark => ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          KAppColors(
            backgroundColor: Color(0xFFFFFFFF),
            buttonColor: ThemeData.dark().scaffoldBackgroundColor,
            textColor: Colors.white,
            unselectionColor: Colors.white,
          ),
        ],
      );
}
