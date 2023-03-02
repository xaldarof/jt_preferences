import 'dart:io';

import 'package:jt_preferences/adapter/data_mapper.dart';
import 'package:jt_preferences/file/dir/directory_provider.dart';
import 'package:jt_preferences/core/read.dart';
import 'package:jt_preferences/core/write.dart';

abstract class FileManager implements Read<Map<String, dynamic>>, Write<Map<String, dynamic>> {
}
