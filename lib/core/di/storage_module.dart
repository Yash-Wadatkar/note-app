import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../data/datasources/local_datasource/note_local_data_source.dart';
import '../../data/models/note_model.dart';

@module
abstract class StorageModule {
  @preResolve
  @singleton
  Future<Box<NoteModel>> get notesBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    return Hive.openBox<NoteModel>(NoteLocalDataSourceImpl.boxName);
  }

  @lazySingleton
  Uuid get uuid => const Uuid();
}
