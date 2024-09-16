import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'consts.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

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
    log.info('ReservationStatusExtension --> fromString called! status : $status');
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

  static Map<String, dynamic> statusToString(ReservationStatus status) {
    log.info('--> statusToString called!');
    switch (status) {
      case ReservationStatus.none:
        return {"status": ReservationStatus.none.name};
      case ReservationStatus.tentative:
        return {'tentative': ReservationStatus.tentative.name};
      case ReservationStatus.reserved:
        return {'reserved': ReservationStatus.reserved.name};
      default:
        return {'notFound': ReservationStatus.notFound.name};
    }
  }
}

extension FacilityExtension on Facility {
  static DocumentReference<Object?> fromString(dynamic xxx) {
    log.info('---> FacilityExtension on Facility');
    return xxx as DocumentReference;
  }
}

class FacilityConverter implements JsonConverter<Facility, Map<String, dynamic>> {
  const FacilityConverter();

  @override
  Facility fromJson(dynamic json) {
    return json["facility"];
  }

  @override
  Map<String, dynamic> toJson(Facility object) {
    return {"facility": object};
  }
}

class ReservationStatusConverter implements JsonConverter<ReservationStatus, Map<String, dynamic>> {
  const ReservationStatusConverter();

  @override
  ReservationStatus fromJson(dynamic json) {
    log.info('ReservationStatusConverter json : $json');
    return ReservationStatusExtension.statusfromString(json);
  }

