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
  String? get email =>
      throw _privateConstructorUsedError; // @Default(ReservationStatus.none) ReservationStatus status,
  String? get status => throw _privateConstructorUsedError;
  List<String>? get reservers => throw _privateConstructorUsedError;
  String? get firestoreID => throw _privateConstructorUsedError;

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
      String? status,
      List<String>? reservers,
      String? firestoreID});
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
    Object? status = freezed,
    Object? reservers = freezed,
    Object? firestoreID = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      reservers: freezed == reservers
          ? _value.reservers
          : reservers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      firestoreID: freezed == firestoreID
          ? _value.firestoreID
          : firestoreID // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String? status,
      List<String>? reservers,
      String? firestoreID});
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
    Object? status = freezed,
    Object? reservers = freezed,
    Object? firestoreID = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      reservers: freezed == reservers
          ? _value._reservers
          : reservers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      firestoreID: freezed == firestoreID
          ? _value.firestoreID
          : firestoreID // ignore: cast_nullable_to_non_nullable
              as String?,
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
      this.status,
      required final List<String>? reservers,
      this.firestoreID})
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
// @Default(ReservationStatus.none) ReservationStatus status,
  @override
  final String? status;
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
  final String? firestoreID;

  @override
  String toString() {
    return 'Reservation(reserveOn: $reserveOn, reserveMade: $reserveMade, facility: $facility, uid: $uid, tel: $tel, email: $email, status: $status, reservers: $reservers, firestoreID: $firestoreID)';
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
                .equals(other._reservers, _reservers) &&
            (identical(other.firestoreID, firestoreID) ||
                other.firestoreID == firestoreID));
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
      const DeepCollectionEquality().hash(_reservers),
      firestoreID);

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
      final String? status,
      required final List<String>? reservers,
      final String? firestoreID}) = _$ReservationImpl;
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
  String?
      get email; // @Default(ReservationStatus.none) ReservationStatus status,
  @override
  String? get status;
  @override
  List<String>? get reservers;
  @override
  String? get firestoreID;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReservationsAndText {
  String get title => throw _privateConstructorUsedError;
  List<Reservation> get reservations => throw _privateConstructorUsedError;

  /// Create a copy of ReservationsAndText
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationsAndTextCopyWith<ReservationsAndText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationsAndTextCopyWith<$Res> {
  factory $ReservationsAndTextCopyWith(
          ReservationsAndText value, $Res Function(ReservationsAndText) then) =
      _$ReservationsAndTextCopyWithImpl<$Res, ReservationsAndText>;
  @useResult
  $Res call({String title, List<Reservation> reservations});
}

/// @nodoc
class _$ReservationsAndTextCopyWithImpl<$Res, $Val extends ReservationsAndText>
    implements $ReservationsAndTextCopyWith<$Res> {
  _$ReservationsAndTextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReservationsAndText
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? reservations = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      reservations: null == reservations
          ? _value.reservations
          : reservations // ignore: cast_nullable_to_non_nullable
              as List<Reservation>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationsAndTextImplCopyWith<$Res>
    implements $ReservationsAndTextCopyWith<$Res> {
  factory _$$ReservationsAndTextImplCopyWith(_$ReservationsAndTextImpl value,
          $Res Function(_$ReservationsAndTextImpl) then) =
      __$$ReservationsAndTextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<Reservation> reservations});
}

/// @nodoc
class __$$ReservationsAndTextImplCopyWithImpl<$Res>
    extends _$ReservationsAndTextCopyWithImpl<$Res, _$ReservationsAndTextImpl>
    implements _$$ReservationsAndTextImplCopyWith<$Res> {
  __$$ReservationsAndTextImplCopyWithImpl(_$ReservationsAndTextImpl _value,
      $Res Function(_$ReservationsAndTextImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReservationsAndText
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? reservations = null,
  }) {
    return _then(_$ReservationsAndTextImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      reservations: null == reservations
          ? _value._reservations
          : reservations // ignore: cast_nullable_to_non_nullable
              as List<Reservation>,
    ));
  }
}

/// @nodoc

class _$ReservationsAndTextImpl extends _ReservationsAndText {
  const _$ReservationsAndTextImpl(
      {required this.title, required final List<Reservation> reservations})
      : _reservations = reservations,
        super._();

  @override
  final String title;
  final List<Reservation> _reservations;
  @override
  List<Reservation> get reservations {
    if (_reservations is EqualUnmodifiableListView) return _reservations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reservations);
  }

  @override
  String toString() {
    return 'ReservationsAndText(title: $title, reservations: $reservations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationsAndTextImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._reservations, _reservations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, const DeepCollectionEquality().hash(_reservations));

  /// Create a copy of ReservationsAndText
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationsAndTextImplCopyWith<_$ReservationsAndTextImpl> get copyWith =>
      __$$ReservationsAndTextImplCopyWithImpl<_$ReservationsAndTextImpl>(
          this, _$identity);
}

abstract class _ReservationsAndText extends ReservationsAndText {
  const factory _ReservationsAndText(
          {required final String title,
          required final List<Reservation> reservations}) =
      _$ReservationsAndTextImpl;
  const _ReservationsAndText._() : super._();

  @override
  String get title;
  @override
  List<Reservation> get reservations;

  /// Create a copy of ReservationsAndText
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationsAndTextImplCopyWith<_$ReservationsAndTextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
