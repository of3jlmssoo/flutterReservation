// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationImpl _$$ReservationImplFromJson(Map<String, dynamic> json) =>
    _$ReservationImpl(
      reserveOn: DateTime.parse(json['reserveOn'] as String),
      reserveMade: DateTime.parse(json['reserveMade'] as String),
      facility: json['facility'],
      uid: json['uid'] as String,
      tel: json['tel'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String?,
      reservers: (json['reservers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      firestoreID: json['firestoreID'] as String?,
    );

Map<String, dynamic> _$$ReservationImplToJson(_$ReservationImpl instance) =>
    <String, dynamic>{
      'reserveOn': instance.reserveOn.toIso8601String(),
      'reserveMade': instance.reserveMade.toIso8601String(),
      'facility': instance.facility,
      'uid': instance.uid,
      'tel': instance.tel,
      'email': instance.email,
      'status': instance.status,
      'reservers': instance.reservers,
      'firestoreID': instance.firestoreID,
    };
