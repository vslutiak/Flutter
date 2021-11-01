import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../routes.dart';

class Done extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:Container(
      decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/background.png'))),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            const SizedBox(height:60,),
          Expanded(flex: 1,child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset('images/done.svg'),
            const SizedBox(width: 25)
            ],)),
           //  const SizedBox(height:10,),
        Text('Ваш заказ принят!', style:  TextStyle(
          color: Colors.black,
          decoration: TextDecoration.none,
          fontSize: 28,
          fontWeight: FontWeight.w500
        ),),
        const SizedBox(height: 15,),
        Text('Ожидайте подтверждения продавца', 
        
        style:  TextStyle(
          color: Color.fromRGBO(124, 124, 124, 1),
          
          decoration: TextDecoration.none,
          fontSize: 16,
          fontWeight: FontWeight.w500
        )
        ),
        Expanded(
          flex: 1,
          child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(Routes.main, arguments: true);
                            },
                            child:
                              Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Text(
                                  'Вернуться на главную',

                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            
                          ))),
                           const SizedBox(height: 25,),
        
        ],
    ),

    ));
  }
  
}