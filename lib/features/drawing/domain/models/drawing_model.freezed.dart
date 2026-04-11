// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drawing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DrawingModel {

 String get id; String get featureId; String get drawingNumber; String? get boardNumber; DrawingType? get drawingType; CardinalOrientation get facing; String? get notes;/// Local filesystem path to an optional reference image for this drawing.
/// Not an official excavation photo — just a visual aid stored locally.
 String? get referenceImagePath; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of DrawingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DrawingModelCopyWith<DrawingModel> get copyWith => _$DrawingModelCopyWithImpl<DrawingModel>(this as DrawingModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DrawingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.drawingNumber, drawingNumber) || other.drawingNumber == drawingNumber)&&(identical(other.boardNumber, boardNumber) || other.boardNumber == boardNumber)&&(identical(other.drawingType, drawingType) || other.drawingType == drawingType)&&(identical(other.facing, facing) || other.facing == facing)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.referenceImagePath, referenceImagePath) || other.referenceImagePath == referenceImagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,drawingNumber,boardNumber,drawingType,facing,notes,referenceImagePath,createdAt,updatedAt);

@override
String toString() {
  return 'DrawingModel(id: $id, featureId: $featureId, drawingNumber: $drawingNumber, boardNumber: $boardNumber, drawingType: $drawingType, facing: $facing, notes: $notes, referenceImagePath: $referenceImagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DrawingModelCopyWith<$Res>  {
  factory $DrawingModelCopyWith(DrawingModel value, $Res Function(DrawingModel) _then) = _$DrawingModelCopyWithImpl;
@useResult
$Res call({
 String id, String featureId, String drawingNumber, String? boardNumber, DrawingType? drawingType, CardinalOrientation facing, String? notes, String? referenceImagePath, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$DrawingModelCopyWithImpl<$Res>
    implements $DrawingModelCopyWith<$Res> {
  _$DrawingModelCopyWithImpl(this._self, this._then);

  final DrawingModel _self;
  final $Res Function(DrawingModel) _then;

/// Create a copy of DrawingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureId = null,Object? drawingNumber = null,Object? boardNumber = freezed,Object? drawingType = freezed,Object? facing = null,Object? notes = freezed,Object? referenceImagePath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,drawingNumber: null == drawingNumber ? _self.drawingNumber : drawingNumber // ignore: cast_nullable_to_non_nullable
as String,boardNumber: freezed == boardNumber ? _self.boardNumber : boardNumber // ignore: cast_nullable_to_non_nullable
as String?,drawingType: freezed == drawingType ? _self.drawingType : drawingType // ignore: cast_nullable_to_non_nullable
as DrawingType?,facing: null == facing ? _self.facing : facing // ignore: cast_nullable_to_non_nullable
as CardinalOrientation,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,referenceImagePath: freezed == referenceImagePath ? _self.referenceImagePath : referenceImagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DrawingModel].
extension DrawingModelPatterns on DrawingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DrawingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DrawingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DrawingModel value)  $default,){
final _that = this;
switch (_that) {
case _DrawingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DrawingModel value)?  $default,){
final _that = this;
switch (_that) {
case _DrawingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String featureId,  String drawingNumber,  String? boardNumber,  DrawingType? drawingType,  CardinalOrientation facing,  String? notes,  String? referenceImagePath,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DrawingModel() when $default != null:
return $default(_that.id,_that.featureId,_that.drawingNumber,_that.boardNumber,_that.drawingType,_that.facing,_that.notes,_that.referenceImagePath,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String featureId,  String drawingNumber,  String? boardNumber,  DrawingType? drawingType,  CardinalOrientation facing,  String? notes,  String? referenceImagePath,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DrawingModel():
return $default(_that.id,_that.featureId,_that.drawingNumber,_that.boardNumber,_that.drawingType,_that.facing,_that.notes,_that.referenceImagePath,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String featureId,  String drawingNumber,  String? boardNumber,  DrawingType? drawingType,  CardinalOrientation facing,  String? notes,  String? referenceImagePath,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DrawingModel() when $default != null:
return $default(_that.id,_that.featureId,_that.drawingNumber,_that.boardNumber,_that.drawingType,_that.facing,_that.notes,_that.referenceImagePath,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _DrawingModel implements DrawingModel {
  const _DrawingModel({required this.id, required this.featureId, required this.drawingNumber, this.boardNumber, this.drawingType, required this.facing, this.notes, this.referenceImagePath, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String featureId;
@override final  String drawingNumber;
@override final  String? boardNumber;
@override final  DrawingType? drawingType;
@override final  CardinalOrientation facing;
@override final  String? notes;
/// Local filesystem path to an optional reference image for this drawing.
/// Not an official excavation photo — just a visual aid stored locally.
@override final  String? referenceImagePath;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of DrawingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DrawingModelCopyWith<_DrawingModel> get copyWith => __$DrawingModelCopyWithImpl<_DrawingModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DrawingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.drawingNumber, drawingNumber) || other.drawingNumber == drawingNumber)&&(identical(other.boardNumber, boardNumber) || other.boardNumber == boardNumber)&&(identical(other.drawingType, drawingType) || other.drawingType == drawingType)&&(identical(other.facing, facing) || other.facing == facing)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.referenceImagePath, referenceImagePath) || other.referenceImagePath == referenceImagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,drawingNumber,boardNumber,drawingType,facing,notes,referenceImagePath,createdAt,updatedAt);

@override
String toString() {
  return 'DrawingModel(id: $id, featureId: $featureId, drawingNumber: $drawingNumber, boardNumber: $boardNumber, drawingType: $drawingType, facing: $facing, notes: $notes, referenceImagePath: $referenceImagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DrawingModelCopyWith<$Res> implements $DrawingModelCopyWith<$Res> {
  factory _$DrawingModelCopyWith(_DrawingModel value, $Res Function(_DrawingModel) _then) = __$DrawingModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureId, String drawingNumber, String? boardNumber, DrawingType? drawingType, CardinalOrientation facing, String? notes, String? referenceImagePath, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$DrawingModelCopyWithImpl<$Res>
    implements _$DrawingModelCopyWith<$Res> {
  __$DrawingModelCopyWithImpl(this._self, this._then);

  final _DrawingModel _self;
  final $Res Function(_DrawingModel) _then;

/// Create a copy of DrawingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureId = null,Object? drawingNumber = null,Object? boardNumber = freezed,Object? drawingType = freezed,Object? facing = null,Object? notes = freezed,Object? referenceImagePath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_DrawingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,drawingNumber: null == drawingNumber ? _self.drawingNumber : drawingNumber // ignore: cast_nullable_to_non_nullable
as String,boardNumber: freezed == boardNumber ? _self.boardNumber : boardNumber // ignore: cast_nullable_to_non_nullable
as String?,drawingType: freezed == drawingType ? _self.drawingType : drawingType // ignore: cast_nullable_to_non_nullable
as DrawingType?,facing: null == facing ? _self.facing : facing // ignore: cast_nullable_to_non_nullable
as CardinalOrientation,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,referenceImagePath: freezed == referenceImagePath ? _self.referenceImagePath : referenceImagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
