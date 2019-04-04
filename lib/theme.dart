import 'package:flutter/material.dart';

final ThemeData broTheme = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
  //
  primaryColor: BroColors.primaryLight,
  bottomAppBarColor: BroColors.primaryGreen,
);

class BroColors {
  BroColors._();

  static Color primaryLight = Color(0xFFF6F6F6);
  static Color primaryGreen = Color(0xFF256600);
  static Color darkGreyPrimaryText = Color(0xFFE5E5E5);
}

// class ArchSampleTheme {
//   static get theme {
//     final originalTextTheme = ThemeData.dark().textTheme;
//     final originalBody1 = originalTextTheme.body1;

//     return ThemeData.dark().copyWith(
//         primaryColor: Colors.grey[800],
//         accentColor: Colors.cyan[300],
//         buttonColor: Colors.grey[800],
//         textSelectionColor: Colors.cyan[100],
//         backgroundColor: Colors.grey[800],
//         toggleableActiveColor: Colors.cyan[300],
//         textTheme: originalTextTheme.copyWith(
//             body1:
//                 originalBody1.copyWith(decorationColor: Colors.transparent)));
//   }
// }
