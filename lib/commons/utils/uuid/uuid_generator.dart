import 'package:uuid/uuid.dart';

late final _UuidGeneratorInstance uuidGenerator;

abstract class UUidGenerator {
  static Future<void> setup() async =>
      uuidGenerator = new _UuidGeneratorInstance();
  static String getTodoId() => uuidGenerator.todoIdGenerator.v1();
}

class _UuidGeneratorInstance {
  final Uuid todoIdGenerator = Uuid();
}
