// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'context_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContextModel {

 String get id; String get featureId; int get contextNumber; String? get notes; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContextModelCopyWith<ContextModel> get copyWith => _$ContextModelCopyWithImpl<ContextModel>(this as ContextModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.contextNumber, contextNumber) || other.contextNumber == contextNumber)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,contextNumber,notes,createdAt,updatedAt);

@override
String toString() {
  return 'ContextModel(id: $id, featureId: $featureId, contextNumber: $contextNumber, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ContextModelCopyWith<$Res>  {
  factory $ContextModelCopyWith(ContextModel value, $Res Function(ContextModel) _then) = _$ContextModelCopyWithImpl;
@useResult
$Res call({
 String id, String featureId, int contextNumber, String? notes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ContextModelCopyWithImpl<$Res>
    implements $ContextModelCopyWith<$Res> {
  _$ContextModelCopyWithImpl(this._self, this._then);

  final ContextModel _self;
  final $Res Function(ContextModel) _then;

/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureId = null,Object? contextNumber = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,contextNumber: null == contextNumber ? _self.contextNumber : contextNumber // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ContextModel].
extension ContextModelPatterns on ContextModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CutModel value)?  cut,TResult Function( FillModel value)?  fill,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CutModel() when cut != null:
return cut(_that);case FillModel() when fill != null:
return fill(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CutModel value)  cut,required TResult Function( FillModel value)  fill,}){
final _that = this;
switch (_that) {
case CutModel():
return cut(_that);case FillModel():
return fill(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CutModel value)?  cut,TResult? Function( FillModel value)?  fill,}){
final _that = this;
switch (_that) {
case CutModel() when cut != null:
return cut(_that);case FillModel() when fill != null:
return fill(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String featureId,  int contextNumber,  CutType? cutType,  String? customCutTypeText,  double? height,  double? width,  double? depth,  String? notes,  DateTime createdAt,  DateTime updatedAt)?  cut,TResult Function( String id,  String featureId,  int contextNumber,  String? parentCutId,  FillComposition? composition,  String? color,  FillCompaction? compaction,  String? inclusions,  String? notes,  DateTime createdAt,  DateTime updatedAt)?  fill,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CutModel() when cut != null:
return cut(_that.id,_that.featureId,_that.contextNumber,_that.cutType,_that.customCutTypeText,_that.height,_that.width,_that.depth,_that.notes,_that.createdAt,_that.updatedAt);case FillModel() when fill != null:
return fill(_that.id,_that.featureId,_that.contextNumber,_that.parentCutId,_that.composition,_that.color,_that.compaction,_that.inclusions,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String featureId,  int contextNumber,  CutType? cutType,  String? customCutTypeText,  double? height,  double? width,  double? depth,  String? notes,  DateTime createdAt,  DateTime updatedAt)  cut,required TResult Function( String id,  String featureId,  int contextNumber,  String? parentCutId,  FillComposition? composition,  String? color,  FillCompaction? compaction,  String? inclusions,  String? notes,  DateTime createdAt,  DateTime updatedAt)  fill,}) {final _that = this;
switch (_that) {
case CutModel():
return cut(_that.id,_that.featureId,_that.contextNumber,_that.cutType,_that.customCutTypeText,_that.height,_that.width,_that.depth,_that.notes,_that.createdAt,_that.updatedAt);case FillModel():
return fill(_that.id,_that.featureId,_that.contextNumber,_that.parentCutId,_that.composition,_that.color,_that.compaction,_that.inclusions,_that.notes,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String featureId,  int contextNumber,  CutType? cutType,  String? customCutTypeText,  double? height,  double? width,  double? depth,  String? notes,  DateTime createdAt,  DateTime updatedAt)?  cut,TResult? Function( String id,  String featureId,  int contextNumber,  String? parentCutId,  FillComposition? composition,  String? color,  FillCompaction? compaction,  String? inclusions,  String? notes,  DateTime createdAt,  DateTime updatedAt)?  fill,}) {final _that = this;
switch (_that) {
case CutModel() when cut != null:
return cut(_that.id,_that.featureId,_that.contextNumber,_that.cutType,_that.customCutTypeText,_that.height,_that.width,_that.depth,_that.notes,_that.createdAt,_that.updatedAt);case FillModel() when fill != null:
return fill(_that.id,_that.featureId,_that.contextNumber,_that.parentCutId,_that.composition,_that.color,_that.compaction,_that.inclusions,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class CutModel implements ContextModel {
  const CutModel({required this.id, required this.featureId, required this.contextNumber, this.cutType, this.customCutTypeText, this.height, this.width, this.depth, this.notes, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String featureId;
@override final  int contextNumber;
 final  CutType? cutType;
 final  String? customCutTypeText;
 final  double? height;
 final  double? width;
 final  double? depth;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CutModelCopyWith<CutModel> get copyWith => _$CutModelCopyWithImpl<CutModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.contextNumber, contextNumber) || other.contextNumber == contextNumber)&&(identical(other.cutType, cutType) || other.cutType == cutType)&&(identical(other.customCutTypeText, customCutTypeText) || other.customCutTypeText == customCutTypeText)&&(identical(other.height, height) || other.height == height)&&(identical(other.width, width) || other.width == width)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,contextNumber,cutType,customCutTypeText,height,width,depth,notes,createdAt,updatedAt);

@override
String toString() {
  return 'ContextModel.cut(id: $id, featureId: $featureId, contextNumber: $contextNumber, cutType: $cutType, customCutTypeText: $customCutTypeText, height: $height, width: $width, depth: $depth, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CutModelCopyWith<$Res> implements $ContextModelCopyWith<$Res> {
  factory $CutModelCopyWith(CutModel value, $Res Function(CutModel) _then) = _$CutModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureId, int contextNumber, CutType? cutType, String? customCutTypeText, double? height, double? width, double? depth, String? notes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$CutModelCopyWithImpl<$Res>
    implements $CutModelCopyWith<$Res> {
  _$CutModelCopyWithImpl(this._self, this._then);

  final CutModel _self;
  final $Res Function(CutModel) _then;

/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureId = null,Object? contextNumber = null,Object? cutType = freezed,Object? customCutTypeText = freezed,Object? height = freezed,Object? width = freezed,Object? depth = freezed,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(CutModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,contextNumber: null == contextNumber ? _self.contextNumber : contextNumber // ignore: cast_nullable_to_non_nullable
as int,cutType: freezed == cutType ? _self.cutType : cutType // ignore: cast_nullable_to_non_nullable
as CutType?,customCutTypeText: freezed == customCutTypeText ? _self.customCutTypeText : customCutTypeText // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class FillModel implements ContextModel {
  const FillModel({required this.id, required this.featureId, required this.contextNumber, this.parentCutId, this.composition, this.color, this.compaction, this.inclusions, this.notes, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String featureId;
@override final  int contextNumber;
/// Null for spread features where fills have no parent cut.
 final  String? parentCutId;
 final  FillComposition? composition;
 final  String? color;
 final  FillCompaction? compaction;
 final  String? inclusions;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FillModelCopyWith<FillModel> get copyWith => _$FillModelCopyWithImpl<FillModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillModel&&(identical(other.id, id) || other.id == id)&&(identical(other.featureId, featureId) || other.featureId == featureId)&&(identical(other.contextNumber, contextNumber) || other.contextNumber == contextNumber)&&(identical(other.parentCutId, parentCutId) || other.parentCutId == parentCutId)&&(identical(other.composition, composition) || other.composition == composition)&&(identical(other.color, color) || other.color == color)&&(identical(other.compaction, compaction) || other.compaction == compaction)&&(identical(other.inclusions, inclusions) || other.inclusions == inclusions)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,featureId,contextNumber,parentCutId,composition,color,compaction,inclusions,notes,createdAt,updatedAt);

@override
String toString() {
  return 'ContextModel.fill(id: $id, featureId: $featureId, contextNumber: $contextNumber, parentCutId: $parentCutId, composition: $composition, color: $color, compaction: $compaction, inclusions: $inclusions, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FillModelCopyWith<$Res> implements $ContextModelCopyWith<$Res> {
  factory $FillModelCopyWith(FillModel value, $Res Function(FillModel) _then) = _$FillModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String featureId, int contextNumber, String? parentCutId, FillComposition? composition, String? color, FillCompaction? compaction, String? inclusions, String? notes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$FillModelCopyWithImpl<$Res>
    implements $FillModelCopyWith<$Res> {
  _$FillModelCopyWithImpl(this._self, this._then);

  final FillModel _self;
  final $Res Function(FillModel) _then;

/// Create a copy of ContextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureId = null,Object? contextNumber = null,Object? parentCutId = freezed,Object? composition = freezed,Object? color = freezed,Object? compaction = freezed,Object? inclusions = freezed,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(FillModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureId: null == featureId ? _self.featureId : featureId // ignore: cast_nullable_to_non_nullable
as String,contextNumber: null == contextNumber ? _self.contextNumber : contextNumber // ignore: cast_nullable_to_non_nullable
as int,parentCutId: freezed == parentCutId ? _self.parentCutId : parentCutId // ignore: cast_nullable_to_non_nullable
as String?,composition: freezed == composition ? _self.composition : composition // ignore: cast_nullable_to_non_nullable
as FillComposition?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,compaction: freezed == compaction ? _self.compaction : compaction // ignore: cast_nullable_to_non_nullable
as FillCompaction?,inclusions: freezed == inclusions ? _self.inclusions : inclusions // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
