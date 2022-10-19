import 'package:flutter_test/flutter_test.dart';
import 'package:test_screen/main_page.dart';

void main() {
  test('Check empty list', () {
    List<String> list = [];

    final page = MainPage(
      list: list,
    );

    expect(page.list, list);
  });
  test('Check full list', () {
    final List<String> list = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      'Item 7',
      'Item 8',
      'Item 9',
      'Item 10',
      'Item 11',
      'Item 12',
      'Item 13',
      'Item 14',
      'Item 15',
      'Item 16',
      'Item 15',
      'Item 16',
      'Item 14',
      'Item 15',
      'Item 16',
      'Item 15',
      'Item 16',
      'Item 14',
      'Item 15',
      'Item 16',
      'Item 15',
      'Item 16',
    ];

    final page = MainPage(
      list: list,
    );

    expect(page.list, list);
  });
}
