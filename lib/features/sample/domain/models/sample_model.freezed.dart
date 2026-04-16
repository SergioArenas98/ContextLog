// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SampleModel {

 String get id; String get featureId; String get fillId; String get cutId; int get sampleNumber; SampleType get sampleType; String? get customSampleTypeText; StorageType get storageType; int get storageCount; double? get liters; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of SampleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleModelCopyWith<SampleModel> get copyWith => _$SampleModelCopyWithImpl<SampleModel>(this as SampleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.fillId, fillId) || other.fillId == fillId)&&(identical(other.cutId, cutId) || other.cutId == cutId)&&(identical(other.sampleNumber, sampleNumber) || other.sampleNumber == sampleNumber)&&(identical(other.sampleType, sampleType) || other.sampleType == sampleType)&&(identical(other.customSampleTypeText, customSampleTypeText) || other.customSampleTypeText == customSampleTypeText)&&(identical(other.storageType, storageType) || other.storageType == storageType)&&(identical(other.storageCount, storageCount) || other.storageCount == storageCount)&&(identical(other.liters, liters) || other.liters == liters)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,fillId,cutId,sampleNumber,sampleType,customSampleTypeText,storageType,storageCount,liters,createdAt,updatedAt);

@override
String toString() {
  return 'SampleModel(id: $id, featureId: $featureId, fillId: $fillId, cutId: $cutId, sampleNumber: $sampleNumber, sampleType: $sampleType, customSampleTypeText: $customSampleTypeText, storageType: $storageType, storageCount: $storageCount, liters: $liters, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SampleModelCopyWith<$Res>  {
  factory $SampleModelCopyWith(SampleModel value, $Res Function(SampleModel) _then) = _$SampleModelCopyWithImpl;
@useResult
$Res call({
 String id, String featureId, String fillId, String cutId, int sampleNumber, SampleType sampleType, String? customSampleTypeText, StorageType storageType, int storageCount, double? liters, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$SampleModelCopyWithImpl<$Res>
    implements $SampleModelCopyWith<$Res> {
  _$SampleModelCopyWithImpl(this._self, this._then);

  final SampleModel _self;
  final $Res Function(SampleModel) _then;

/// Create a copy of SampleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureId = null,Object? fillId = null,Object? cutId = null,Object? sampleNumber = null,Object? sampleType = null,Object? customSampleTypeText = freezed,Object? storageType = null,Object? storageCount = null,Object? liters = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,fillId: null == fillId ? _self.fillId : fillId // ignore: cast_nullable_to_non_nullable
as String,cutId: null == cutId ? _self.cutId : cutId // ignore: cast_nullable_to_non_nullable
as String,sampleNumber: null == sampleNumber ? _self.sampleNumber : sampleNumber // ignore: cast_nullable_to_non_nullable
as int,sampleType: null == sampleType ? _self.sampleType : sampleType // ignore: cast_nullable_to_non_nullable
as SampleType,customSampleTypeText: freezed == customSampleTypeText ? _self.customSampleTypeText : customSampleTypeText // ignore: cast_nullable_to_non_nullable
as String?,storageType: null == storageType ? _self.storageType : storageType // ignore: cast_nullable_to_non_nullable
as StorageType,storageCount: null == storageCount ? _self.storageCount : storageCount // ignore: cast_nullable_to_non_nullable
as int,liters: freezed == liters ? _self.liters : liters // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SampleModel].
extension SampleModelPatterns on SampleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SampleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SampleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SampleModel value)  $default,){
final _that = this;
switch (_that) {
case _SampleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SampleModel value)?  $default,){
final _that = this;
switch (_that) {
case _SampleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String featureId,  String fillId,  String cutId,  int sampleNumber,  SampleType sampleType,  String? customSampleTypeText,  StorageType storageType,  int storageCount,  double? liters,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SampleModel() when $default != null:
return $default(_that.id,_that.featureId,_that.fillId,_that.cutId,_that.sampleNumber,_that.sampleType,_that.customSampleTypeText,_that.storageType,_that.storageCount,_that.liters,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String featureId,  String fillId,  String cutId,  int sampleNumber,  SampleType sampleType,  String? customSampleTypeText,  StorageType storageType,  int storageCount,  double? liters,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SampleModel():
return $default(_that.id,_that.featureId,_that.fillId,_that.cutId,_that.sampleNumber,_that.sampleType,_that.customSampleTypeText,_that.storageType,_that.storageCount,_that.liters,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String featureId,  String fillId,  String cutId,  int sampleNumber,  SampleType sampleType,  String? customSampleTypeText,  StorageType storageType,  int storageCount,  double? liters,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SampleModel() when $default != null:
return $default(_that.id,_that.featureId,_that.fillId,_that.cutId,_that.sampleNumber,_that.sampleType,_that.customSampleTypeText,_that.storageType,_that.storageCount,_that.liters,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SampleModel implements SampleModel {
  const _SampleModel({required this.id, required this.featureId, required this.fillId, required this.cutId, required this.sampleNumber, required this.sampleType, this.customSampleTypeText, required this.storageType, this.storageCount = 1, this.liters, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String featureId;
@override final  String fillId;
@override final  String cutId;
@override final  int sampleNumber;
@override final  SampleType sampleType;
@override final  String? customSampleTypeText;
@override final  StorageType storageType;
@override@JsonKey() final  int storageCount;
@override final  double? liters;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of SampleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleModelCopyWith<_SampleModel> get copyWith => __$SampleModelCopyWithImpl<_SampleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SampleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.fillId, fillId) || other.fillId == fillId)&&(identical(other.cutId, cutId) || other.cutId == cutId)&&(identical(other.sampleNumber, sampleNumber) || other.sampleNumber == sampleNumber)&&(identical(other.sampleType, sampleType) || other.sampleType == sampleType)&&(identical(other.customSampleTypeText, customSampleTypeText) || other.customSampleTypeText == customSampleTypeText)&&(identical(other.storageType, storageType) || other.storageType == storageType)&&(identical(other.storageCount, storageCount) || other.storageCount == storageCount)&&(identical(other.liters, liters) || other.liters == liters)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,fillId,cutId,sampleNumber,sampleType,customSampleTypeText,storageType,storageCount,liters,createdAt,updatedAt);

@override
String toString() {
  return 'SampleModel(id: $id, featureId: $featureId, fillId: $fillId, cutId: $cutId, sampleNumber: $sampleNumber, sampleType: $sampleType, customSampleTypeText: $customSampleTypeText, storageType: $storageType, storageCount: $storageCount, liters: $liters, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SampleModelCopyWith<$Res> implements $SampleModelCopyWith<$Res> {
  factory _$SampleModelCopyWith(_SampleModel value, $Res Function(_SampleModel) _then) = __$SampleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureId, String fillId, String cutId, int sampleNumber, SampleType sampleType, String? customSampleTypeText, StorageType storageType, int storageCount, double? liters, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$SampleModelCopyWithImpl<$Res>
    implements _$SampleModelCopyWith<$Res> {
  __$SampleModelCopyWithImpl(this._self, this._then);

  final _SampleModel _self;
  final $Res Function(_SampleModel) _then;

/// Create a copy of SampleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureId = null,Object? fillId = null,Object? cutId = null,Object? sampleNumber = null,Object? sampleType = null,Object? customSampleTypeText = freezed,Object? storageType = null,Object? storageCount = null,Object? liters = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_SampleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,fillId: null == fillId ? _self.fillId : fillId // ignore: cast_nullable_to_non_nullable
as String,cutId: null == cutId ? _self.cutId : cutId // ignore: cast_nullable_to_non_nullable
as String,sampleNumber: null == sampleNumber ? _self.sampleNumber : sampleNumber // ignore: cast_nullable_to_non_nullable
as int,sampleType: null == sampleType ? _self.sampleType : sampleType // ignore: cast_nullable_to_non_nullable
as SampleType,customSampleTypeText: freezed == customSampleTypeText ? _self.customSampleTypeText : customSampleTypeText // ignore: cast_nullable_to_non_nullable
as String?,storageType: null == storageType ? _self.storageType : storageType // ignore: cast_nullable_to_non_nullable
as StorageType,storageCount: null == storageCount ? _self.storageCount : storageCount // ignore: cast_nullable_to_non_nullable
as int,liters: freezed == liters ? _self.liters : liters // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
