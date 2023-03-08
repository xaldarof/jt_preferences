import '../core/read.dart';
import '../core/write.dart';

abstract class FileManager
    implements Read<Map<String, dynamic>>, Write<Map<String, dynamic>> {}
