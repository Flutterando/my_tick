import 'package:realm_dart/realm.dart';
import 'package:server/models/task_model.dart';

Map<String, dynamic> taskToJson(Task task) {
  return {
    'id': task.id.hexString,
    'title': task.title,
    'description': task.description,
    'completed': task.completed,
  };
}

Task taskFromJson(Map json) {
  return Task(
    json['id'] == null ? ObjectId() : ObjectId.fromHexString(json['id']),
    json['title'],
    json['description'],
    json['completed'] ?? false,
  );
}
