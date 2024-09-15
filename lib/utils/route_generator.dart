import 'package:codebar/pages/home_page.dart';
import 'package:codebar/pages/qrcode.dart';
import 'package:codebar/pages/qrcode_scanner.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case '/generate':
        return MaterialPageRoute(
            builder: (_) => QrGeneratorScreen(),
            settings: settings
        );
      case '/scan':
        return MaterialPageRoute(
            builder: (_) => const QrScannerScreen(),
            settings: settings
        );
      default: ///Home
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
            settings: settings
        );
    }
  }
}