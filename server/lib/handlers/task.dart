import 'dart:convert';

import 'package:realm_dart/realm.dart';
import 'package:server/adapters/task_adapter.dart';
import 'package:server/models/task_model.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

late final Realm realm;

void initDatabase() {
  Configuration.defaultRealmName = "my_tick.realm";
  final config = Configuration.local([Task.schema], path: '.db/${Configuration.defaultRealmName}');
  realm = Realm(config);
}

/// Handler to retrieve all tasks.
Response getTasksHandler(Request request) {
  final tasks = realm.all<Task>();
  return Response.ok(
    jsonEncode(tasks.map(taskToJson).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

/// Handler to add a new task.
Future<Response> addTaskHandler(Request request) async {
  print('Adding a new task...');
  try {
    final payload = jsonDecode(await request.readAsString()) as Map;
    payload.remove('id');

    final newTask = taskFromJson(payload);

    realm.write(() {
      realm.add(newTask);
    });

    return Response.ok(jsonEncode(taskToJson(newTask)), headers: {
      'Content-Type': 'application/json',
    });
  } catch (e) {
    print('Error adding task: $e');
    return Response.internalServerError(body: jsonEncode({'message': 'An error occurred'}), headers: {
      'Content-Type': 'application/json',
    });
  }
}

/// Handler to update an existing task.
Future<Response> updateTaskHandler(Request request) async {
  final id = ObjectId.fromHexString(request.params['id']!);
  final task = realm.find<Task>(id);

  if (task == null) {
    return Response.notFound(jsonEncode({'message': 'Task not found'}), headers: {'Content-Type': 'application/json'});
  }

  try {
    final payload = jsonDecode(await request.readAsString());

    realm.write(() {
      if (payload['title'] != null) {
        task.title = payload['title'] as String;
      }

      if (payload['description'] != null) {
        task.description = payload['description'] as String;
      }

      if (payload['completed'] != null) {
        task.completed = payload['completed'] as bool;
      }
    });

    return Response.ok(
      jsonEncode(taskToJson(task)),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    print('Error updating task: $e');
    return Response.internalServerError(
      body: jsonEncode({'message': 'An error occurred'}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

/// Handler to delete a task.
Response deleteTaskHandler(Request request) {
  final id = ObjectId.fromHexString(request.params['id']!);
  final task = realm.find<Task>(id);

  if (task == null) {
    return Response.notFound(
      jsonEncode({'message': 'Task not found'}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  realm.write(() {
    realm.delete(task);
  });

  return Response.ok(
    jsonEncode({'message': 'Task deleted successfully'}),
    headers: {'Content-Type': 'application/json'},
  );
}
