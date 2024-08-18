import '../../../../lib.dart';

class CustomHttpClientMiddleWare extends BaseClient {
  final Client _inner;

  CustomHttpClientMiddleWare(this._inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    // Add your middleware logic here
    debugPrint('Request: ${request.method} ${request.url}');

    // Add headers or modify the request
    // request.headers['Custom-Header'] = 'CustomValue';

    return _inner.send(request).then((response) {
      // Add your middleware logic for the response here
      debugPrint('Response: ${response.statusCode}');

      if (response.statusCode == 401) {
        Get.offAll(() => const LoginView());
      }

      return response;
    });
  }
}
