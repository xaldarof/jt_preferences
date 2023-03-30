import 'package:jt_preferences/src/core/mode_manager.dart';

import '../core/read.dart';
import '../core/write.dart';

abstract class FileManager
    implements
        Read<Map<String, dynamic>>,
        Write<Map<String, dynamic>>,
        ModeManager {
  Future<bool> save(Map<String, dynamic> map);
}
