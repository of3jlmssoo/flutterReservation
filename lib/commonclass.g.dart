// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commonclass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationInputsExtImpl _$$ReservationInputsExtImplFromJson(
        Map<String, dynamic> json) =>
    _$ReservationInputsExtImpl(
      reservationDate: DateTime.parse(json['reservationDate'] as String),
      facility: json['facility'] as String,
      name: json['name'] as String,
      emaill: json['emaill'] as String,
      tel: json['tel'] as String,
    );

Map<String, dynamic> _$$ReservationInputsExtImplToJson(
        _$ReservationInputsExtImpl instance) =>
    <String, dynamic>{
      'reservationDate': instance.reservationDate.toIso8601String(),
      'facility': instance.facility,
      'name': instance.name,
      'emaill': instance.emaill,
      'tel': instance.tel,
    };

_$ReservationInputsBaseImpl _$$ReservationInputsBaseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReservationInputsBaseImpl(
      reservationDate: DateTime.parse(json['reservationDate'] as String),
      facility: json['facility'] as String,
    );

Map<String, dynamic> _$$ReservationInputsBaseImplToJson(
        _$ReservationInputsBaseImpl instance) =>
    <String, dynamic>{
      'reservationDate': instance.reservationDate.toIso8601String(),
      'facility': instance.facility,
    };
