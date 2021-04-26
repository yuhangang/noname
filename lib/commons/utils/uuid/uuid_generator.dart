import 'package:uuid/uuid.dart';

class UUidGenerator {
  UUidGenerator._();
  static UUidGenerator instance = UUidGenerator._();
  final Uuid todoIdGenerator = Uuid();

  static String getTodoId() => DateTime.now().microsecondsSinceEpoch.toString();
  static String getWorkspaceId() => instance.todoIdGenerator.v4();
}
