// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeatureModel {

 String get id; String get featureNumber; String? get projectId; String? get area; bool get isNonArchaeological; DateTime get date; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of FeatureModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureModelCopyWith<FeatureModel> get copyWith => _$FeatureModelCopyWithImpl<FeatureModel>(this as FeatureModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureNumber, featureNumber) || other.featureNumber == featureNumber)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.area, area) || other.area == area)&&(identical(other.isNonArchaeological, isNonArchaeological) || other.isNonArchaeological == isNonArchaeological)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureNumber,projectId,area,isNonArchaeological,date,createdAt,updatedAt);

@override
String toString() {
  return 'FeatureModel(id: $id, featureNumber: $featureNumber, projectId: $projectId, area: $area, isNonArchaeological: $isNonArchaeological, date: $date, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FeatureModelCopyWith<$Res>  {
  factory $FeatureModelCopyWith(FeatureModel value, $Res Function(FeatureModel) _then) = _$FeatureModelCopyWithImpl;
@useResult
$Res call({
 String id, String featureNumber, String? projectId, String? area, bool isNonArchaeological, DateTime date, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$FeatureModelCopyWithImpl<$Res>
    implements $FeatureModelCopyWith<$Res> {
  _$FeatureModelCopyWithImpl(this._self, this._then);

  final FeatureModel _self;
  final $Res Function(FeatureModel) _then;

/// Create a copy of FeatureModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureNumber = null,Object? projectId = freezed,Object? area = freezed,Object? isNonArchaeological = null,Object? date = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureNumber: null == featureNumber ? _self.featureNumber : featureNumber // ignore: cast_nullable_to_non_nullable
as String,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,isNonArchaeological: null == isNonArchaeological ? _self.isNonArchaeological : isNonArchaeological // ignore: cast_nullable_to_non_nullable
as bool,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FeatureModel].
extension FeatureModelPatterns on FeatureModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeatureModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeatureModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeatureModel value)  $default,){
final _that = this;
switch (_that) {
case _FeatureModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeatureModel value)?  $default,){
final _that = this;
switch (_that) {
case _FeatureModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String featureNumber,  String? projectId,  String? area,  bool isNonArchaeological,  DateTime date,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeatureModel() when $default != null:
return $default(_that.id,_that.featureNumber,_that.projectId,_that.area,_that.isNonArchaeological,_that.date,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String featureNumber,  String? projectId,  String? area,  bool isNonArchaeological,  DateTime date,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FeatureModel():
return $default(_that.id,_that.featureNumber,_that.projectId,_that.area,_that.isNonArchaeological,_that.date,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String featureNumber,  String? projectId,  String? area,  bool isNonArchaeological,  DateTime date,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FeatureModel() when $default != null:
return $default(_that.id,_that.featureNumber,_that.projectId,_that.area,_that.isNonArchaeological,_that.date,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FeatureModel implements FeatureModel {
  const _FeatureModel({required this.id, required this.featureNumber, this.projectId, this.area, this.isNonArchaeological = false, required this.date, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String featureNumber;
@override final  String? projectId;
@override final  String? area;
@override@JsonKey() final  bool isNonArchaeological;
@override final  DateTime date;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of FeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureModelCopyWith<_FeatureModel> get copyWith => __$FeatureModelCopyWithImpl<_FeatureModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureNumber, featureNumber) || other.featureNumber == featureNumber)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.area, area) || other.area == area)&&(identical(other.isNonArchaeological, isNonArchaeological) || other.isNonArchaeological == isNonArchaeological)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureNumber,projectId,area,isNonArchaeological,date,createdAt,updatedAt);

@override
String toString() {
  return 'FeatureModel(id: $id, featureNumber: $featureNumber, projectId: $projectId, area: $area, isNonArchaeological: $isNonArchaeological, date: $date, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FeatureModelCopyWith<$Res> implements $FeatureModelCopyWith<$Res> {
  factory _$FeatureModelCopyWith(_FeatureModel value, $Res Function(_FeatureModel) _then) = __$FeatureModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureNumber, String? projectId, String? area, bool isNonArchaeological, DateTime date, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$FeatureModelCopyWithImpl<$Res>
    implements _$FeatureModelCopyWith<$Res> {
  __$FeatureModelCopyWithImpl(this._self, this._then);

  final _FeatureModel _self;
  final $Res Function(_FeatureModel) _then;

/// Create a copy of FeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureNumber = null,Object? projectId = freezed,Object? area = freezed,Object? isNonArchaeological = null,Object? date = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_FeatureModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureNumber: null == featureNumber ? _self.featureNumber : featureNumber // ignore: cast_nullable_to_non_nullable
as String,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,isNonArchaeological: null == isNonArchaeological ? _self.isNonArchaeological : isNonArchaeological // ignore: cast_nullable_to_non_nullable
as bool,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
