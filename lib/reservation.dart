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
  priority(displayName: "優"),
  reserved(displayName: "確"),
  notFound(displayName: "不");

  const ReservationStatus({
    required this.displayName,
  });

  final String displayName;
}

extension ReservationStatusExtension on ReservationStatus {
  static ReservationStatus statusfromString(String status) {
    log.info('--> fromString called!');
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
    return ReservationStatusExtension.statusfromString(json);
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
    log.info('-----------------------------------------------');
    log.info('-----------------------------------------------');
    log.info('-----------------------------------------------');
    log.info('-----------------------------------------------');
    log.info('-----------------------------------------------');
    log.info('-----------------------------------------------');
    log.info('-----------------------------------------------');
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
    List<String>? reservers,

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
    log.info('-- fromFiresstore --> data $data');
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
      // status: ReservationStatusExtension.statusfromString(data?['status']),
      status: data?["status"].statusfromString(),
      reservers: data?['reservers'] is Iterable ? List.from(data?['regions']) : null,
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
      if (reservers != null) "reservers": reservers,
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

  DocumentReference facilityRef(Enum facility) {
    return FirebaseFirestore.instance.collection("facilities").doc(facility.name);
  }

  ReservationStatus reservationExist(DateTime t, Enum f) {
    // if (ref.read(authRepositoryProvider).currentUser != null) {
    //   ref.read(authRepositoryProvider).signOut();
    // }
    // ref.read(firebaseAuthProvider).signInWithEmailAndPassword(email: "dummy3@dummy.com", password: "dummy3dummy3");

    final reserveRef = FirebaseFirestore.instance.collection("reservations");
    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(f.name);

    final formattedT = DateTime(t.year, t.month, t.day);

    ReservationStatus result = ReservationStatus.notFound;

    reserveRef
        .where("reserveOn", isEqualTo: formattedT)
        .where("facility", isEqualTo: facilityRef)
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation city, _) => city.toFirestore(),
        )
        .get()
        .then(
      (querySnapshot) {
        log.info("レコード有無照会1    Successfully completed ${querySnapshot.docs.length} ${querySnapshot.docs}");
        // there should be only one record for this query

        // result = querySnapshot.docs[0]["status"];
        // log.info('レコード有無照会2    ${querySnapshot.docs[0]["status"]} --- $result');

        for (var docSnapshot in querySnapshot.docs) {
          log.info('${docSnapshot.id} 1 ====> ${docSnapshot.data()}');
          // log.info(
          //     '${docSnapshot.id} 2 ====> ${docSnapshot.data()["status"]}  ${docSnapshot.data()["status"].runtimeType}');
          // log.info(
          //     '${docSnapshot.id} 2 ====> ${docSnapshot.data()["reserveOn"]}  ${docSnapshot.data()["reserveOn"].runtimeType}');
          // result = docSnapshot.data()["status"];
        }
      },
      onError: (e) => log.info("Error completing: $e"),
    );

    return result;
  }

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

    final formattedReserveOn = DateTime(reserveOn.year, reserveOn.month, reserveOn.day);

    final reservation = Reservation(
        reserveOn: formattedReserveOn,
        reserveMade: reserveMade,
        facility: facilityRef,
        uid: uid,
        status: status,
        reservers: [uid]);

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
