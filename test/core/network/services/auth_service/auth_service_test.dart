import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference.instance.initiatePreference();
  GetMaterialApp(
    binds: AppBinding.bindings,
  );

  test("Testing login function", () async {
    const email = "zamamazaman@gmail.com";
    const password = "12345678";

    // arrange
    final AuthService authService = AuthService.instance;
    // act
    final result = await authService.login(email: email, password: password);
    // assert
    expect(result, isA<Either<String, UserModel>>());
    expect(result.isRight(), true);
  });

  test("returns error message when login fails with incorrect credentials",
      () async {
    const email = "wrongemail@gmail.com";
    const password = "12345678";
    final myJsonEncode = json.encode({
      "email": email,
      "password": password,
    });
    // Arrange
    final AuthService authService = AuthService.instance;
    MockHttpClient mockHttpClient = MockHttpClient();
    authService.client = CustomHttpClientMiddleWare(mockHttpClient);

    when(() => mockHttpClient.post(
          Uri.parse(AppBaseUrl.loginUrl),
          body: myJsonEncode,
          headers: authService.headers,
        )).thenAnswer((a) async {
      return Response("{}", 401);
    });

    // Act
    final result = await authService.login(email: email, password: password);
    // Assert
    expect(result, isA<Either<String, UserModel>>());
    expect(result.isLeft(), true);
  });
}
