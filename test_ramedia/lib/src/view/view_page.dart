import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'container.dart';

@RoutePage()
class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Tests());
  }
}
