import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // given when then
  test(
    'given instance class when it is instantiated then it should have header value',
    () {
      // arrange
      final AuthService authService = AuthService.instance;
      // act
      final Map<String, String> headersValue = authService.headers;
      // assert
      expect(headersValue, {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': 'en' //AppPreference.instance.getLocale,
      });
    },
  );
}
