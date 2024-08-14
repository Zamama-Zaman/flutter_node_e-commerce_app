import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late AuthService authService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    authService = AuthService();
    authService.client = CustomHttpClientMiddleWare(mockClient);
  });

  group('register', () {
    const name = 'John Doe';
    const email = 'john@example.com';
    const password = 'password123';
    final requestBody = json.encode({
      'name': name,
      'email': email,
      'password': password,
    });

    test('returns Right(message) when registration is successful', () async {
      final responseBody = json.encode({
        'message': 'User register successfully',
      });

      when(mockClient.post(
        Uri.parse(AppBaseUrl.registerUrl),
        body: requestBody,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response(responseBody, 201));

      final result = await authService.register(
        name: name,
        email: email,
        password: password,
      );

      expect(result, isA<Right>());
      expect(result.getOrElse(() => ''), 'User register successfully');
    });

    test(
        'returns Left(error message) when registration fails with server error',
        () async {
      final responseBody = json.encode({
        'message': 'Email already in use',
      });

      when(mockClient.post(
        Uri.parse(AppBaseUrl.registerUrl),
        body: requestBody,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => Response(responseBody, 400));

      final result = await authService.register(
        name: name,
        email: email,
        password: password,
      );

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => ''), 'Email already in use');
    });

    test('returns Left(Register Error) when an exception occurs', () async {
      when(mockClient.post(
        Uri.parse(AppBaseUrl.registerUrl),
        body: requestBody,
        headers: anyNamed('headers'),
      )).thenThrow(Exception('Network error'));

      final result = await authService.register(
        name: name,
        email: email,
        password: password,
      );

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => ''), contains('Register Error'));
    });
  });
}
