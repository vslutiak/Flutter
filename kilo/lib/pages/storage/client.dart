import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:graphql/client.dart';

import 'package:kilo/pages/services/shared_preferences_service.dart';

import 'server.dart';

class AuthClient {
  Future<String> login(String email, String password) async {
    //Login Data
    const String authLogin =
        r'''  mutation AuthLogin($email: String!, $password: String!, $device_id: uuid!) {
        authLogin(device_id: $device_id, email: $email, password: $password) {
    access_token
    refresh_token
    expires_in
    }
    }''';
    final String? deviceId = await getDeviceId();
    print("Device $deviceId");
    final MutationOptions options = MutationOptions(
      document: gql(authLogin),
      variables: {'email': email, 'device_id': deviceId, 'password': password},
    );

    //gfhjkm1
    //sambukamax@gmail.com

    final QueryResult result = await server.client.mutate(options);
     //print(result);

    if (result.hasException) {
      print(result.exception!.graphqlErrors.map((e) => e.message).toString());
      return "Error";
    } else {
      await sharedPreferenceService.clearToken();
      await sharedPreferenceService
          .setToken(result.data!['authLogin']['access_token']);
      await sharedPreferenceService
          .setRefreshToken(result.data!['authLogin']['refresh_token']);
      var z = DateTime.now()
          .subtract(Duration(seconds: result.data!['authLogin']['expires_in']));
      var d = (z.year - 1970) * 31556926 +
          (z.day - 1) * 86400 +
          (z.month - 1) * 2629743 +
          z.hour * 3600 +
          z.minute * 60 +
          z.second;
      await sharedPreferenceService.setDate(d);
      // authServer = InitClient.initailizeClient(
      //     result.data!['authLogin']['access_token']);
      return "Succes";
    }
  }

  Future<String> signUp(String email, String password) async {
    const String registration =
        r'''  mutation Registration($email: String!, $password: String!, $device_id: uuid!) {
        authRegistration(device_id: $device_id, email: $email, password: $password) {
    access_token
    refresh_token
    expires_in
    }
    }''';
    final String? deviceId = await getDeviceId();
    final MutationOptions options = MutationOptions(
      document: gql(registration),
      variables: {'email': email, 'device_id': deviceId, 'password': password},
    );
    final QueryResult result = await server.client.mutate(options);
    if (result.hasException) {
      return result.exception!.graphqlErrors.map((e) => e.message).toString();
    } else {
      await sharedPreferenceService.clearToken();
      await sharedPreferenceService
          .setToken(result.data!['authRegistration']['access_token']);
      await sharedPreferenceService
          .setRefreshToken(result.data!['authRegistration']['refresh_token']);
      var z = DateTime.now().subtract(
          Duration(seconds: result.data!['authRegistration']['expires_in']));
      var d = (z.year - 1970) * 31556926 +
          (z.day - 1) * 86400 +
          (z.month - 1) * 2629743 +
          z.hour * 3600 +
          z.minute * 60 +
          z.second;
      await sharedPreferenceService.setDate(d);
      // authServer = InitClient.initailizeClient(
      //     result.data!['authLogin']['access_token']);
      return "Succes";
    }
  }

  Future<String> verify(int code) async {
    const String verification =
        r'''mutation  Verification($verification_key: Int!) {
    authVerification(verification_key: $verification_key) {
    status
    }
    }''';

    final MutationOptions options = MutationOptions(
      document: gql(verification),
      variables: {
        'verification_key': code,
      },
    );

    final QueryResult result = await authServer.value.mutate(options);

    if (result.hasException) {
      return result.exception!.graphqlErrors.map((e) => e.message).toString();
    } else {
      return "Succes";
    }
  }

  Future<String> resendCode() async {
    const String resend = r'''query ResendVerification{
    authResendVerification{
    status
    }
    }''';
    final QueryOptions options = QueryOptions(
      document: gql(resend),
    );
    final QueryResult result = await authServer.value.query(options);

    if (result.hasException) {
      return result.exception!.graphqlErrors.map((e) => e.message).toString();
    } else {
      return "Succes";
    }
  }

  Future<String> newPass(String email) async {
    const String newPass = r'''mutation  Restore($email: String!) {
     authRestorePassword(email: $email) {
    status
    }
    }''';

    final MutationOptions options = MutationOptions(
      document: gql(newPass),
      variables: {
        'email': email,
      },
    );

    final QueryResult result = await server.client.mutate(options);

    if (result.hasException) {
      return result.exception!.graphqlErrors.map((e) => e.message).toString();
    } else {
      return "Succes";
    }
  }

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  Future<String> getNewPass(String email, String password, int key) async {
    const String getNewPass = r'''mutation  NewPassword($email: String!,
    $password: String!, $restore_key: Int!) {
     authNewPassword(email: $email,  password: $password, restore_key: $restore_key) {
    status
    }
    }''';

    final MutationOptions options = MutationOptions(
      document: gql(getNewPass),
      variables: {'email': email, 'password': password, 'restore_key': key},
    );

    final QueryResult result = await server.client.mutate(options);

    if (result.hasException) {
      return result.exception!.graphqlErrors.map((e) => e.message).toString();
    } else {
      return "Succes";
    }
  }
}

AuthClient authClient = AuthClient();
