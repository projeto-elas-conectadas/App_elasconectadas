import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AuthApi
void main() {
  final instance = Openapi().getAuthApi();

  group(AuthApi, () {
    //Future authControllerLogin() async
    test('test authControllerLogin', () async {
      // TODO
    });

    //Future authControllerRequestOTP(JsonObject body) async
    test('test authControllerRequestOTP', () async {
      // TODO
    });

    //Future authControllerSendMail(JsonObject body) async
    test('test authControllerSendMail', () async {
      // TODO
    });

    //Future authControllerVerifyOTP(JsonObject body) async
    test('test authControllerVerifyOTP', () async {
      // TODO
    });

  });
}
