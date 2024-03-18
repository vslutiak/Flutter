import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:random_color/background_color_service.dart';

void main() {
  group('BackgroundColorService Tests', () {
    test('Test getRandomRGBColor', () {
      final color = BackgroundColorService.getRandomRGBColor();
      expect(color, isInstanceOf<Color>());
    });

    test('Test getRandomARGBColor', () {
      final color = BackgroundColorService.getRandomARGBColor();
      expect(color, isInstanceOf<Color>());
    });

    test('Test isDarkColor with light color', () {
      const lightColor = Color(0xFFE0E0E0); // light gray color
      expect(BackgroundColorService.isDarkColor(lightColor), false);
    });

    test('Test isDarkColor with dark color', () {
      const darkColor = Color(0xFF303030); // dark gray color
      expect(BackgroundColorService.isDarkColor(darkColor), true);
    });
  });
}
