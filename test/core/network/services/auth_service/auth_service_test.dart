// import 'package:flutter_node_ecommerce_app_original/lib.dart';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_node_ecommerce_app_original/common/models/user_model.dart';
import 'package:flutter_node_ecommerce_app_original/core/network/services/auth_service/auth_service.dart';
import 'package:flutter_node_ecommerce_app_original/core/network/services/middle_ware/custom_http_client_middle_ware.dart';
import 'package:flutter_node_ecommerce_app_original/core/network/services/network/base_url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomHttpClientMiddleWare extends Mock
    implements CustomHttpClientMiddleWare {}

void main() async {
  test("Testing login function", () async {
    const email = "zamamazaman@gmail.com";
    const password = "12345678";
    final myJsonEncode = json.encode({
      "email": email,
      "password": password,
    });

    // Arrange
    final AuthService authService = AuthService.instance;
    final middleWareClient = MockCustomHttpClientMiddleWare();
    authService.client = middleWareClient;
    when(() => middleWareClient.post(
          Uri.parse(AppBaseUrl.loginUrl),
          body: myJsonEncode,
          headers: authService.headers,
        )).thenAnswer((invocation) async {
      return Response(
        '''
          {
            "status": "Success",
            "message": "User is successfully login",
            "body": {
                "user": {
                    "_id": "6668f8c8c04a89576e2840f5",
                    "name": "Zamama Zaman",
                    "email": "zamamazaman@gmail.com",
                    "password": "\$2b\$10\$Q4KFd8h1Da4FBHlUaGUuCu5H7Gaa.gl.HGZflGrE2GSOAgBz3917.",
                    "type": "user",
                    "address": "House 21, Street no. 3, Gujranwala - 1234",
                    "cart": [],
                    "createdAt": "2024-06-12T01:24:24.233Z",
                    "updatedAt": "2024-08-12T14:33:19.230Z",
                    "__v": 48
                },
                "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7Im5hbWUiOiJaYW1hbWEgWmFtYW4iLCJlbWFpbCI6InphbWFtYXphbWFuQGdtYWlsLmNvbSIsImlkIjoiNjY2OGY4YzhjMDRhODk1NzZlMjg0MGY1In0sImlhdCI6MTcyMzg3MTE1MiwiZXhwIjoxNzIzODc0NzUyfQ.IvuPLJYncm8O1eP5umoEwypy9bD3-0LBvkFf9eDKMm4"
              }
          }
        ''',
        200,
      );
    });

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
    final mockHttpClient = MockCustomHttpClientMiddleWare();
    authService.client = mockHttpClient;

    when(() => mockHttpClient.post(
          Uri.parse(AppBaseUrl.loginUrl),
          body: myJsonEncode,
          headers: authService.headers,
        )).thenAnswer((a) async {
      return Response(
        """
        {
          "title": "Unauthoized",
          "message": "User not exist"
        }
        """,
        401,
      );
    });

    // Act
    final result = await authService.login(email: email, password: password);
    // Assert
    expect(result, isA<Either<String, UserModel>>());
    expect(result.isLeft(), true);
  });
}
