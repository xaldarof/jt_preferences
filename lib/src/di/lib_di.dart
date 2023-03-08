import 'package:get_it/get_it.dart';

import '../preferences_manager.dart';
import '../adapter/data_mapper.dart';
import '../file/dir/directory_provider.dart';
import '../file/dir/directory_provider_impl.dart';
import '../file/file_manager.dart';
import '../file/file_manager_impl.dart';

final injector = GetIt.instance;

void initDependencies(String path) {
  injector.registerSingleton<DirectoryProvider>(DirectoryProviderImpl());
  injector.registerSingleton<Mapper>(DataMapper());
  injector.registerSingleton<FileManager>(FileManagerImpl(
      directoryProvider: injector.get(),
      mapper: injector.get(),
      rootPath: path));
  injector.registerSingleton<PreferencesManager>(
      PreferencesManagerImpl(manager: injector.get()));
}
