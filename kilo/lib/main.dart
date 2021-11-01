import 'package:flutter/material.dart';
import 'package:kilo/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(KiloApp());
}

class KiloApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        //localizationsDelegates: [],
        //supportedLocales: <Locale>[Locale('ru')],
        debugShowCheckedModeBanner: false,
        title: 'Kilo',
        theme: null,
        initialRoute: Routes.home,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
