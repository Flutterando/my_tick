import 'package:realm_dart/realm.dart';

part 'task_model.realm.dart';

@RealmModel()
class _Task {
  @PrimaryKey()
  late ObjectId id;

  late String title;
  late String description;
  late bool completed;
}
