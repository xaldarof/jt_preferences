import '../core/read.dart';
import '../core/write.dart';

abstract class FileManager
    implements Read<Map<String, dynamic>>, Write<Map<String, dynamic>> {
  Future<bool> save(Map<String, dynamic> map);
}
