import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/reservation.dart';

void showReservationInstanceVariables(
  bool status,
  Logger log,
  Reservation r,
) {
  if (status != true) return;

  var logstatus = Logger.root.level;
  // status ? Logger.root.level = Level.ALL : Logger.root.level = Level.OFF;
  Logger.root.level = Level.ALL;
  log.info("showReservationInstanceVariables reserveOn   ${r.reserveOn}    ${r.reserveOn.runtimeType}");
  log.info("showReservationInstanceVariables reserveMade ${r.reserveMade} ${r.reserveMade.runtimeType}");
  log.info("showReservationInstanceVariables faclity     ${r.facility}    ${r.facility.runtimeType}");
  log.info("showReservationInstanceVariables uid         ${r.uid}         ${r.uid..runtimeType}");
  log.info("showReservationInstanceVariables tel         ${r.tel}         ${r.tel.runtimeType}");
  log.info("showReservationInstanceVariables email       ${r.email}       ${r.email.runtimeType}");
  log.info("showReservationInstanceVariables status      ${r.status}      ${r.status.runtimeType}");
  log.info("showReservationInstanceVariables reservers   ${r.reservers}   ${r.reservers.runtimeType}");
  Logger.root.level = logstatus;
}

void logmessage(bool b, Logger l, String s) {
  if (b == false) return;
  var logstatus = Logger.root.level;
  Logger.root.level = Level.ALL;
  l.info(s);
  Logger.root.level = logstatus;
}

// List<Reservation4Display> copyReservation4Display(List<Reservation> reservationList) {
Future<void> copyReservation4Display(List<Reservation>? reservationList) async {
  List<Reservation4Display> results = [];
  if (reservationList != null) {
    for (var r in reservationList) {
      // var rOn = DateFormat('yyyy年M月d日').format(r.reserveOn);
      // var rMade = DateFormat('yyyy年M月d日').format(r.reserveMade);

      // var f = reservationList[0].facility as DocumentReference<Map<String, dynamic>>;
      // var facility = await facilityName(f);
      // var uid = r.uid;
      // var tel = r.tel ?? "登録なし";
      // var email = r.email ?? "登録なし";
      // var status = r.status;

      // var rstatus = getReservationStatus(status!);

      // var reservers = r.reservers;
      // logmessage(
      // true, log, "$rMade $rOn $facility ${uid.substring(0, 3)} $tel $email ${rstatus.displayName} $reservers");
      results.add(
        Reservation4Display(
          reserveOn: DateFormat('yyyy年M月d日').format(r.reserveOn),
          reserveMade: DateFormat('yyyy年M月d日').format(r.reserveMade),
          // facility: facility,
          facility: await facilityName(r.facility as DocumentReference<Map<String, dynamic>>),
          uid: r.uid.substring(0, 3),
          status: getReservationStatus(r.status!).displayName,
          reservers: r.reservers,
          tel: r.tel ?? "登録なし",
          email: r.email ?? "登録なし",
        ),
      );
      logmessage(false, log, "copyReservation4Display ${results.last}");
    }
    logmessage(false, log, "copyReservation4Display ${reservationList.length} ${results.length} $results");
  }
}

Future<String> facilityName(DocumentReference<Map<String, dynamic>> f) async {
  // logmessage(true, log, "facilityName called");
  String result = "エラー";
  await f.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;

      result = data["name"];
    },
    onError: (e) => log.info("facilityName() Error getting document: $e"),
  );

  logmessage(false, log, "facilityName() $result");
  return result;
}
