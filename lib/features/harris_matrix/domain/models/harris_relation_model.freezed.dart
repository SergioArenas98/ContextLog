// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'harris_relation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HarrisRelationModel {

 String get id; String get featureId; String get fromContextId; String get toContextId; HarrisRelationType get relationType; DateTime get createdAt;
/// Create a copy of HarrisRelationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HarrisRelationModelCopyWith<HarrisRelationModel> get copyWith => _$HarrisRelationModelCopyWithImpl<HarrisRelationModel>(this as HarrisRelationModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HarrisRelationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.fromContextId, fromContextId) || other.fromContextId == fromContextId)&&(identical(other.toContextId, toContextId) || other.toContextId == toContextId)&&(identical(other.relationType, relationType) || other.relationType == relationType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,fromContextId,toContextId,relationType,createdAt);

@override
String toString() {
  return 'HarrisRelationModel(id: $id, featureId: $featureId, fromContextId: $fromContextId, toContextId: $toContextId, relationType: $relationType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HarrisRelationModelCopyWith<$Res>  {
  factory $HarrisRelationModelCopyWith(HarrisRelationModel value, $Res Function(HarrisRelationModel) _then) = _$HarrisRelationModelCopyWithImpl;
@useResult
$Res call({
 String id, String featureId, String fromContextId, String toContextId, HarrisRelationType relationType, DateTime createdAt
});




}
/// @nodoc
class _$HarrisRelationModelCopyWithImpl<$Res>
    implements $HarrisRelationModelCopyWith<$Res> {
  _$HarrisRelationModelCopyWithImpl(this._self, this._then);

  final HarrisRelationModel _self;
  final $Res Function(HarrisRelationModel) _then;

/// Create a copy of HarrisRelationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureId = null,Object? fromContextId = null,Object? toContextId = null,Object? relationType = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,fromContextId: null == fromContextId ? _self.fromContextId : fromContextId // ignore: cast_nullable_to_non_nullable
as String,toContextId: null == toContextId ? _self.toContextId : toContextId // ignore: cast_nullable_to_non_nullable
as String,relationType: null == relationType ? _self.relationType : relationType // ignore: cast_nullable_to_non_nullable
as HarrisRelationType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HarrisRelationModel].
extension HarrisRelationModelPatterns on HarrisRelationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HarrisRelationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HarrisRelationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HarrisRelationModel value)  $default,){
final _that = this;
switch (_that) {
case _HarrisRelationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HarrisRelationModel value)?  $default,){
final _that = this;
switch (_that) {
case _HarrisRelationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String featureId,  String fromContextId,  String toContextId,  HarrisRelationType relationType,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HarrisRelationModel() when $default != null:
return $default(_that.id,_that.featureId,_that.fromContextId,_that.toContextId,_that.relationType,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String featureId,  String fromContextId,  String toContextId,  HarrisRelationType relationType,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _HarrisRelationModel():
return $default(_that.id,_that.featureId,_that.fromContextId,_that.toContextId,_that.relationType,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String featureId,  String fromContextId,  String toContextId,  HarrisRelationType relationType,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HarrisRelationModel() when $default != null:
return $default(_that.id,_that.featureId,_that.fromContextId,_that.toContextId,_that.relationType,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _HarrisRelationModel implements HarrisRelationModel {
  const _HarrisRelationModel({required this.id, required this.featureId, required this.fromContextId, required this.toContextId, required this.relationType, required this.createdAt});
  

@override final  String id;
@override final  String featureId;
@override final  String fromContextId;
@override final  String toContextId;
@override final  HarrisRelationType relationType;
@override final  DateTime createdAt;

/// Create a copy of HarrisRelationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HarrisRelationModelCopyWith<_HarrisRelationModel> get copyWith => __$HarrisRelationModelCopyWithImpl<_HarrisRelationModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HarrisRelationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.fromContextId, fromContextId) || other.fromContextId == fromContextId)&&(identical(other.toContextId, toContextId) || other.toContextId == toContextId)&&(identical(other.relationType, relationType) || other.relationType == relationType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,fromContextId,toContextId,relationType,createdAt);

@override
String toString() {
  return 'HarrisRelationModel(id: $id, featureId: $featureId, fromContextId: $fromContextId, toContextId: $toContextId, relationType: $relationType, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HarrisRelationModelCopyWith<$Res> implements $HarrisRelationModelCopyWith<$Res> {
  factory _$HarrisRelationModelCopyWith(_HarrisRelationModel value, $Res Function(_HarrisRelationModel) _then) = __$HarrisRelationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureId, String fromContextId, String toContextId, HarrisRelationType relationType, DateTime createdAt
});




}
/// @nodoc
class __$HarrisRelationModelCopyWithImpl<$Res>
    implements _$HarrisRelationModelCopyWith<$Res> {
  __$HarrisRelationModelCopyWithImpl(this._self, this._then);

  final _HarrisRelationModel _self;
  final $Res Function(_HarrisRelationModel) _then;

/// Create a copy of HarrisRelationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureId = null,Object? fromContextId = null,Object? toContextId = null,Object? relationType = null,Object? createdAt = null,}) {
  return _then(_HarrisRelationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,fromContextId: null == fromContextId ? _self.fromContextId : fromContextId // ignore: cast_nullable_to_non_nullable
as String,toContextId: null == toContextId ? _self.toContextId : toContextId // ignore: cast_nullable_to_non_nullable
as String,relationType: null == relationType ? _self.relationType : relationType // ignore: cast_nullable_to_non_nullable
as HarrisRelationType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
