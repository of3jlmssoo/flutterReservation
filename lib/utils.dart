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
  var logstatus = Logger.root.level;
  Logger.root.level = Level.ALL;
  l.info(s);
  Logger.root.level = logstatus;
}
