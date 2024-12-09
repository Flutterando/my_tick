import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

final users = {
  'test@flutterando.com.br': 'password1',
  'user@flutterando.com.br': 'password2',
};

const jwtSecret = '800e95f5c79e328dc86e2bb015f1079448f2bcbb1dcf447a5c49c748e00ed9c4';

Future<Response> loginHandler(Request request) async {
  try {
    final payload = jsonDecode(await request.readAsString());
    final username = payload['username'];
    final password = payload['password'];

    if (users[username] == password) {
      final jwt = JWT({'username': username});
      final token = jwt.sign(SecretKey(jwtSecret), expiresIn: Duration(hours: 1));

      return Response.ok(jsonEncode({'token': token}), headers: {'Content-Type': 'application/json'});
    }

    return Response.forbidden(jsonEncode({'message': 'Invalid credentials'}), headers: {'Content-Type': 'application/json'});
  } catch (e) {
    return Response.internalServerError(body: jsonEncode({'message': 'An error occurred'}), headers: {'Content-Type': 'application/json'});
  }
}

Middleware jwtMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      final authHeader = request.headers['Authorization'];

      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.forbidden(jsonEncode({'message': 'Missing or invalid Authorization header'}), headers: {'Content-Type': 'application/json'});
      }

      final token = authHeader.substring(7);
      try {
        final jwt = JWT.verify(token, SecretKey(jwtSecret));
        final updatedRequest = request.change(context: {'username': jwt.payload['username']});
        return innerHandler(updatedRequest);
      } on JWTException catch (e) {
        return Response.forbidden(jsonEncode({'message': 'Invalid or expired token'}), headers: {'Content-Type': 'application/json'});
      }
    };
  };
}

Response protectedHandler(Request request) {
  final username = request.context['username'];
  return Response.ok(jsonEncode({'message': 'Hello, $username! This is a protected route.'}), headers: {'Content-Type': 'application/json'});
}
