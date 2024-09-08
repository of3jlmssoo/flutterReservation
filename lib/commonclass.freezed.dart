// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commonclass.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReservationInputsExt _$ReservationInputsExtFromJson(Map<String, dynamic> json) {
  return _ReservationInputsExt.fromJson(json);
}

/// @nodoc
mixin _$ReservationInputsExt {
  DateTime get reservationDate => throw _privateConstructorUsedError;
  String get facility => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get emaill => throw _privateConstructorUsedError;
  String get tel => throw _privateConstructorUsedError;

  /// Serializes this ReservationInputsExt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReservationInputsExt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationInputsExtCopyWith<ReservationInputsExt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationInputsExtCopyWith<$Res> {
  factory $ReservationInputsExtCopyWith(ReservationInputsExt value,
          $Res Function(ReservationInputsExt) then) =
      _$ReservationInputsExtCopyWithImpl<$Res, ReservationInputsExt>;
  @useResult
  $Res call(
      {DateTime reservationDate,
      String facility,
      String name,
      String emaill,
      String tel});
}

/// @nodoc
class _$ReservationInputsExtCopyWithImpl<$Res,
        $Val extends ReservationInputsExt>
    implements $ReservationInputsExtCopyWith<$Res> {
  _$ReservationInputsExtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationInputsExt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationDate = null,
    Object? facility = null,
    Object? name = null,
    Object? emaill = null,
    Object? tel = null,
  }) {
    return _then(_value.copyWith(
      reservationDate: null == reservationDate
          ? _value.reservationDate
          : reservationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      facility: null == facility
          ? _value.facility
          : facility // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      emaill: null == emaill
          ? _value.emaill
          : emaill // ignore: cast_nullable_to_non_nullable
              as String,
      tel: null == tel
          ? _value.tel
          : tel // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationInputsExtImplCopyWith<$Res>
    implements $ReservationInputsExtCopyWith<$Res> {
  factory _$$ReservationInputsExtImplCopyWith(_$ReservationInputsExtImpl value,
          $Res Function(_$ReservationInputsExtImpl) then) =
      __$$ReservationInputsExtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime reservationDate,
      String facility,
      String name,
      String emaill,
      String tel});
}

/// @nodoc
class __$$ReservationInputsExtImplCopyWithImpl<$Res>
    extends _$ReservationInputsExtCopyWithImpl<$Res, _$ReservationInputsExtImpl>
    implements _$$ReservationInputsExtImplCopyWith<$Res> {
  __$$ReservationInputsExtImplCopyWithImpl(_$ReservationInputsExtImpl _value,
      $Res Function(_$ReservationInputsExtImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReservationInputsExt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationDate = null,
    Object? facility = null,
    Object? name = null,
    Object? emaill = null,
    Object? tel = null,
  }) {
    return _then(_$ReservationInputsExtImpl(
      reservationDate: null == reservationDate
          ? _value.reservationDate
          : reservationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      facility: null == facility
          ? _value.facility
          : facility // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      emaill: null == emaill
          ? _value.emaill
          : emaill // ignore: cast_nullable_to_non_nullable
              as String,
      tel: null == tel
          ? _value.tel
          : tel // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationInputsExtImpl implements _ReservationInputsExt {
  const _$ReservationInputsExtImpl(
      {required this.reservationDate,
      required this.facility,
      required this.name,
      required this.emaill,
      required this.tel});

  factory _$ReservationInputsExtImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationInputsExtImplFromJson(json);

  @override
  final DateTime reservationDate;
  @override
  final String facility;
  @override
  final String name;
  @override
  final String emaill;
  @override
  final String tel;

  @override
  String toString() {
    return 'ReservationInputsExt(reservationDate: $reservationDate, facility: $facility, name: $name, emaill: $emaill, tel: $tel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationInputsExtImpl &&
            (identical(other.reservationDate, reservationDate) ||
                other.reservationDate == reservationDate) &&
            (identical(other.facility, facility) ||
                other.facility == facility) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emaill, emaill) || other.emaill == emaill) &&
            (identical(other.tel, tel) || other.tel == tel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, reservationDate, facility, name, emaill, tel);

  /// Create a copy of ReservationInputsExt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationInputsExtImplCopyWith<_$ReservationInputsExtImpl>
      get copyWith =>
          __$$ReservationInputsExtImplCopyWithImpl<_$ReservationInputsExtImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationInputsExtImplToJson(
      this,
    );
  }
}

abstract class _ReservationInputsExt implements ReservationInputsExt {
  const factory _ReservationInputsExt(
      {required final DateTime reservationDate,
      required final String facility,
      required final String name,
      required final String emaill,
      required final String tel}) = _$ReservationInputsExtImpl;

  factory _ReservationInputsExt.fromJson(Map<String, dynamic> json) =
      _$ReservationInputsExtImpl.fromJson;

  @override
  DateTime get reservationDate;
  @override
  String get facility;
  @override
  String get name;
  @override
  String get emaill;
  @override
  String get tel;

  /// Create a copy of ReservationInputsExt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationInputsExtImplCopyWith<_$ReservationInputsExtImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReservationInputsBase _$ReservationInputsBaseFromJson(
    Map<String, dynamic> json) {
  return _ReservationInputsBase.fromJson(json);
}

/// @nodoc
mixin _$ReservationInputsBase {
  DateTime get reservationDate => throw _privateConstructorUsedError;
  String get facility => throw _privateConstructorUsedError;

  /// Serializes this ReservationInputsBase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReservationInputsBase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationInputsBaseCopyWith<ReservationInputsBase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationInputsBaseCopyWith<$Res> {
  factory $ReservationInputsBaseCopyWith(ReservationInputsBase value,
          $Res Function(ReservationInputsBase) then) =
      _$ReservationInputsBaseCopyWithImpl<$Res, ReservationInputsBase>;
  @useResult
  $Res call({DateTime reservationDate, String facility});
}

/// @nodoc
class _$ReservationInputsBaseCopyWithImpl<$Res,
        $Val extends ReservationInputsBase>
    implements $ReservationInputsBaseCopyWith<$Res> {
  _$ReservationInputsBaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationInputsBase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationDate = null,
    Object? facility = null,
  }) {
    return _then(_value.copyWith(
      reservationDate: null == reservationDate
          ? _value.reservationDate
          : reservationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      facility: null == facility
          ? _value.facility
          : facility // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationInputsBaseImplCopyWith<$Res>
    implements $ReservationInputsBaseCopyWith<$Res> {
  factory _$$ReservationInputsBaseImplCopyWith(
          _$ReservationInputsBaseImpl value,
          $Res Function(_$ReservationInputsBaseImpl) then) =
      __$$ReservationInputsBaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime reservationDate, String facility});
}

/// @nodoc
class __$$ReservationInputsBaseImplCopyWithImpl<$Res>
    extends _$ReservationInputsBaseCopyWithImpl<$Res,
        _$ReservationInputsBaseImpl>
    implements _$$ReservationInputsBaseImplCopyWith<$Res> {
  __$$ReservationInputsBaseImplCopyWithImpl(_$ReservationInputsBaseImpl _value,
      $Res Function(_$ReservationInputsBaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReservationInputsBase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservationDate = null,
    Object? facility = null,
  }) {
    return _then(_$ReservationInputsBaseImpl(
      reservationDate: null == reservationDate
          ? _value.reservationDate
          : reservationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      facility: null == facility
          ? _value.facility
          : facility // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationInputsBaseImpl implements _ReservationInputsBase {
  const _$ReservationInputsBaseImpl(
      {required this.reservationDate, required this.facility});

  factory _$ReservationInputsBaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationInputsBaseImplFromJson(json);

  @override
  final DateTime reservationDate;
  @override
  final String facility;

  @override
  String toString() {
    return 'ReservationInputsBase(reservationDate: $reservationDate, facility: $facility)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationInputsBaseImpl &&
            (identical(other.reservationDate, reservationDate) ||
                other.reservationDate == reservationDate) &&
            (identical(other.facility, facility) ||
                other.facility == facility));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reservationDate, facility);

  /// Create a copy of ReservationInputsBase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationInputsBaseImplCopyWith<_$ReservationInputsBaseImpl>
      get copyWith => __$$ReservationInputsBaseImplCopyWithImpl<
          _$ReservationInputsBaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationInputsBaseImplToJson(
      this,
    );
  }
}

abstract class _ReservationInputsBase implements ReservationInputsBase {
  const factory _ReservationInputsBase(
      {required final DateTime reservationDate,
      required final String facility}) = _$ReservationInputsBaseImpl;

  factory _ReservationInputsBase.fromJson(Map<String, dynamic> json) =
      _$ReservationInputsBaseImpl.fromJson;

  @override
  DateTime get reservationDate;
  @override
  String get facility;

  /// Create a copy of ReservationInputsBase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationInputsBaseImplCopyWith<_$ReservationInputsBaseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
