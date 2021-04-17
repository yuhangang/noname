import 'package:uuid/uuid.dart';

class UUidGenerator {
  UUidGenerator._();
  static UUidGenerator instance = UUidGenerator._();
  final Uuid todoIdGenerator = Uuid();

  static String getTodoId() => instance.todoIdGenerator.v1();
  static String getWorkspaceId() => instance.todoIdGenerator.v4();
}
