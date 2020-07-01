import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  return (runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      // routes: {
      //   '/': (BuildContext context) => ListImg(),
      //   '/second': (BuildContext context) => SecondScreen()
      // },
      home: Scaffold(
        appBar: AppBar(title: Text('Gallery')),
        body: ListImg(),
      ),
    ),
  ));
}

class ListImg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListImgState();
}

class _ListImgState extends State<ListImg> {
  List data;
  String secretKey = 'yRtNMGn7X0di_d7YaGVh7kGI9BuoJoLE1EDP0PP0jRI';

  @override
  void initState() {
    super.initState();
    this.getphoto();
  }

  // ignore: missing_return
  Future<String> getphoto() async {
    try {
      var response = await http.get(
          'https://api.unsplash.com/search/photos?per_page=30&query=random&client_id=$secretKey');
      setState(() {
        var converted = json.decode(response.body);
        data = converted['results'];
      });
    } catch (e) {
      print('error json');
      return 'success';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SecondScreen(
                                        imgUrl: data[index]['urls']['regular'],
                                      ),
                                    ));
                              },
                              child: Image.network(data[index]['urls']['small'],
                                  width: MediaQuery.of(context).size.width)),
                          Text(data[index]['user']['name']),
                          Text(data[index]['description'] == null
                              ? ''
                              : data[index]['description'])
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

// ignore: must_be_immutable
class SecondScreen extends StatelessWidget {
  String _imgUrl;

  SecondScreen({String imgUrl}) : _imgUrl = imgUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Back')),
        body: Center(
          child: CachedNetworkImage(
            imageUrl: _imgUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ));
  }
}
