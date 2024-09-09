import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'consts.dart';

part 'reservation.freezed.dart';
// part 'reservation.g.dart';

// part 'reservation.g.dart';
final log = Logger('Reservation');

const String collectionReservation = "reservations";

enum ReservationStatus {
  none(displayName: "空"),
  tentative(displayName: "仮"),
  reserved(displayName: "済"),
  notFound(displayName: "不");

  const ReservationStatus({
    required this.displayName,
  });

  final String displayName;
}

extension ReservationStatusExtension on ReservationStatus {
  static ReservationStatus fromString(String status) {
    switch (status) {
      case 'none':
        return ReservationStatus.none;
      case 'tentative':
        return ReservationStatus.tentative;
      case 'reserved':
        return ReservationStatus.reserved;
      default:
        return ReservationStatus.notFound;
    }
  }

  static String statusToString(ReservationStatus status) {
    log.info('--> statusToString called!');
    switch (status) {
      case ReservationStatus.none:
        return 'none';
      case ReservationStatus.tentative:
        return 'tentative';
      case ReservationStatus.reserved:
        return 'reserved';
      default:
        return 'notFound';
    }
  }
}

class ReservationStatusConverter implements JsonConverter<ReservationStatus, String> {
  const ReservationStatusConverter();

  @override
  ReservationStatus fromJson(String json) {
    return ReservationStatusExtension.fromString(json);
  }

  @override
  String toJson(ReservationStatus status) {
    return ReservationStatusExtension.statusToString(status);
  }
}

class DateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }
}

@freezed
class Reservation with _$Reservation {
  const Reservation._();
  const factory Reservation({
    required DateTime reserveOn,
    required DateTime reserveMade,
    DocumentReference? facility,
    required String uid,
    String? tel,
    String? email,
    @Default(ReservationStatus.none) ReservationStatus status,

    // @JsonKey(name: "reserveOn") @DateTimeConverter() required DateTime reserveOn,
    // @JsonKey(name: "reserveMade") @DateTimeConverter() required DateTime reserveMade,
    // @JsonKey(name: "facility") DocumentReference? facility,
    // @JsonKey(name: "uid") required String uid,
    // @JsonKey(name: "tel") String? tel,
    // @JsonKey(name: "email") String? email,
    // @JsonKey(name: "status") @ReservationStatusConverter() required ReservationStatus status,
  }) = _Reservation;

  factory Reservation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    log.info('--> data $data');
    return Reservation(
      reserveOn: data?["reserveOn"].toDate(),
      reserveMade: data?['reserveMade'].toDate(),
      // reserveOn: data?['reservedOn'],
      // reserveMade: data?['reserveMade'],
      facility: data?['facility'],
      uid: data?['uid'],
      tel: data?['tel'],
      email: data?['emal'],
      // status: data?['status'],
      status: ReservationStatusExtension.fromString(data?['status']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "reserveOn": Timestamp.fromDate(reserveOn),
      "reserveMade": Timestamp.fromDate(reserveMade),
      if (facility != null) "facility": facility,
      "uid": uid,
      if (tel != null) "tel": tel,
      if (email != null) "email": email,
      "status": ReservationStatusExtension.statusToString(status),
      // "status": status,
      // if (reserveMade != null) "state": reserveMade,
      // if (facility != null) "facility": facility,
      // if (uid != null) "uid": uid,
      // if (tel != null) "tel": tel,
      // if (email != null) "email": email,
      // if (status != null) "status": status,
    };
  }
}

class ReservationRepository {
  ReservationRepository({required this.db});
  final FirebaseFirestore db;

  Future<void> getDocument() async {
    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(Facility.kitchen.name);
    db
        .collection("reservations")
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
        )
        .where("facility", isEqualTo: facilityRef)
        .get()
        .then(
      (querySnapshot) {
        log.info("Successfully completed ${querySnapshot.docs.length}");
        for (var docSnapshot in querySnapshot.docs) {
          log.info('${docSnapshot.id} ===> ${docSnapshot.data()}');
        }
      },
      onError: (e) => log.info("Error completing: $e"),
    );
  }

  Future<void> addReservation({
    required DateTime reserveOn,
    required DateTime reserveMade,
    required Facility facility,
    required ReservationStatus status,
    required String uid,
  }) async {
    log.info('--> addReservation1');
    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(facility.name);

    final reservation =
        Reservation(reserveOn: reserveOn, reserveMade: reserveMade, facility: facilityRef, uid: uid, status: status);

    db
        .collection(collectionReservation)
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
        )
        .doc()
        .set(reservation);
    log.info('--> addReservation2');
  }
}

class ReservationService {}
