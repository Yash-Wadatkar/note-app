import 'package:equatable/equatable.dart';

class Note extends Equatable {
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.colorIndex = 0,
  });

  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int colorIndex;

  Note copyWith({
    String? title,
    String? content,
    DateTime? updatedAt,
    int? colorIndex,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    createdAt,
    updatedAt,
    colorIndex,
  ];
}
