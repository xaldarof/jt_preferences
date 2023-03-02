abstract class DirectoryProvider {
  Future<String> getFilesDir(String rootPath);

  Future<void> createFile(String path);
}
