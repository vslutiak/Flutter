import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final List<String> list;
  const MainPage({Key? key, required this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ///calculate height gridview container
    int size = (list.length / 2).round();
    double height =
        (MediaQuery.of(context).size.width - 30) / 2; //width one block
    height = height / 4; //height one block
    height = height * size;
    height = height + (10 * (size + 1)) + 1; //height сonsideren padding

    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 30, bottom: 20),
                    child: Image.asset("assets/logo.png"),
                  )),
                  SizedBox(height: height, child: grid(context)),
                ]),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget grid(BuildContext context) {
    return GridView.builder(
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 1,
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
          child: Text(
            list[index],
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }
}
