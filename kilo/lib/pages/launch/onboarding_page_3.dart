import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({required this.onNext});

  final VoidCallback onNext;
  @override
  Widget build(BuildContext context) {
    final screenSize = window.physicalSize;
    double height = screenSize.height / 22;
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: height,
            ),
            SvgPicture.asset(
              'images/4.svg',
              // height: 219,
              // width: 166,
            ),
            Container(
              width: 290,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Следи за обновлениями',
                    style: TextStyle(
                        fontFamily: 'SFMedium',
                        fontSize: 24,
                        color: Color.fromRGBO(24, 23, 37, 1)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Подписывайся на категории товаров и избранных продавцов',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: false,
                    style: TextStyle(
                        fontFamily: 'SFMedium',
                        fontSize: 20,
                        color: Color.fromRGBO(63, 63, 63, 1)),
                  )
                ],
              ),
            ),
          ]),
        ),
      ],
    ));
  }
}
