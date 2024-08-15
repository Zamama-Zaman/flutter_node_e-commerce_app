import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Testing registration Function", () async {
    const email = "something@gmail.com";
    const password = "12345678";

    // arrange
    final AuthService authService = AuthService.instance;
    // act
    final result = await authService.login(email: email, password: password);
    // assert
    expect(result, isA<Either<String, UserModel>>());
    expect(result.isRight(), true);
  });
}
