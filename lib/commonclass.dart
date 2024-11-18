import 'package:freezed_annotation/freezed_annotation.dart';

import 'consts.dart';

part 'commonclass.freezed.dart';
part 'commonclass.g.dart';

// 予約に必要な情報をクラス化.
//
// ReservationInputBaseに名前、eメール、電話番号を追加。予約処理の後半で使用。
// (freezedでのextends方法が不明のため類似クラスを２つ定義)
@freezed
class ReservationInputsExt with _$ReservationInputsExt {
  //implements ReservationInputsBase {
  const factory ReservationInputsExt({
    required DateTime reservationDate,
    required String facility,
    required String name,
    required String emaill,
    required String tel,
  }) = _ReservationInputsExt;
  factory ReservationInputsExt.fromJson(Map<String, Object?> json) => _$ReservationInputsExtFromJson(json);
}

// 予約に必要な情報をクラス化.
//
// 予約処理の前半で使用。
@freezed
class ReservationInputsBase with _$ReservationInputsBase {
  const factory ReservationInputsBase({
    required DateTime reservationDate,
    required Facility facility,
  }) = _ReservationInputsBase;
  factory ReservationInputsBase.fromJson(Map<String, Object?> json) => _$ReservationInputsBaseFromJson(json);
}
