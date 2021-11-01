import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import 'package:kilo/pages/services/shared_preferences_service.dart';

class GraphClient {
  late GraphQLClient client;
  final Link _httpLink = HttpLink(
    'https://rinok.hasura.app/v1/graphql',
  );

  GraphClient() {
    this.client = GraphQLClient(
      cache: GraphQLCache(),
      link: _httpLink,
    );
  }
}

class InitClient {
  final httpLink = HttpLink('https://rinok.hasura.app/v1/graphql');
  late AuthLink authLink =
      AuthLink(getToken: () async => await _getAccessToken());
  late Link link = authLink.concat(httpLink);
  final policies = Policies(
    fetch: FetchPolicy.networkOnly,
  );
  late ValueNotifier<GraphQLClient> graphQLClient = ValueNotifier(GraphQLClient(
      link: link,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
          mutate: policies, query: policies, watchQuery: policies)));
  // late String _accessToken ;

  Future<String> _getAccessToken() async {
    final accessToken = await sharedPreferenceService.token;
    if (accessToken == null) {
      return '0';
    }

    final accessTokenExpireDate = await _getAccessTokenExpireDate();
    final currentDateTime = DateTime.now();

    if (accessTokenExpireDate.isBefore(currentDateTime)) {
      final refreshToken = await sharedPreferenceService.refreshToken;
      if (refreshToken == null) return '0';

      final newAccessToken = await authorize(refreshToken: refreshToken);
      // ignore: unnecessary_null_comparison
      if (newAccessToken == null) return '0';
      return 'Bearer $newAccessToken';
    } else {
      return 'Bearer $accessToken';
    }
  }

  Future<DateTime> _getAccessTokenExpireDate() async {
    int? data = await sharedPreferenceService.date;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(data! * 1000);
    return date;
  }

  Future<String> authorize({required String refreshToken}) async {
    const String refresh =
        r'''  mutation RefreshToken($refresh_token: String!) {
        authRefreshToken(refresh_token: $refresh_token) {
    access_token
    refresh_token
    expires_in
    }
    }''';
    final MutationOptions options = MutationOptions(
      document: gql(refresh),
      variables: {'refresh_token': refreshToken},
    );
    final QueryResult result = await server.client.mutate(options);
    // print(result);
    // print(result.data);
    if (result.hasException) {
      print(result.exception!.graphqlErrors.map((e) => e.message).toString());
      return "Failed";
    } else {
      await sharedPreferenceService.clearToken();
      await sharedPreferenceService
          .setToken(result.data?['authRefreshToken']['access_token']);
      await sharedPreferenceService
          .setRefreshToken(result.data?['authRefreshToken']['refresh_token']);
      var z = DateTime.now().subtract(
          Duration(seconds: result.data?['authRefreshToken']['expires_in']));

      var d = (z.year - 1970) * 31556926 +
          (z.day - 1) * 86400 +
          (z.month - 1) * 2629743 +
          z.hour * 3600 +
          z.minute * 60 +
          z.second;

      await sharedPreferenceService.setDate(d);
      // authServer = InitClient.initailizeClient(
      //     result.data!['authLogin']['access_token']);
      return result.data!['authRefreshToken']['access_token'];
    }
  }
}
//   // static String? _token;

//   // static final Link _httpLink = HttpLink(
//   //   'https://rinok.hasura.app/v1/graphql',
//   // );
//   // static final _authLink = AuthLink(
//   //   getToken: () async => 'Bearer $_token',
//   // );
//   // static final Link _link = _authLink.concat(_httpLink);
//   // static GraphQLClient initailizeClient(String token) {
//   //   _token = token;
//   //   GraphQLClient client = GraphQLClient(link: _link, cache: GraphQLCache());
//   //   return client;
//   // }
// }

ValueNotifier<GraphQLClient> authServer = InitClient().graphQLClient;
GraphClient server = GraphClient();
