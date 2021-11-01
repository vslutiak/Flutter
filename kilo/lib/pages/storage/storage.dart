import 'dart:async';
import 'dart:convert';



import 'package:geolocator/geolocator.dart';
import 'package:graphql/client.dart';

import 'package:kilo/models/periods.dart';
import 'package:kilo/models/prod.dart';
import 'package:kilo/models/product.dart';
import 'package:kilo/models/reviews.dart';
import 'package:kilo/models/seller.dart';
import 'package:kilo/models/seller_profile.dart';
import 'package:kilo/models/setting.dart';
import 'package:kilo/models/tag.dart';
import 'package:kilo/models/user.dart';
import 'package:kilo/pages/services/shared_preferences_service.dart';
import 'package:kilo/pages/storage/server.dart';
import 'package:http/http.dart' as http;

class Storages {
  Future getSellerInfo(String uid) async {
    const String info = r'''query  SellerProfil($id: uuid!){
      users_by_pk(
          id: $id
          ){
            id
             avatar
    name
    chat_users {
      chat {
        id
      }
    }
    products_aggregate {
      aggregate {
        count
      }
    }
    subscriptions {
      id
    }
    reviews_aggregate {
      aggregate {
        avg {
          rating
        }
      }
    }
     products() {
      id
      links
      name
      price
      type_unit {
        name
      }
    }
    reviews(limit: 10, offset: 0) {
      anonymous
      customer {
        avatar
        name
      }
      created_at
      rating
      comment
      links
    }
        }
        }    ''';

    final QueryOptions options = QueryOptions(
      document: gql(info),
      variables: {'id': uid},
    );
    final QueryResult result = await authServer.value.query(options);

    if (result.hasException) {
      return result.exception!.graphqlErrors.map((e) => e.message).toString();
    } else if (result.data!.isNotEmpty) {
      // log(result.data.toString());
      Map<String, dynamic> map = result.data!['users_by_pk'];
      String avatar =
          "https://storage.2kilo.co/files/" + map['avatar'].toString();
      List<String> subscriptions = (map['subscriptions'] as List<dynamic>)
          .map((e) => e['id'] as String)
          .toList();

      dynamic rait = map['reviews_aggregate']['aggregate']['avg']['rating'];
      num countProd = map['products_aggregate']['aggregate']['count'];
      List<Product> prods = (map['products'] as List<dynamic>).map((e) {
        List<dynamic> listImg = e['links'];
        String img =
            "https://storage.2kilo.co/files/" + listImg.first.toString();
        return Product.fromMap(e, img);
      }).toList();
      List<Reviews> rev = (map['reviews'] as List<dynamic>).map((e) {
        List<String> links = e['links'] ?? [];

        String name = e['customer']['name'];

        String avatar = "https://storage.2kilo.co/files/" +
            e['customer']['avatar'].toString();

        return Reviews.fromMap(e, links, name, avatar);
      }).toList();
      final SellerInf seller = SellerInf.fromMap(
          map, prods, rev, rait, avatar, subscriptions, countProd);
      return seller;
    } else {
      return "Succes";
    }
  }
  Future<Settings?> getSellerSetting() async{
    const String info = r'''query SalesSettings  {
  my_data {
    id
    period(where: {date: {_gte: "NOW()"}}){
      date
      time_from
      time_to
    }
    address {
      location
      reverse_geo
    }
    delivery {
      radius
      type
      type_delivery {
        name
      }
    }
  }
}''';
    final QueryOptions options = QueryOptions(
      document: gql(info),
      
    );
    final QueryResult result = await authServer.value.query(options);
   // print(result);
    //log(result.toString());
    //  print(result.data);

    if (result.hasException) {
      print(result.exception!.graphqlErrors.map((e) => e.message).toString());
      Settings? sd = null;
      return sd;
    } else if (result.data != null) {
    
     Map<String, dynamic> map = result.data!['my_data'][0];
     List<dynamic> location = map['address']['location'][
       'coordinates'
     ];
     
      List<String> delivery =
        (map['delivery'] as List<dynamic>).map((e) {
      return (e['type'].toString());
    }).toList();
    List<dynamic> radius = (map['delivery'] as List<dynamic>).map((e) {
      return (e['radius'].toString());
    }).toList();
   // radius.skipWhile((value) => value == 'null');
    print(radius);

    List<Period> periods = (map['period'] as List<dynamic>)
        .map((e) => Period.fromMap(e))
        .toList();

      return Settings.fromMap(map, location, periods, delivery);
      
    } else {
      Settings? sd = null;
      return sd;
    }
  }
  
