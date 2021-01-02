import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_share/social_share.dart';

class SecondScreen extends StatelessWidget {
  final String _url;

  SecondScreen({String url}) : _url = url;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text('Back')),
        body: Column(children: [
          Expanded(
              flex: 9,
              child: Image.network(
                _url,
                fit: BoxFit.fill,
              )),
          Expanded(
              flex: 1,
              child: FlatButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 16,
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: IconButton(
                                            icon: Icon(Icons.sms),
                                            onPressed: () {
                                              SocialShare.shareSms(_url);
                                            })),
                                    Expanded(
                                        child: IconButton(
                                            icon: Icon(Icons.face),
                                            onPressed: () {
                                              SocialShare.shareOptions(_url);
                                            })),
                                  ],
                                ),
                              ));
                        });
                  },
                  child: Text("Share")))
        ]));
  }
}
