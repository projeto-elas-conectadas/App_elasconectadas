import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AuthApi
void main() {
  final instance = Openapi().getAuthApi();

  group(AuthApi, () {
    //Future<LoginResponseDto> authControllerLogin(LoginDto loginDto) async
    test('test authControllerLogin', () async {
      // TODO
    });

    //Future authControllerRequestOTP(RequestTokenDto requestTokenDto) async
    test('test authControllerRequestOTP', () async {
      // TODO
    });

    //Future authControllerSendMail(SendEmailDto sendEmailDto) async
    test('test authControllerSendMail', () async {
      // TODO
    });

    //Future authControllerVerifyOTP(VerifyOtpDto verifyOtpDto) async
    test('test authControllerVerifyOTP', () async {
      // TODO
    });

  });
}
