// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return _Reservation.fromJson(json);
}

/// @nodoc
mixin _$Reservation {
  DateTime get reserveOn => throw _privateConstructorUsedError;
  DateTime get reserveMade => throw _privateConstructorUsedError;
  @FacilityConverter()
  dynamic get facility => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String? get tel => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  ReservationStatus get status => throw _privateConstructorUsedError;
  List<String>? get reservers => throw _privateConstructorUsedError;

  /// Serializes this Reservation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
          Reservation value, $Res Function(Reservation) then) =
      _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call(
      {DateTime reserveOn,
      DateTime reserveMade,
      @FacilityConverter() dynamic facility,
      String uid,
      String? tel,
      String? email,
      ReservationStatus status,
      List<String>? reservers});
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reserveOn = null,
    Object? reserveMade = null,
    Object? facility = freezed,
    Object? uid = null,
    Object? tel = freezed,
    Object? email = freezed,
    Object? status = null,
    Object? reservers = freezed,
  }) {
    return _then(_value.copyWith(
      reserveOn: null == reserveOn
          ? _value.reserveOn
          : reserveOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reserveMade: null == reserveMade
          ? _value.reserveMade
          : reserveMade // ignore: cast_nullable_to_non_nullable
              as DateTime,
      facility: freezed == facility
          ? _value.facility
          : facility // ignore: cast_nullable_to_non_nullable
              as dynamic,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      tel: freezed == tel
          ? _value.tel
          : tel // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationStatus,
      reservers: freezed == reservers
          ? _value.reservers
          : reservers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationImplCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$ReservationImplCopyWith(
          _$ReservationImpl value, $Res Function(_$ReservationImpl) then) =
      __$$ReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime reserveOn,
      DateTime reserveMade,
      @FacilityConverter() dynamic facility,
      String uid,
      String? tel,
      String? email,
      ReservationStatus status,
      List<String>? reservers});
}

/// @nodoc
class __$$ReservationImplCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$ReservationImpl>
    implements _$$ReservationImplCopyWith<$Res> {
  __$$ReservationImplCopyWithImpl(
      _$ReservationImpl _value, $Res Function(_$ReservationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reserveOn = null,
    Object? reserveMade = null,
    Object? facility = freezed,
    Object? uid = null,
    Object? tel = freezed,
    Object? email = freezed,
    Object? status = null,
    Object? reservers = freezed,
  }) {
    return _then(_$ReservationImpl(
      reserveOn: null == reserveOn
          ? _value.reserveOn
          : reserveOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reserveMade: null == reserveMade
          ? _value.reserveMade
          : reserveMade // ignore: cast_nullable_to_non_nullable
              as DateTime,
      facility: freezed == facility ? _value.facility! : facility,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      tel: freezed == tel
          ? _value.tel
          : tel // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationStatus,
      reservers: freezed == reservers
          ? _value._reservers
          : reservers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationImpl extends _Reservation {
  const _$ReservationImpl(
      {required this.reserveOn,
      required this.reserveMade,
      @FacilityConverter() this.facility,
      required this.uid,
      this.tel,
      this.email,
      this.status = ReservationStatus.none,
      required final List<String>? reservers})
      : _reservers = reservers,
        super._();

  factory _$ReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationImplFromJson(json);

  @override
  final DateTime reserveOn;
  @override
  final DateTime reserveMade;
  @override
  @FacilityConverter()
  final dynamic facility;
  @override
  final String uid;
  @override
  final String? tel;
  @override
  final String? email;
  @override
  @JsonKey()
  final ReservationStatus status;
  final List<String>? _reservers;
  @override
  List<String>? get reservers {
    final value = _reservers;
    if (value == null) return null;
    if (_reservers is EqualUnmodifiableListView) return _reservers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Reservation(reserveOn: $reserveOn, reserveMade: $reserveMade, facility: $facility, uid: $uid, tel: $tel, email: $email, status: $status, reservers: $reservers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationImpl &&
            (identical(other.reserveOn, reserveOn) ||
                other.reserveOn == reserveOn) &&
            (identical(other.reserveMade, reserveMade) ||
                other.reserveMade == reserveMade) &&
            const DeepCollectionEquality().equals(other.facility, facility) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.tel, tel) || other.tel == tel) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._reservers, _reservers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      reserveOn,
      reserveMade,
      const DeepCollectionEquality().hash(facility),
      uid,
      tel,
      email,
      status,
      const DeepCollectionEquality().hash(_reservers));

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      __$$ReservationImplCopyWithImpl<_$ReservationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationImplToJson(
      this,
    );
  }
}

abstract class _Reservation extends Reservation {
  const factory _Reservation(
      {required final DateTime reserveOn,
      required final DateTime reserveMade,
      @FacilityConverter() final dynamic facility,
      required final String uid,
      final String? tel,
      final String? email,
      final ReservationStatus status,
      required final List<String>? reservers}) = _$ReservationImpl;
  const _Reservation._() : super._();

  factory _Reservation.fromJson(Map<String, dynamic> json) =
      _$ReservationImpl.fromJson;

  @override
  DateTime get reserveOn;
  @override
  DateTime get reserveMade;
  @override
  @FacilityConverter()
  dynamic get facility;
  @override
  String get uid;
  @override
  String? get tel;
  @override
  String? get email;
  @override
  ReservationStatus get status;
  @override
  List<String>? get reservers;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
