import 'package:get_it/get_it.dart';
import 'package:jt_preferences/src/core/jt_type.dart';
import 'package:jt_preferences/src/encryption/aes_encryption.dart';
import 'package:jt_preferences/src/encryption/encryption.dart';
import 'package:jt_preferences/src/file/dir/encrypted_directory_provider_impl.dart';
import 'package:jt_preferences/src/file/encrypted_file_manager_impl.dart';

import '../preferences_manager.dart';
import '../adapter/data_mapper.dart';
import '../file/dir/directory_provider.dart';
import '../file/dir/directory_provider_impl.dart';
import '../file/file_manager.dart';
import '../file/file_manager_impl.dart';

final injector = GetIt.instance;

void initDependencies(String path, {String? encryptionKey}) {
  injector.registerSingleton<Mapper>(DataMapper());

  if (encryptionKey != null) {
    injector.registerSingleton<IEncryptor>(
        AesEncryptionImpl(encryptionKey: encryptionKey));

    injector.registerSingleton<DirectoryProvider>(
        EncryptedDirectoryProviderImpl(encryptor: injector.get()));

    injector.registerSingleton<FileManager>(
        EncryptedFileManager(
          directoryProvider: injector.get(),
          mapper: injector.get(),
          rootPath: path,
          encryptor: injector.get(),
        ),
        instanceName: JtType.encrypted.value);
  } else {
    injector.registerSingleton<DirectoryProvider>(DirectoryProviderImpl());
    injector.registerSingleton<FileManager>(
        FileManagerImpl(
            directoryProvider: injector.get(),
            mapper: injector.get(),
            rootPath: path),
        instanceName: JtType.standard.value);
  }

  FileManager fileManager = encryptionKey != null
      ? injector.get<FileManager>(instanceName: JtType.encrypted.value)
      : injector.get<FileManager>(instanceName: JtType.standard.value);

  injector.registerSingleton<PreferencesManager>(
      PreferencesManagerImpl(manager: fileManager));
}