  Future getProduct(String uid) async {
    const String resend = r'''query Product($id: uuid!){
    products_by_pk(
      id: $id
    )
    {
      id
      links
      name
      seller_id
      short_description
      created_at
      packing
      price
      description
      type_unit {
       name
      }
      product_tags {
        tag {
          id
          name
        }
      }
      seller 
      {
        avatar
        name
      
        reviews_aggregate {
          aggregate {
            avg {
              rating
            }
          }
        }
        address {
         location
        }
        deliveries {
          type_delivery {
            type
            name
          }
        }
        periods(where: {date: {_gte: "NOW()"}}) {
          date
          time_from
          time_to
        }
      }
    }}''';
    final QueryOptions options = QueryOptions(
      document: gql(resend),
      variables: {'id': uid},
    );
    final QueryResult result = await server.client.query(options);
    //print(result);
    // print(result.data);

    if (result.hasException) {
      print(result.exception!.graphqlErrors.map((e) => e.message).toString());
      return false;
    } else if (result.data != null) {
      Map<String, dynamic> map = result.data!['products_by_pk'];
      List<Tag> tag = (map['product_tags'] as List<dynamic>).map((e) {
        return Tag.fromMap(e['tag'] as Map<String, dynamic>);
      }).toList();

      List<dynamic> type =
          map['type_unit'].entries.map((e) => e.value.toString()).toList();
      type.removeAt(0);
      Seller seller = getSeller(map);
      List<dynamic> location = seller.location['coordinates'];
      String key = 'AIzaSyAatyXDawvBeERV45qNuwqiNZE7tQpNVfw';
      String url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.first},${location.last}&key=$key&language=RU";
      
      List<dynamic> listImg = map['links'];
      List<String> img = listImg
          .map((e) => "https://storage.2kilo.co/files/" + e.toString())
          .toList();
      String adres = await getAdress(url);
      List<String> cache = adres.split(',');
      cache.removeLast();
      adres = cache.join();
      final Prod product = Prod.fromMap(map, type, tag, seller, img, adres);
      return product;
    } else {
      return false;
    }
  }

  Future getAdress(String url) async {
    Uri ur = Uri.parse(url);
    http.Response result = await http.get(ur);
    var decode = jsonDecode(result.body);
    return (decode["results"][0]["formatted_address"]);
  }

  Future<List<Product>> getMainProducts(int skip) async {
    List<String>? location = await sharedPreferenceService.location;
    print('Local: $location');
    const String resend =
        r'''query MainProducts($point: geography!, $offset: Int){
    products_list(
      args: {point: $point}, limit: 24, offset: $offset
    ){
    description
    id
    links
    name
    short_description
    packing
    price
    }
    }''';
    QueryOptions options;
    if (location == null || location.isEmpty) {
      Position? position = await Geolocator.getCurrentPosition();
      print(position);
      options = QueryOptions(
        document: gql(resend),
        variables: {
          "point": {
            "type": "Point",
            "coordinates": [position.latitude, position.longitude]
          },
          'offset': skip
        },
      );
    } else {
      double lat = double.parse(location.first);
      print(lat);

      double long = double.parse(location.last);
      print(long);
      options = QueryOptions(
        document: gql(resend),
        variables: {
          "point": {
            "type": "Point",
            "coordinates": [48.430476, 35.028800]
          },
          'offset': skip
        },
      );
    }
    final QueryResult result = await server.client.query(options);

    if (result.hasException) {
      print(result.exception!.graphqlErrors.map((e) => e.message).toString());
      List<Product> z = [];
      return z;
    } else if (result.data != null) {
      // log(result.data.toString());
      List<dynamic> b = result.data!['products_list'];
      final List<Product> product = b.map((e) {
        List<dynamic> listImg = e['links'];

        String img =
            "https://storage.2kilo.co/files/" + listImg.first.toString();
        return Product.fromMap(e, img);
      }).toList();
      return product;
    } else {
      List<Product> z = [];
      return z;
    }
  }

  Future removeSubscriptions(String id) async {
    const String remove = r'''
    mutation DeleteSubscriptionsSeller ($id: uuid!){
delete_subscriptions_by_pk(id: $id) {
    id
  }

    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(remove),
      variables: {
        'id': id,
      },
    );

    final QueryResult result = await authServer.value.mutate(options);

    if (result.hasException) {
      return result.exception!.graphqlErrors.map((e) => e.message).toString();
    } else {
      return true;
    }
  }

  Future buy(Map<String, dynamic> map) async {
    const String buy = r'''mutation InsertOrder($object: orders_insert_input!) {
  insert_orders_one(object: $object) {
    id
  }
} ''';
    final MutationOptions options = MutationOptions(
      document: gql(buy),
      variables: {
        'object': map,
      },
    );
    final QueryResult result = await authServer.value.mutate(options);
    print(result);
    if (result.hasException) {
      print(result.exception!.graphqlErrors.map((e) => e.message).toString());
      return false;
    } else {
      print(result);
      return true;
    }
  }

  Future addSubscriptions(String id) async {
    const String add = r'''
    mutation InsertSubscriptions ($seller_id: uuid!){
        insert_subscriptions_one(object: {seller_id: $seller_id}) {
    id
  }

    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(add),
      variables: {
        'seller_id': id,
      },
    );
    final QueryResult result = await authServer.value.mutate(options);

    if (result.hasException) {
      return result.exception!.graphqlErrors.map((e) => e.message).toString();
    } else {
      return true;
    }
  }

  Future getMyData() async {
    const String resend = r'''query MyData{
     my_data{
      id
      name
      phone
      email
      verified
      avatar
    }
    }''';
    final QueryOptions options = QueryOptions(
      document: gql(resend),
    );
    final QueryResult result = await authServer.value.query(options);
  //  print(result);
    if (result.hasException) {
      print(result.exception!.graphqlErrors.map((e) => e.message).toString());
      return 'Error';
    } else if (result.data != null) {
      var b = result.data!['my_data'][0];
      //  print(b);
      String img = "https://storage.2kilo.co/files/" + b['avatar'].toString();
      final User product = User.fromMap(b, img);
      return product;
    } else {
      return "Succes";
    }
  }

  Future logOut() async {
    String out = r'''mutation Logout {
  authLogout {
    status
  }
}
''';
    final MutationOptions options = MutationOptions(
      document: gql(out),
    );
    await authServer.value.resetStore();
    final QueryResult result = await authServer.value.mutate(options);
    if (result.hasException) {
      print(result.exception!.graphqlErrors.map((e) => e.message).toString());
      return false;
    } else if (result.data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future editProfile(String id, String avatar, String name, String phone,
      [String password = ' ']) async {
    String edit =
        r'''mutation UpdatePrifile($phone: String!, $name: String!, $avatar: String!, $id: uuid!)  {
  update_users_by_pk(pk_columns: {id: $id}, _set: {avatar: $avatar, name: $name, phone: $phone}) {
    id
  }
}

  ''';
    String fulledit = r'''mutation ChangePassword ($password: String!) {
  authChangePassword(password: $password) {
    status
  }
      }
  ''';
    if (password != ' ') {
      final MutationOptions options =
          MutationOptions(document: gql(fulledit), variables: {
        'password': password,
      });
      await authServer.value.resetStore();
      final QueryResult result = await authServer.value.mutate(options);

      if (result.hasException) {
        print(result.exception!.graphqlErrors.map((e) => e.message).toString());
        return false;
      } else if (result.data != null) {
        return true;
      } else {
        return false;
      }
    } else {
      final MutationOptions options =
          MutationOptions(document: gql(edit), variables: {
        'id': id,
        'name': name,
        'avatar': avatar,
        'phone': phone,
      });
      await authServer.value.resetStore();
      final QueryResult result = await authServer.value.mutate(options);

      if (result.hasException) {
        print(result.exception!.graphqlErrors.map((e) => e.message).toString());
        return false;
      } else if (result.data != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  Seller getSeller(Map<String, dynamic> map) {
    double rating =
        map['seller']['reviews_aggregate']['aggregate']['avg']['rating'] ?? 0;
    Map<String, dynamic> location = map['seller']['address']['location'];
    List<String> delivery =
        (map['seller']['deliveries'] as List<dynamic>).map((e) {
      return (e['type_delivery'] as Map<String, dynamic>)['name'].toString();
    }).toList();
    // log(map['seller'].toString());
    List<Period> periods = (map['seller']['periods'] as List<dynamic>)
        .map((e) => Period.fromMap(e))
        .toList();

    String img =
        "https://storage.2kilo.co/files/" + map['seller']['avatar'].toString();
    Seller seller =
        Seller.fromMap(map, periods, delivery, location, rating, img);
    return seller;
  }
}
