import 'package:freezed_annotation/freezed_annotation.dart';

part 'commonclass.freezed.dart';
part 'commonclass.g.dart';

@freezed
class ReservationInputsExt with _$ReservationInputsExt {
  const factory ReservationInputsExt({
    required DateTime reservationDate,
    required String facility,
    required String name,
    required String emaill,
    required String tel,
  }) = _ReservationInputsExt;
  factory ReservationInputsExt.fromJson(Map<String, Object?> json) => _$ReservationInputsExtFromJson(json);
}

@freezed
class ReservationInputsBase with _$ReservationInputsBase {
  const factory ReservationInputsBase({
    required DateTime reservationDate,
    required String facility,
  }) = _ReservationInputsBase;
  factory ReservationInputsBase.fromJson(Map<String, Object?> json) => _$ReservationInputsBaseFromJson(json);
}

// class ReservationInputsBase with _$ReservationInputsBase{
//   const ReservationInputsBase({required this.reservationDate, required this.facility});
//   final DateTime reservationDate;
//   final String facility;
// }

// class ReservationInputsExt extends ReservationInputsBase {
//   ReservationInputsExt(
//       {required this.name,
//       required this.emaill,
//       required this.tel,
//       required super.reservationDate,
//       required super.facility});
//   final String name;
//   final String emaill;
//   final String tel;
// }


