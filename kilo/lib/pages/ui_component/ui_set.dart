import 'package:flutter/material.dart';
import 'package:kilo/models/setting.dart';

class Set extends StatefulWidget{
  Set({required this.settings});
  final Settings settings;
  @override
  _SetState createState() => _SetState();


}

class _SetState extends State<Set> {
  bool _one = false;
  bool _two = false;
  bool _1 = false;
  bool _2 = false;
  bool _3 = false;
   double _value = 0.0;
  @override
  void initState() {
    super.initState();
    widget.settings.type.forEach((element) {
      if(element == 'post'){
        _2 = true;
     }
    if(element == 'deliver'){
       _3 = true;
     }
     if (element == 'pickup'){
      _1 = true;
     }
  });
  }
  @override
  Widget build(BuildContext context) {
    return  Column(children: [
       Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Тип доставки',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_one) {
                                _one = false;
                              } else
                                _one = true;
                            });
                          },
                          icon: !_one
                              ? Icon(Icons.navigate_next)
                              : Icon(Icons.expand_less))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Visibility(
                      visible: _one,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_1) {
                                        _1 = false;
                                      } else
                                        _1 = true;
                                    });
                                  },
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: _1
                                            ? Color.fromRGBO(106, 175, 63, 1)
                                            : Colors.white,
                                        border: Border.all(
                                            color: _1
                                                ? Color.fromRGBO(
                                                    106, 175, 63, 1)
                                                : Colors.grey,
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                      ),
                                      child: _1
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 15,
                                            )
                                          : SizedBox())),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Самовывоз',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_2) {
                                      _2 = false;
                                    } else
                                      _2 = true;
                                  });
                                },
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: _2
                                          ? Color.fromRGBO(106, 175, 63, 1)
                                          : Colors.white,
                                      border: Border.all(
                                          color: _2
                                              ? Color.fromRGBO(106, 175, 63, 1)
                                              : Colors.grey,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                    child: _2
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 15,
                                          )
                                        : SizedBox())),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Отправка почтой',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ]),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_3) {
                                      _3 = false;
                                    } else
                                      _3 = true;
                                  });
                                },
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: _3
                                          ? Color.fromRGBO(106, 175, 63, 1)
                                          : Colors.white,
                                      border: Border.all(
                                          color: _3
                                              ? Color.fromRGBO(106, 175, 63, 1)
                                              : Colors.grey,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                    child: _3
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 15,
                                          )
                                        : SizedBox())),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Доставим',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ]),
                          const SizedBox(
                            height: 25,
                          ),
                          Visibility(
                              visible: _1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Укажите радиус",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      child: SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor:
                                                Color.fromRGBO(106, 175, 63, 1),
                                            inactiveTrackColor: Colors.grey,
                                            trackShape:
                                                RectangularSliderTrackShape(),
                                            trackHeight: 4.0,
                                            thumbColor: Colors.white,
                                            // thumbShape: RoundSliderThumbShape(
                                            //     enabledThumbRadius: 12.0),
                                            overlayColor:
                                                Color.fromRGBO(106, 175, 63, 1),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                                    overlayRadius: 5.0),
                                          ),
                                          child: Slider(
                                            min: 0,
                                            max: 100,
                                            value: _value,
                                            onChanged: (value) {
                                              setState(() {
                                                _value = value;
                                              });
                                            },
                                          ))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${_value.toStringAsFixed(0)} км",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        ],
                      )),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Период продажи',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_two) {
                                _two = false;
                              } else
                                _two = true;
                            });
                          },
                          icon: !_two
                              ? Icon(Icons.navigate_next)
                              : Icon(Icons.expand_less))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
    ],);
          
  }

  
}