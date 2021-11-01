import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kilo/models/product.dart';
import 'package:kilo/pages/profile/profile.dart';
import 'package:kilo/pages/storage/storage.dart';
import 'package:kilo/pages/storage/streams.dart';
import 'package:kilo/pages/ui_component/product_card.dart';

import '../routes.dart';
import 'product/product_page.dart';

class MainPage extends StatefulWidget {
  MainPage({required this.token});
  final bool token;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  // late List<Product> product;
  late bool _token;
  void _onItemTapped(int index) {
    if (!_token) {
      Navigator.of(context).pushNamed(Routes.signIn);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  List<Product> ordersList = [];
  ScrollController _scrollController = ScrollController();
  int skip = 0;
  bool shouldLoadMore = true;
  late Future<List<Product>> future;
  @override
  void initState() {
    super.initState();
    _token = widget.token;
    future = Storages().getMainProducts(skip);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //Check whether user scrolled to last position
        if (shouldLoadMore) {
          setState(() {
            skip = 0;
            skip += ordersList.length;
            print(ordersList.length);
            print('Skip $skip');
            future = Storages().getMainProducts(skip); //load more data
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Future<List<Product>> check() async {
  //   _token = await sharedPreferenceService.token;
  //   // product = await Storages().getMainProducts(skip);

  //   return product;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: future,
        builder: (context, productSnapshot) {
          if (productSnapshot.hasData) {
            //final produc = productSnapshot.data;

            productSnapshot.data!.forEach((element) {
              if (!ordersList.contains(element)) {
                ordersList.add(element);
              }
            });
            //print(produc?.first.image);

            return Scaffold(
                backgroundColor: Colors.white,
                // extendBodyBehindAppBar: true,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  toolbarHeight: 1,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
                body: _selectedIndex == 4
                    ? Profile()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white
                                //Color.fromRGBO(243, 243, 243, 1)

                                ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Найдите продукты',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SFMedium',
                                        fontSize: 20,
                                        color: Color.fromRGBO(24, 23, 37, 1))),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: TextField(
                                      autofocus: false,
                                      controller: null,
                                      keyboardType: TextInputType.text,
                                      onChanged: null,
                                      textInputAction: TextInputAction.search,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(15),
                                              ),
                                              borderSide: BorderSide.none),
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(15),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      246, 248, 250, 1))),
                                          hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'SFMedium',
                                              color: Color(0xFF898989),
                                              fontWeight: FontWeight.w500),
                                          hintText: 'Поиск',
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 15, bottom: 15),
                                            child: SvgPicture.asset(
                                              'images/search.svg',
                                              width: 18,
                                              height: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          prefixStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                              fontSize: 18),
                                          fillColor:
                                              Color.fromRGBO(246, 248, 250, 1)),
                                    )),
                                    // const SizedBox(
                                    //   width: ,
                                    // ),
                                    IconButton(
                                        onPressed: () {
                                          print('s');
                                        },
                                        icon: SvgPicture.asset(
                                          'images/location.svg',
                                          width: 24,
                                          height: 24,
                                        )),
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                    child: Scrollbar(
                                        showTrackOnHover: false,
                                        //interactive: false,
                                        controller: _scrollController,
                                        isAlwaysShown: false,
                                        child: ListView(
                                          controller: _scrollController,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      "Подобрали для вас",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 24,
                                                          fontWeight: FontWeight
                                                              .w500))),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),

                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 200,
                                                      childAspectRatio: 1.5 / 2,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10),
                                              itemCount: ordersList.length + 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if (index ==
                                                    ordersList.length) {
                                                  print(ordersList.length);
                                                  return shouldLoadMore
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                      : Container();
                                                }
                                                return GestureDetector(
                                                    onTap: () {
                                                      Streams().addProduct(
                                                          ordersList[index].id);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProductPage(
                                                                      login:
                                                                          _token)));
                                                    },
                                                    child: ProductCard(
                                                      product:
                                                          ordersList[index],
                                                      callback: () {
                                                        Streams().addProduct(
                                                            ordersList[index]
                                                                .id);
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ProductPage(
                                                                        login:
                                                                            _token)));
                                                      },
                                                    ));
                                              },

                                              // color: Colors.black,
                                            )
                                          ],
                                        )))
                              ],
                            ))),
                bottomNavigationBar: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 92,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white70),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 3,
                              // offset: Offset(0, 5),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _onItemTapped(0);
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      child: SvgPicture.asset(
                                        'images/main.svg',
                                        color: _selectedIndex == 0
                                            ? Color.fromRGBO(106, 175, 63, 1)
                                            : Colors.grey,
                                      ),
                                    )),
                                Text('Главная',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SFMedium',
                                        fontSize: 10,
                                        color: _selectedIndex == 0
                                            ? Color.fromRGBO(106, 175, 63, 1)
                                            : Color.fromRGBO(124, 124, 124, 1)))
                              ]),
                          const SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _onItemTapped(1);
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      child: SvgPicture.asset(
                                        'images/sub.svg',
                                        color: _selectedIndex == 1
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                    )),
                                Text('Подписки',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SFMedium',
                                        fontSize: 10,
                                        color: _selectedIndex == 1
                                            ? Colors.green
                                            : Color.fromRGBO(124, 124, 124, 1)))
                              ]),
                          const SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                 // child: Icon(Icons.add),
                                ),
                                Text('Новый товар',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SFMedium',
                                        fontSize: 10,
                                        color:
                                            Color.fromRGBO(124, 124, 124, 1)))
                              ]),
                          const SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _onItemTapped(3);
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      child: SvgPicture.asset(
                                        'images/chat.svg',
                                        color: _selectedIndex == 3
                                            ? Color.fromRGBO(106, 175, 63, 1)
                                            : Colors.grey,
                                      ),
                                    )),
                                Text('Сообщения',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SFMedium',
                                        fontSize: 10,
                                        color: _selectedIndex == 3
                                            ? Color.fromRGBO(106, 175, 63, 1)
                                            : Color.fromRGBO(124, 124, 124, 1)))
                              ]),
                          const SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      _onItemTapped(4);
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      child: SvgPicture.asset(
                                        'images/profile.svg',
                                        color: _selectedIndex == 4
                                            ? Color.fromRGBO(106, 175, 63, 1)
                                            : Colors.grey,
                                      ),
                                    )),
                                Text('Профиль',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SFMedium',
                                        fontSize: 10,
                                        color: _selectedIndex == 4
                                            ? Color.fromRGBO(106, 175, 63, 1)
                                            : Color.fromRGBO(124, 124, 124, 1)))
                              ]),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Positioned(
                        width: 55,
                        height: 55,
                        bottom: 92 - 45,
                        left: (MediaQuery.of(context).size.width) / 2 -
                            55 / 2 -
                            5,
                        child: GestureDetector(
                          onTap: () async{
  
                          },
                          child:  Container(
                          width: 45,
                          height: 45,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Color.fromRGBO(106, 175, 63, 1)),
                        ))),
                  ],
                ));
          } else {
            //print(product);
            return Container(
                alignment: Alignment.center,
                width: 100,
                height: 100,
                color: Colors.white,
                child: CircularProgressIndicator());
          }
        });
  }
}
