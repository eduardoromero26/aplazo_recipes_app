// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipes_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipesState()';
}


}

/// @nodoc
class $RecipesStateCopyWith<$Res>  {
$RecipesStateCopyWith(RecipesState _, $Res Function(RecipesState) __);
}


/// @nodoc


class _Initial implements RecipesState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipesState.initial()';
}


}




/// @nodoc


class _LoadingStarted implements RecipesState {
  const _LoadingStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipesState.loadingStarted()';
}


}




/// @nodoc


class _LoadedSuccess implements RecipesState {
  const _LoadedSuccess(this.meals);
  

 final  MealsModel? meals;

/// Create a copy of RecipesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedSuccessCopyWith<_LoadedSuccess> get copyWith => __$LoadedSuccessCopyWithImpl<_LoadedSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedSuccess&&(identical(other.meals, meals) || other.meals == meals));
}


@override
int get hashCode => Object.hash(runtimeType,meals);

@override
String toString() {
  return 'RecipesState.loadedSuccess(meals: $meals)';
}


}

/// @nodoc
abstract mixin class _$LoadedSuccessCopyWith<$Res> implements $RecipesStateCopyWith<$Res> {
  factory _$LoadedSuccessCopyWith(_LoadedSuccess value, $Res Function(_LoadedSuccess) _then) = __$LoadedSuccessCopyWithImpl;
@useResult
$Res call({
 MealsModel? meals
});




}
/// @nodoc
class __$LoadedSuccessCopyWithImpl<$Res>
    implements _$LoadedSuccessCopyWith<$Res> {
  __$LoadedSuccessCopyWithImpl(this._self, this._then);

  final _LoadedSuccess _self;
  final $Res Function(_LoadedSuccess) _then;

/// Create a copy of RecipesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? meals = freezed,}) {
  return _then(_LoadedSuccess(
freezed == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as MealsModel?,
  ));
}


}

/// @nodoc


class _LoadedFailed implements RecipesState {
  const _LoadedFailed(this.message);
  

 final  String message;

/// Create a copy of RecipesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedFailedCopyWith<_LoadedFailed> get copyWith => __$LoadedFailedCopyWithImpl<_LoadedFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RecipesState.loadedFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$LoadedFailedCopyWith<$Res> implements $RecipesStateCopyWith<$Res> {
  factory _$LoadedFailedCopyWith(_LoadedFailed value, $Res Function(_LoadedFailed) _then) = __$LoadedFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$LoadedFailedCopyWithImpl<$Res>
    implements _$LoadedFailedCopyWith<$Res> {
  __$LoadedFailedCopyWithImpl(this._self, this._then);

  final _LoadedFailed _self;
  final $Res Function(_LoadedFailed) _then;

/// Create a copy of RecipesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_LoadedFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
