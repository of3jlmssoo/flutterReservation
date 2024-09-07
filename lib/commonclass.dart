class ReservationInputsBase {
  const ReservationInputsBase({required this.reservationDate, required this.facility});
  final DateTime reservationDate;
  final String facility;
}

class ReservationInputsExt extends ReservationInputsBase {
  ReservationInputsExt(
      {required this.name,
      required this.emaill,
      required this.tel,
      required super.reservationDate,
      required super.facility});
  final String name;
  final String emaill;
  final String tel;
}
