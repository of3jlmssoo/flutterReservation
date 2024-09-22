import 'package:logging/logging.dart';
import 'package:reservations2/reservation.dart';

void showReservationInstanceVariables(
  bool status,
  Logger log,
  Reservation r,
) {
  var logstatus = Logger.root.level;
  status ? Logger.root.level = Level.ALL : Logger.root.level = Level.OFF;
  log.info("------> reserveOn   ${r.reserveOn}    ${r.reserveOn.runtimeType}");
  log.info("------> reserveMade ${r.reserveMade} ${r.reserveMade.runtimeType}");
  log.info("------> faclity     ${r.facility}    ${r.facility.runtimeType}");
  log.info("------> uid         ${r.uid}         ${r.uid..runtimeType}");
  log.info("------> tel         ${r.tel}         ${r.tel.runtimeType}");
  log.info("------> email       ${r.email}       ${r.email.runtimeType}");
  log.info("------> status      ${r.status}      ${r.status.runtimeType}");
  log.info("------> reservers   ${r.reservers}   ${r.reservers.runtimeType}");
  Logger.root.level = logstatus;
}