  @override
  Map<String, dynamic> toJson(ReservationStatus reservationStatu) {
    return ReservationStatusExtension.statusToString(reservationStatu);
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
  @JsonSerializable(explicitToJson: true)
  const Reservation._();
  const factory Reservation({
    required DateTime reserveOn,
    required DateTime reserveMade,
    @FacilityConverter() facility,
    required String uid,
    String? tel,
    String? email,
    @Default(ReservationStatus.none) @ReservationStatusConverter() ReservationStatus status,
    required List<String>? reservers,

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
    log.info('fromFirestore1 data $data ${data?.keys}');
    var d = data as Map<String, dynamic>;
    log.info('fromFirestore2 $d');
    log.info('fromFirestore3 ${data["reserveOn"]} XXX ${data["reserveOn"].toDate()}');
    log.info('fromFirestore4 ${data["reservers"]} ----- ${data["reservers"].runtimeType}}');
    log.info('fromFirestore5 ${data["status"]} ----- ${data["status"].runtimeType}}');

    var m = data["status"].map<String, String>((key, value) => MapEntry<String, String>(key, value.toString()));
    String s = 'none';
    for (var v in m.values) {
      s = v;
    }

    log.info('fromFirestore6 m : $m --- ${m.keys} --- ${m[m.keys]} ${m["tentative"]} s : $s');

    ReservationStatus rs = ReservationStatus.none;
    switch (s) {
      case 'none':
        rs = ReservationStatus.none;
      case 'tentative':
        rs = ReservationStatus.tentative;
      case 'reserved':
        rs = ReservationStatus.reserved;
      default:
        rs = ReservationStatus.notFound;
    }
    log.info('fromFirestore7 rs : $rs');
    log.info('fromFirestore8 facility : ${data["facility"]} --- ${data["facility"].runtimeType}}');

    final r = Reservation(
      reserveOn: data["reserveOn"].toDate(),
      reserveMade: data["reserveMade"].toDate(),
      uid: data["uid"],
      tel: data["tel"] ?? null,
      email: data["email"] ?? null,
      // reservers: data["reservers"].cast<String>() as List<String>,
      reservers: List<String>.from(data["reservers"]),
      status: rs,
      facility: data["facility"],

      // reservers: data["reservers"] ?? [],
    );
    return r;
    // log.info('XXXXX ${d["reserveOn"]} XXX ${d["reserveOn"].toDate()}');
    // return Reservation(
    //   reserveOn: data?["reserveOn"].toDate(),
    //   reserveMade: data?['reserveMade'].toDate(),
    //   // reserveOn: data?['reservedOn'],
    //   // reserveMade: data?['reserveMade'],
    //   facility: data?['facility'] as DocumentReference,
    //   uid: data?['uid'],
    //   tel: data?['tel'],
    //   email: data?['emal'],
    //   // status: data?['status'] as ReservationStatus,
    //   // status: ReservationStatusExtension.statusfromString(data?['status']),
    //   status: data?["status"].statusfromString(),
    //   reservers: data?['reservers'] is Iterable ? List.from(data?['regions']) : null,
    // );
  }

  Map<String, dynamic> toFirestore() {
    log.info('fromFireStore $reserveOn');
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

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);
}

class ReservationRepository {
  ReservationRepository({required this.db});
  final FirebaseFirestore db;

  DocumentReference facilityRef(Enum facility) {
    return FirebaseFirestore.instance.collection("facilities").doc(facility.name);
  }

  Future<ReservationStatus> reservationExist(DateTime t, Facility f) async {
    log.info('reservationExist called');
    final reserveRef = FirebaseFirestore.instance.collection("reservations");
    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(f.name);

    final formattedT = DateTime(t.year, t.month, t.day);

    ReservationStatus result = ReservationStatus.notFound;

    final docRef = db.collection('reservations').doc('5RE42FSz6FdRer0Rkd07').withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        );
    final docSnap = await docRef.get();
    log.info('ReservationExist docRef : $docRef    docSnap : $docSnap');
    final reservation = docSnap.data(); // Convert to City object
    if (reservation != null) {
      log.info('reservationExist data() $reservation}');
    } else {
      log.info("reservationExist  No such document.");
    }

    // await docRef.get().then(
    //       (res) => log.info("Successfully completed"),
    //       onError: (e) => log.info("Error completing: $e"),
    //     );

    // reserveRef
    //     // .where("reserveOn", isEqualTo: formattedT)
    //     // .where("facility", isEqualTo: facilityRef)
    //     // .withConverter(
    //     //   fromFirestore: Reservation.fromFirestore,
    //     //   toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
    //     // )
    //     .get()
    //     .then(
    //   (querySnapshot) {
    //     log.info("reservatonExist   Successfully completed ${querySnapshot.docs.length} ${querySnapshot.docs}");
    //     // there should be only one record for this query

    //     // result = querySnapshot.docs[0]["status"];
    //     // log.info('レコード有無照会2    ${querySnapshot.docs[0]["status"]} --- $result');

    //     for (var docSnapshot in querySnapshot.docs) {
    //       // var d = docSnapshot.data() as Map<String, dynamic>;
    //       // log.info('reservatonExist() keys : ${d.keys}');

    //       // log.info("レコード有無照会1  in for loop  Successfully completed ${querySnapshot.docs.length} ${querySnapshot.docs}");
    //       // // final data = docSnapshot.data()! as Map<String, dynamic>;
    //       log.info("reservatonExist --- ${docSnapshot.data()}");

    //       // log.info(data.keys);

    //       // log.info(' 1 ====>             ${docSnapshot.data()}');
    //       // log.info(' 1 ====>             ${docSnapshot.data()}');
    //       // log.info(' 1 ====>  ${docSnapshot} === ${docSnapshot.runtimeType}');
    //       // // log.info(' 2 ====>             ${docSnapshot.data().runtimeType}');
    //       // log.info(' 1 ====> reserveOn   ${docSnapshot["reserveOn"].runtimeType}');
    //       // log.info(' 1 ====> reserveMade ${docSnapshot["reserveMade"].runtimeType}');
    //       // log.info(' 1 ====> facility    ${docSnapshot["facility"].runtimeType}');
    //       // log.info(' 1 ====> uid         ${docSnapshot["uid"].runtimeType}');
    //       // log.info(' 1 ====> tel         ${docSnapshot["tel"] ? docSnapshot["tel"].runtimeType : 'No Tel'}');
    //       // // log.info(' 1 ====> email       ${docSnapshot["email"].runtmeType}');
    //       // // log.info(' 1 ====> status      ${docSnapshot["status"].runtmeType}');
    //       // // log.info(' 1 ====> reservers   ${docSnapshot["reservers"].runtimeType}');
    //     }
    //   },
    //   onError: (e) => log.info("reservationExist Error completing: $e"),
    // );
    log.info('reservation Exist return');
    return result;
  }

  Future<void> getDocument() async {
    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(Facility.kitchen.name);
    db
        .collection("reservations")
        // .withConverter(
        //   fromFirestore: Reservation.fromFirestore,
        //   toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
        // )
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
    // required List<String> reservers,
  }) async {
    log.info('--> addReservation1 $reserveOn $reserveOn $facility ${facility.name} $status $uid');
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
