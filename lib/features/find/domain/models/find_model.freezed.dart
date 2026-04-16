// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'find_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FindModel {

 String get id; String get featureId; String get fillId; int get findNumber; FindMaterialType get materialType; String? get customMaterialText; int get quantity; String? get description; String? get localImagePath; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of FindModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FindModelCopyWith<FindModel> get copyWith => _$FindModelCopyWithImpl<FindModel>(this as FindModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FindModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.fillId, fillId) || other.fillId == fillId)&&(identical(other.findNumber, findNumber) || other.findNumber == findNumber)&&(identical(other.materialType, materialType) || other.materialType == materialType)&&(identical(other.customMaterialText, customMaterialText) || other.customMaterialText == customMaterialText)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.description, description) || other.description == description)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,fillId,findNumber,materialType,customMaterialText,quantity,description,localImagePath,createdAt,updatedAt);

@override
String toString() {
  return 'FindModel(id: $id, featureId: $featureId, fillId: $fillId, findNumber: $findNumber, materialType: $materialType, customMaterialText: $customMaterialText, quantity: $quantity, description: $description, localImagePath: $localImagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FindModelCopyWith<$Res>  {
  factory $FindModelCopyWith(FindModel value, $Res Function(FindModel) _then) = _$FindModelCopyWithImpl;
@useResult
$Res call({
 String id, String featureId, String fillId, int findNumber, FindMaterialType materialType, String? customMaterialText, int quantity, String? description, String? localImagePath, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$FindModelCopyWithImpl<$Res>
    implements $FindModelCopyWith<$Res> {
  _$FindModelCopyWithImpl(this._self, this._then);

  final FindModel _self;
  final $Res Function(FindModel) _then;

/// Create a copy of FindModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureId = null,Object? fillId = null,Object? findNumber = null,Object? materialType = null,Object? customMaterialText = freezed,Object? quantity = null,Object? description = freezed,Object? localImagePath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,fillId: null == fillId ? _self.fillId : fillId // ignore: cast_nullable_to_non_nullable
as String,findNumber: null == findNumber ? _self.findNumber : findNumber // ignore: cast_nullable_to_non_nullable
as int,materialType: null == materialType ? _self.materialType : materialType // ignore: cast_nullable_to_non_nullable
as FindMaterialType,customMaterialText: freezed == customMaterialText ? _self.customMaterialText : customMaterialText // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FindModel].
extension FindModelPatterns on FindModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FindModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FindModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FindModel value)  $default,){
final _that = this;
switch (_that) {
case _FindModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FindModel value)?  $default,){
final _that = this;
switch (_that) {
case _FindModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String featureId,  String fillId,  int findNumber,  FindMaterialType materialType,  String? customMaterialText,  int quantity,  String? description,  String? localImagePath,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FindModel() when $default != null:
return $default(_that.id,_that.featureId,_that.fillId,_that.findNumber,_that.materialType,_that.customMaterialText,_that.quantity,_that.description,_that.localImagePath,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String featureId,  String fillId,  int findNumber,  FindMaterialType materialType,  String? customMaterialText,  int quantity,  String? description,  String? localImagePath,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FindModel():
return $default(_that.id,_that.featureId,_that.fillId,_that.findNumber,_that.materialType,_that.customMaterialText,_that.quantity,_that.description,_that.localImagePath,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String featureId,  String fillId,  int findNumber,  FindMaterialType materialType,  String? customMaterialText,  int quantity,  String? description,  String? localImagePath,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FindModel() when $default != null:
return $default(_that.id,_that.featureId,_that.fillId,_that.findNumber,_that.materialType,_that.customMaterialText,_that.quantity,_that.description,_that.localImagePath,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FindModel implements FindModel {
  const _FindModel({required this.id, required this.featureId, required this.fillId, required this.findNumber, required this.materialType, this.customMaterialText, required this.quantity, this.description, this.localImagePath, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String featureId;
@override final  String fillId;
@override final  int findNumber;
@override final  FindMaterialType materialType;
@override final  String? customMaterialText;
@override final  int quantity;
@override final  String? description;
@override final  String? localImagePath;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of FindModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindModelCopyWith<_FindModel> get copyWith => __$FindModelCopyWithImpl<_FindModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.fillId, fillId) || other.fillId == fillId)&&(identical(other.findNumber, findNumber) || other.findNumber == findNumber)&&(identical(other.materialType, materialType) || other.materialType == materialType)&&(identical(other.customMaterialText, customMaterialText) || other.customMaterialText == customMaterialText)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.description, description) || other.description == description)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,fillId,findNumber,materialType,customMaterialText,quantity,description,localImagePath,createdAt,updatedAt);

@override
String toString() {
  return 'FindModel(id: $id, featureId: $featureId, fillId: $fillId, findNumber: $findNumber, materialType: $materialType, customMaterialText: $customMaterialText, quantity: $quantity, description: $description, localImagePath: $localImagePath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FindModelCopyWith<$Res> implements $FindModelCopyWith<$Res> {
  factory _$FindModelCopyWith(_FindModel value, $Res Function(_FindModel) _then) = __$FindModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureId, String fillId, int findNumber, FindMaterialType materialType, String? customMaterialText, int quantity, String? description, String? localImagePath, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$FindModelCopyWithImpl<$Res>
    implements _$FindModelCopyWith<$Res> {
  __$FindModelCopyWithImpl(this._self, this._then);

  final _FindModel _self;
  final $Res Function(_FindModel) _then;

/// Create a copy of FindModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureId = null,Object? fillId = null,Object? findNumber = null,Object? materialType = null,Object? customMaterialText = freezed,Object? quantity = null,Object? description = freezed,Object? localImagePath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_FindModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,fillId: null == fillId ? _self.fillId : fillId // ignore: cast_nullable_to_non_nullable
as String,findNumber: null == findNumber ? _self.findNumber : findNumber // ignore: cast_nullable_to_non_nullable
as int,materialType: null == materialType ? _self.materialType : materialType // ignore: cast_nullable_to_non_nullable
as FindMaterialType,customMaterialText: freezed == customMaterialText ? _self.customMaterialText : customMaterialText // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
