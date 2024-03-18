import 'dart:math';
import 'dart:ui';

class BackgroundColorService {
  /// Returns a random color with full opacity 16,777,215 colors
  static Color getRandomRGBColor() {
    return Color(Random().nextInt(0xFFFFFF + 1)).withOpacity(1.0);
  }

  /// Returns a random color with full opacity 4,294,967,295 colors
  static Color getRandomARGBColor() {
    return Color(Random().nextInt(0xFFFFFFFF + 1));
  }

  static bool isDarkColor(Color color) {
    // Calculate brightness of the color
    double brightness =
        (color.red * 299 + color.green * 587 + color.blue * 114) *
            color.alpha /
            (1000 * 255);
    // If brightness is less than 128, it's a dark color
    return brightness < 128;
  }
}
