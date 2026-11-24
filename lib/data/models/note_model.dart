import 'package:hive_ce/hive.dart';

import '../../domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
    super.colorIndex,
  });

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
      colorIndex: note.colorIndex,
    );
  }
}

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    return NoteModel(
      id: reader.readString(),
      title: reader.readString(),
      content: reader.readString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      // Notes saved before colours existed end here.
      colorIndex: reader.availableBytes > 0 ? reader.readInt() : 0,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeString(obj.id)
      ..writeString(obj.title)
      ..writeString(obj.content)
      ..writeInt(obj.createdAt.millisecondsSinceEpoch)
      ..writeInt(obj.updatedAt.millisecondsSinceEpoch)
      ..writeInt(obj.colorIndex);
  }
}
