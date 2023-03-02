
abstract class DirectoryProvider {
  Future<String> getFilesDir();
  Future<void> createFile(String path);
}
