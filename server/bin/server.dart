import 'package:server/handlers/auth.dart';
import 'package:server/handlers/task.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

void main() async {
  initDatabase();

  final path = 'specs/swagger.yaml';
  final swaggerHandler = SwaggerUI(
    path,
    title: 'MyTick API',
    persistAuthorization: true,
    deepLink: true,
  );

  final router = Router();

  // start
  router.get('/', (_) => Response.ok('Working!'));

  // docs
  router.get('/docs', swaggerHandler.call);
  router.get('/swagger.yaml', swaggerHandler.call);

  // Auth
  router.post('/login', loginHandler);

  // Task
  router.get('/tasks', jwtMiddleware()(getTasksHandler));
  router.post('/tasks', jwtMiddleware()(addTaskHandler));
  router.put('/tasks/<id>', jwtMiddleware()(updateTaskHandler));
  router.delete('/tasks/<id>', jwtMiddleware()(deleteTaskHandler));

  final handler = Pipeline() //
      .addMiddleware(logRequests())
      // INFO: Adiciona um delay para simular uma conexão lenta
      .addMiddleware(delayMiddleware(Duration(seconds: 2)))
      .addHandler(router.call);

  final server = await serve(handler, 'localhost', 8080);
  print('Server running on localhost:${server.port}');
}

Middleware delayMiddleware(Duration delay) {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.url.path == '/' || request.url.path == '/docs' || request.url.path == '/swagger.yaml') {
        return innerHandler(request);
      }
      await Future.delayed(delay);
      return innerHandler(request);
    };
  };
}
