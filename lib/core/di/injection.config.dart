// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:hive_ce_flutter/hive_flutter.dart' as _i919;
import 'package:injectable/injectable.dart' as _i526;
import 'package:note_app/core/di/storage_module.dart' as _i156;
import 'package:note_app/data/datasources/local_datasource/note_local_data_source.dart'
    as _i354;
import 'package:note_app/data/models/note_model.dart' as _i659;
import 'package:note_app/data/repositories/note_repository_impl.dart' as _i229;
import 'package:note_app/domain/repositories/note_repository.dart' as _i956;
import 'package:note_app/domain/usecases/add_note.dart' as _i210;
import 'package:note_app/domain/usecases/delete_note.dart' as _i804;
import 'package:note_app/domain/usecases/get_notes.dart' as _i119;
import 'package:note_app/domain/usecases/update_note.dart' as _i83;
import 'package:note_app/presentation/notes/note_list/cubit/notes_cubit.dart'
    as _i92;
import 'package:uuid/uuid.dart' as _i706;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    await gh.singletonAsync<_i919.Box<_i659.NoteModel>>(
      () => storageModule.notesBox,
      preResolve: true,
    );
    gh.lazySingleton<_i706.Uuid>(() => storageModule.uuid);
    gh.lazySingleton<_i354.NoteLocalDataSource>(
      () => _i354.NoteLocalDataSourceImpl(gh<_i738.Box<_i659.NoteModel>>()),
    );
    gh.lazySingleton<_i956.NoteRepository>(
      () => _i229.NoteRepositoryImpl(
        gh<_i354.NoteLocalDataSource>(),
        gh<_i706.Uuid>(),
      ),
    );
    gh.lazySingleton<_i210.AddNote>(
      () => _i210.AddNote(gh<_i956.NoteRepository>()),
    );
    gh.lazySingleton<_i804.DeleteNote>(
      () => _i804.DeleteNote(gh<_i956.NoteRepository>()),
    );
    gh.lazySingleton<_i119.GetNotes>(
      () => _i119.GetNotes(gh<_i956.NoteRepository>()),
    );
    gh.lazySingleton<_i83.UpdateNote>(
      () => _i83.UpdateNote(gh<_i956.NoteRepository>()),
    );
    gh.factory<_i92.NotesCubit>(
      () => _i92.NotesCubit(
        gh<_i119.GetNotes>(),
        gh<_i210.AddNote>(),
        gh<_i83.UpdateNote>(),
        gh<_i804.DeleteNote>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i156.StorageModule {}
