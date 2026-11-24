// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteEditorState {

 Note? get initialNote; String get title; String get content; int get colorIndex; NoteEditorStatus get status;
/// Create a copy of NoteEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteEditorStateCopyWith<NoteEditorState> get copyWith => _$NoteEditorStateCopyWithImpl<NoteEditorState>(this as NoteEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteEditorState&&(identical(other.initialNote, initialNote) || other.initialNote == initialNote)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.colorIndex, colorIndex) || other.colorIndex == colorIndex)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,initialNote,title,content,colorIndex,status);

@override
String toString() {
  return 'NoteEditorState(initialNote: $initialNote, title: $title, content: $content, colorIndex: $colorIndex, status: $status)';
}


}

/// @nodoc
abstract mixin class $NoteEditorStateCopyWith<$Res>  {
  factory $NoteEditorStateCopyWith(NoteEditorState value, $Res Function(NoteEditorState) _then) = _$NoteEditorStateCopyWithImpl;
@useResult
$Res call({
 Note? initialNote, String title, String content, int colorIndex, NoteEditorStatus status
});




}
/// @nodoc
class _$NoteEditorStateCopyWithImpl<$Res>
    implements $NoteEditorStateCopyWith<$Res> {
  _$NoteEditorStateCopyWithImpl(this._self, this._then);

  final NoteEditorState _self;
  final $Res Function(NoteEditorState) _then;

/// Create a copy of NoteEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialNote = freezed,Object? title = null,Object? content = null,Object? colorIndex = null,Object? status = null,}) {
  return _then(NoteEditorState.initial(
initialNote: freezed == initialNote ? _self.initialNote : initialNote // ignore: cast_nullable_to_non_nullable
as Note?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,colorIndex: null == colorIndex ? _self.colorIndex : colorIndex // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NoteEditorStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteEditorState].
extension NoteEditorStatePatterns on NoteEditorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Note? initialNote,  String title,  String content,  int colorIndex,  NoteEditorStatus status)?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.initialNote,_that.title,_that.content,_that.colorIndex,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Note? initialNote,  String title,  String content,  int colorIndex,  NoteEditorStatus status)  initial,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.initialNote,_that.title,_that.content,_that.colorIndex,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Note? initialNote,  String title,  String content,  int colorIndex,  NoteEditorStatus status)?  initial,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.initialNote,_that.title,_that.content,_that.colorIndex,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements NoteEditorState {
  const _Initial({this.initialNote, this.title = '', this.content = '', this.colorIndex = 0, this.status = NoteEditorStatus.editing});
  

@override final  Note? initialNote;
@override@JsonKey() final  String title;
@override@JsonKey() final  String content;
@override@JsonKey() final  int colorIndex;
@override@JsonKey() final  NoteEditorStatus status;

/// Create a copy of NoteEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.initialNote, initialNote) || other.initialNote == initialNote)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.colorIndex, colorIndex) || other.colorIndex == colorIndex)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,initialNote,title,content,colorIndex,status);

@override
String toString() {
  return 'NoteEditorState.initial(initialNote: $initialNote, title: $title, content: $content, colorIndex: $colorIndex, status: $status)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $NoteEditorStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 Note? initialNote, String title, String content, int colorIndex, NoteEditorStatus status
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of NoteEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialNote = freezed,Object? title = null,Object? content = null,Object? colorIndex = null,Object? status = null,}) {
  return _then(_Initial(
initialNote: freezed == initialNote ? _self.initialNote : initialNote // ignore: cast_nullable_to_non_nullable
as Note?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,colorIndex: null == colorIndex ? _self.colorIndex : colorIndex // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NoteEditorStatus,
  ));
}


}

// dart format on
