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

 String get id; String get site; String get trench; String get area; String get featureNumber; String get excavator; DateTime get date; String? get notes; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of FeatureModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureModelCopyWith<FeatureModel> get copyWith => _$FeatureModelCopyWithImpl<FeatureModel>(this as FeatureModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureModel&&(identical(other.id, id) || other.id == id)&&(identical(other.site, site) || other.site == site)&&(identical(other.trench, trench) || other.trench == trench)&&(identical(other.area, area) || other.area == area)&&(identical(other.featureNumber, featureNumber) || other.featureNumber == featureNumber)&&(identical(other.excavator, excavator) || other.excavator == excavator)&&(identical(other.date, date) || other.date == date)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,site,trench,area,featureNumber,excavator,date,notes,createdAt,updatedAt);

@override
String toString() {
  return 'FeatureModel(id: $id, site: $site, trench: $trench, area: $area, featureNumber: $featureNumber, excavator: $excavator, date: $date, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FeatureModelCopyWith<$Res>  {
  factory $FeatureModelCopyWith(FeatureModel value, $Res Function(FeatureModel) _then) = _$FeatureModelCopyWithImpl;
@useResult
$Res call({
 String id, String site, String trench, String area, String featureNumber, String excavator, DateTime date, String? notes, DateTime createdAt, DateTime updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? site = null,Object? trench = null,Object? area = null,Object? featureNumber = null,Object? excavator = null,Object? date = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,trench: null == trench ? _self.trench : trench // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,featureNumber: null == featureNumber ? _self.featureNumber : featureNumber // ignore: cast_nullable_to_non_nullable
as String,excavator: null == excavator ? _self.excavator : excavator // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String site,  String trench,  String area,  String featureNumber,  String excavator,  DateTime date,  String? notes,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeatureModel() when $default != null:
return $default(_that.id,_that.site,_that.trench,_that.area,_that.featureNumber,_that.excavator,_that.date,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String site,  String trench,  String area,  String featureNumber,  String excavator,  DateTime date,  String? notes,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FeatureModel():
return $default(_that.id,_that.site,_that.trench,_that.area,_that.featureNumber,_that.excavator,_that.date,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String site,  String trench,  String area,  String featureNumber,  String excavator,  DateTime date,  String? notes,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FeatureModel() when $default != null:
return $default(_that.id,_that.site,_that.trench,_that.area,_that.featureNumber,_that.excavator,_that.date,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FeatureModel implements FeatureModel {
  const _FeatureModel({required this.id, required this.site, required this.trench, required this.area, required this.featureNumber, required this.excavator, required this.date, this.notes, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String site;
@override final  String trench;
@override final  String area;
@override final  String featureNumber;
@override final  String excavator;
@override final  DateTime date;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of FeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureModelCopyWith<_FeatureModel> get copyWith => __$FeatureModelCopyWithImpl<_FeatureModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureModel&&(identical(other.id, id) || other.id == id)&&(identical(other.site, site) || other.site == site)&&(identical(other.trench, trench) || other.trench == trench)&&(identical(other.area, area) || other.area == area)&&(identical(other.featureNumber, featureNumber) || other.featureNumber == featureNumber)&&(identical(other.excavator, excavator) || other.excavator == excavator)&&(identical(other.date, date) || other.date == date)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,site,trench,area,featureNumber,excavator,date,notes,createdAt,updatedAt);

@override
String toString() {
  return 'FeatureModel(id: $id, site: $site, trench: $trench, area: $area, featureNumber: $featureNumber, excavator: $excavator, date: $date, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FeatureModelCopyWith<$Res> implements $FeatureModelCopyWith<$Res> {
  factory _$FeatureModelCopyWith(_FeatureModel value, $Res Function(_FeatureModel) _then) = __$FeatureModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String site, String trench, String area, String featureNumber, String excavator, DateTime date, String? notes, DateTime createdAt, DateTime updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? site = null,Object? trench = null,Object? area = null,Object? featureNumber = null,Object? excavator = null,Object? date = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_FeatureModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,trench: null == trench ? _self.trench : trench // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,featureNumber: null == featureNumber ? _self.featureNumber : featureNumber // ignore: cast_nullable_to_non_nullable
as String,excavator: null == excavator ? _self.excavator : excavator // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
