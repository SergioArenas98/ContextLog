// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhotoModel {

 String get id; String get featureId; PhotoStage get stage; String? get manualCameraPhotoNumber; CardinalOrientation get cardinalOrientation; String? get notes; String? get localImagePath; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoModelCopyWith<PhotoModel> get copyWith => _$PhotoModelCopyWithImpl<PhotoModel>(this as PhotoModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.manualCameraPhotoNumber, manualCameraPhotoNumber) || other.manualCameraPhotoNumber == manualCameraPhotoNumber)&&(identical(other.cardinalOrientation, cardinalOrientation) || other.cardinalOrientation == cardinalOrientation)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,stage,manualCameraPhotoNumber,cardinalOrientation,notes,localImagePath,createdAt,updatedAt);

@override
String toString() {
  return 'PhotoModel(id: $id, featureId: $featureId, stage: $stage, manualCameraPhotoNumber: $manualCameraPhotoNumber, cardinalOrientation: $cardinalOrientation, notes: $notes, localImagePath: $localImagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PhotoModelCopyWith<$Res>  {
  factory $PhotoModelCopyWith(PhotoModel value, $Res Function(PhotoModel) _then) = _$PhotoModelCopyWithImpl;
@useResult
$Res call({
 String id, String featureId, PhotoStage stage, String? manualCameraPhotoNumber, CardinalOrientation cardinalOrientation, String? notes, String? localImagePath, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PhotoModelCopyWithImpl<$Res>
    implements $PhotoModelCopyWith<$Res> {
  _$PhotoModelCopyWithImpl(this._self, this._then);

  final PhotoModel _self;
  final $Res Function(PhotoModel) _then;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureId = null,Object? stage = null,Object? manualCameraPhotoNumber = freezed,Object? cardinalOrientation = null,Object? notes = freezed,Object? localImagePath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PhotoStage,manualCameraPhotoNumber: freezed == manualCameraPhotoNumber ? _self.manualCameraPhotoNumber : manualCameraPhotoNumber // ignore: cast_nullable_to_non_nullable
as String?,cardinalOrientation: null == cardinalOrientation ? _self.cardinalOrientation : cardinalOrientation // ignore: cast_nullable_to_non_nullable
as CardinalOrientation,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PhotoModel].
extension PhotoModelPatterns on PhotoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoModel value)  $default,){
final _that = this;
switch (_that) {
case _PhotoModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoModel value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String featureId,  PhotoStage stage,  String? manualCameraPhotoNumber,  CardinalOrientation cardinalOrientation,  String? notes,  String? localImagePath,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that.id,_that.featureId,_that.stage,_that.manualCameraPhotoNumber,_that.cardinalOrientation,_that.notes,_that.localImagePath,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String featureId,  PhotoStage stage,  String? manualCameraPhotoNumber,  CardinalOrientation cardinalOrientation,  String? notes,  String? localImagePath,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PhotoModel():
return $default(_that.id,_that.featureId,_that.stage,_that.manualCameraPhotoNumber,_that.cardinalOrientation,_that.notes,_that.localImagePath,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String featureId,  PhotoStage stage,  String? manualCameraPhotoNumber,  CardinalOrientation cardinalOrientation,  String? notes,  String? localImagePath,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PhotoModel() when $default != null:
return $default(_that.id,_that.featureId,_that.stage,_that.manualCameraPhotoNumber,_that.cardinalOrientation,_that.notes,_that.localImagePath,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _PhotoModel implements PhotoModel {
  const _PhotoModel({required this.id, required this.featureId, required this.stage, this.manualCameraPhotoNumber, required this.cardinalOrientation, this.notes, this.localImagePath, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String featureId;
@override final  PhotoStage stage;
@override final  String? manualCameraPhotoNumber;
@override final  CardinalOrientation cardinalOrientation;
@override final  String? notes;
@override final  String? localImagePath;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoModelCopyWith<_PhotoModel> get copyWith => __$PhotoModelCopyWithImpl<_PhotoModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.manualCameraPhotoNumber, manualCameraPhotoNumber) || other.manualCameraPhotoNumber == manualCameraPhotoNumber)&&(identical(other.cardinalOrientation, cardinalOrientation) || other.cardinalOrientation == cardinalOrientation)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,stage,manualCameraPhotoNumber,cardinalOrientation,notes,localImagePath,createdAt,updatedAt);

@override
String toString() {
  return 'PhotoModel(id: $id, featureId: $featureId, stage: $stage, manualCameraPhotoNumber: $manualCameraPhotoNumber, cardinalOrientation: $cardinalOrientation, notes: $notes, localImagePath: $localImagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PhotoModelCopyWith<$Res> implements $PhotoModelCopyWith<$Res> {
  factory _$PhotoModelCopyWith(_PhotoModel value, $Res Function(_PhotoModel) _then) = __$PhotoModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureId, PhotoStage stage, String? manualCameraPhotoNumber, CardinalOrientation cardinalOrientation, String? notes, String? localImagePath, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PhotoModelCopyWithImpl<$Res>
    implements _$PhotoModelCopyWith<$Res> {
  __$PhotoModelCopyWithImpl(this._self, this._then);

  final _PhotoModel _self;
  final $Res Function(_PhotoModel) _then;

/// Create a copy of PhotoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureId = null,Object? stage = null,Object? manualCameraPhotoNumber = freezed,Object? cardinalOrientation = null,Object? notes = freezed,Object? localImagePath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PhotoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PhotoStage,manualCameraPhotoNumber: freezed == manualCameraPhotoNumber ? _self.manualCameraPhotoNumber : manualCameraPhotoNumber // ignore: cast_nullable_to_non_nullable
as String?,cardinalOrientation: null == cardinalOrientation ? _self.cardinalOrientation : cardinalOrientation // ignore: cast_nullable_to_non_nullable
as CardinalOrientation,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
