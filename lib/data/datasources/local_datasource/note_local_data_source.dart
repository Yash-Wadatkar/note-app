import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../models/note_model.dart';

abstract interface class NoteLocalDataSource {
  List<NoteModel> getNotes();

  NoteModel? getNote(String id);

  Future<void> saveNote(NoteModel note);

  Future<void> deleteNote(String id);
}

@LazySingleton(as: NoteLocalDataSource)
class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  const NoteLocalDataSourceImpl(this._box);

  static const boxName = 'notes';

  final Box<NoteModel> _box;

  @override
  List<NoteModel> getNotes() {
    try {
      return _box.values.toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    } catch (e) {
      throw CacheException('Failed to read notes: $e');
    }
  }

  @override
  NoteModel? getNote(String id) => _box.get(id);

  @override
  Future<void> saveNote(NoteModel note) async {
    try {
      await _box.put(note.id, note);
    } catch (e) {
      throw CacheException('Failed to save note: $e');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      await _box.delete(id);
    } catch (e) {
      throw CacheException('Failed to delete note: $e');
    }
  }
}
