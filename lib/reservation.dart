import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/utils.dart';

import 'consts.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

// part 'reservation.g.dart';
final log = Logger('Reservation');

const String collectionReservation = "reservations";

enum ReservationStatus {
  none(displayName: "空き"),
  tentative(displayName: "仮り"),
  priority(displayName: "優先"),
  reserved(displayName: "確定"),
  notFound(displayName: "不明");

  const ReservationStatus({
    required this.displayName,
  });

  final String displayName;
}

ReservationStatus getReservationStatus(String rstatus) {
  switch (rstatus) {
    case "none":
      return ReservationStatus.none;
    case "tentative":
      return ReservationStatus.tentative;
    case "priority":
      return ReservationStatus.priority;
    case "reserved":
      return ReservationStatus.reserved;
    // case "notfound":
    default:
      return ReservationStatus.notFound;
  }
}

String getReservationExpressionOnFirestore(ReservationStatus rstatus) {
  switch (rstatus) {
    case ReservationStatus.none:
      return "none";
    case ReservationStatus.notFound:
      return "notFound";
    case ReservationStatus.priority:
      return "priority";
    case ReservationStatus.reserved:
      return "reserved";
    case ReservationStatus.tentative:
      return "tentative";
  }
}

String getReservationDisplayName(String rstatus) {
  switch (rstatus) {
    case "none":
      return ReservationStatus.none.displayName;
    case "tentative":
      return ReservationStatus.tentative.displayName;
    case "priority":
      return ReservationStatus.priority.displayName;
    case "reserved":
      return ReservationStatus.reserved.displayName;
    // case "notfound":
    default:
      return ReservationStatus.notFound.displayName;
  }
}

// extension ReservationStatusExtension on ReservationStatus {
//   static ReservationStatus statusfromString(String status) {
//     log.info('ReservationStatusExtension --> fromString called! status : $status');
//     switch (status) {
//       case 'none':
//         return ReservationStatus.none;
//       case 'tentative':
//         return ReservationStatus.tentative;
//       case 'reserved':
//         return ReservationStatus.reserved;
//       default:
//         return ReservationStatus.notFound;
//     }
//   }

//   // static Map<String, dynamic> statusToString(ReservationStatus status) {
//   static Map<String, dynamic> statusToString(ReservationStatus status) {
//     log.info('--> statusToString called!');
//     switch (status) {
//       case ReservationStatus.none:
//         return {"status": ReservationStatus.none.name};
//       case ReservationStatus.tentative:
//         return {'status': ReservationStatus.tentative.name};
//       case ReservationStatus.reserved:
//         return {'status': ReservationStatus.reserved.name};
//       default:
//         return {'status': ReservationStatus.notFound.name};
//     }
//   }
// }

extension FacilityExtension on Facility {
  static DocumentReference<Object?> fromString(dynamic xxx) {
    logmessage(true, log, '---> FacilityExtension on Facility xxx.runtimeType ${xxx.runtimeType}');
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

// class ReservationStatusConverter implements JsonConverter<ReservationStatus, Map<String, dynamic>> {
//   const ReservationStatusConverter();

//   @override
//   ReservationStatus fromJson(dynamic json) {
//     log.info('ReservationStatusConverter json : $json');
//     return ReservationStatusExtension.statusfromString(json);
//   }

//   @override
//   Map<String, dynamic> toJson(ReservationStatus reservationStatu) {
//     return ReservationStatusExtension.statusToString(reservationStatu);
//   }
// }

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

// @freezed
// class Reservation4Display with _$Reservation4Display {
//   const Reservation4Display._();
//   const factory Reservation4Display({
//     required String reserveOn,
//     required String reserveMade,
//     required String facility,
//     required String uid,
//     String? tel,
//     String? email,
//     required String status,
//     required List<String>? reservers,
//   }) = _Reservation4Display;
// }

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
    // @Default(ReservationStatus.none) ReservationStatus status,
    String? status,
    required List<String>? reservers,

    // @JsonKey(name: "reserveOn") @DateTimeConverter() required DateTime reserveOn,
    // @JsonKey(name: "reserveMade") @DateTimeConverter() required DateTime reserveMade,
    // @JsonKey(name: "facility") DocumentReference? facility,
    // @JsonKey(name: "uid") required String uid,
    // @JsonKey(name: "tel") String? tel,
    // @JsonKey(name: "email") String? email,
    // @JsonKey(name: "status") @ReservationStatusConverter() required ReservationStatus status,
  }) = _Reservation;

  String get getrOn => DateFormat('yyyy年M月d日').format(reserveOn);
  String get getrMade => DateFormat('yyyy年M月d日').format(reserveMade);
  Future<String> get getfName async => await facilityName(facility as DocumentReference<Map<String, dynamic>>);
  String get getUid => uid.substring(0, 3);
  String get getTel => tel ?? "登録なし";
  String get getEmail => email ?? "登録なし";
  String get getStatus => getReservationDisplayName(status!);
  //       // var tel = r.tel ?? "登録なし";
//       // var email = r.email ?? "登録なし";

  factory Reservation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    Logger.root.level = Level.OFF;
    final data = snapshot.data();
    log.info('fromFirestore1 data $data ${data?.keys}');
    var d = data as Map<String, dynamic>;
    log.info('fromFirestore2 $d');
    log.info('fromFirestore3 ${data["reserveOn"]} XXX ${data["reserveOn"].toDate()}');
    log.info('fromFirestore4 ${data["reservers"]} ----- ${data["reservers"].runtimeType}}');
    log.info('fromFirestore5 ${data["status"]} ----- ${data["status"].runtimeType}}');

    // var m = data["status"].map<String, String>((key, value) => MapEntry<String, String>(key, value.toString()));
    var m = data["status"];
    // String s = 'none';
    // for (var v in m.values) {
    //   s = v;
    // }

    log.info('fromFirestore6 m : $m ');

    // ReservationStatus rs = ReservationStatus.none;
    // switch (s) {
    //   case 'none':
    //     rs = ReservationStatus.none;
    //   case 'tentative':
    //     rs = ReservationStatus.tentative;
    //   case 'reserved':
    //     rs = ReservationStatus.reserved;
    //   default:
    //     rs = ReservationStatus.notFound;
    // }
    // log.info('fromFirestore7 rs : $rs');
    log.info('fromFirestore8 facility : ${data["facility"]} --- ${data["facility"].runtimeType}}');

    final r = Reservation(
      reserveOn: data["reserveOn"].toDate(),
      reserveMade: data["reserveMade"].toDate(),
      uid: data["uid"],
      tel: data["tel"],
      email: data["email"],
      // reservers: data["reservers"].cast<String>() as List<String>,
      reservers: List<String>.from(data["reservers"]),
      status: data["status"],
      facility: data["facility"],

      // reservers: data["reservers"] ?? [],
    );
    log.info('fromFirestore9 r : $r');
    Logger.root.level = Level.OFF;
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
      "status": status,
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

  Future<Reservation?> queryReservationDateFacility(DateTime t, Facility f) async {
    Logger.root.level = Level.OFF;
    log.info('queryReservationDateFacility called $t $f ${f.runtimeType}');

    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(f.name);
    Reservation? result;

    final docRef = await db
        .collection("reservations")
        .where("reserveOn", isEqualTo: t)
        .where("facility", isEqualTo: facilityRef)
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .get();

    log.info("queryReservationDateFacility docRef.size : ${docRef.size}");
    if (docRef.size == 1) {
      log.info("queryReservationDateFacility docRef.docs : ${docRef.docs}");
      log.info("queryReservationDateFacility docRef.docs.data() : ${docRef.docs[0].data()}");
      result = docRef.docs[0].data();
    } else {
      log.info("queryReservationDateFacility some records exist!");
      UnimplementedError();
    }
    log.info("queryReservationDateFacility docRef.runtimeType ${docRef.runtimeType}");
    log.info('queryReservationDateFacility Exist return');

    Logger.root.level = Level.OFF;

    return result;
  }

  Future<Reservation?> queryReservationID(String id) async {
    Logger.root.level = Level.OFF;
    log.info('queryReservationID called $id');

    // final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(f.name);
    Reservation? result;

    final docRef = await db
        .collection("reservations")
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .doc(id)
        .get();

    result = docRef.data();
    log.info("queryReservationID docRef.runtimeType ${docRef.runtimeType}");
    log.info('queryReservationID Exist return');

    Logger.root.level = Level.OFF;

    return result;
  }

  Future<List<DateTime>> getFacilityAvailableDates(Facility facility) async {
    List<DateTime> result = [];

    const bool l = true;

    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(facility.getFname(facility));
    // final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(Facility.mtgR1.name);
    await db
        .collection("reservations")
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .where(Filter.and(Filter("facility", isEqualTo: facilityRef),
            Filter("status", isEqualTo: getReservationExpressionOnFirestore(ReservationStatus.reserved))))
        .get()
        .then((querySnapshot) {
      logmessage(l, log,
          "getFacilityAvailableDates --- Successfully completed ${facility.getFname(facility)} ${Facility.mtgR1.name}");
      for (var docSnapshot in querySnapshot.docs) {
        var d = docSnapshot.data();
        logmessage(l, log, '${docSnapshot.id} => $d');
        result.add(d.reserveOn);
      }
    }, onError: (e) => logmessage(true, log, "getFacilityAvailableDates error $e"));

    return result;
  }

  Future<List<Reservation>> getAllDocuments() async {
    Logger.root.level = Level.OFF;
    logmessage(false, log, 'getAllDocuments called');

    List<Reservation> result = [];

    // final docRef = await db
    await db
        .collection("reservations")
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .get()
        .then((querySnapshot) {
      logmessage(false, log, "getAllDocuments --- Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        logmessage(false, log, '${docSnapshot.id} => ${docSnapshot.data()}');
        result.add(docSnapshot.data());
      }
    }, onError: (e) => logmessage(true, log, "getAllDocuments error $e"));

    // result = docRef.data();
    logmessage(false, log, 'getAllDocuments Exist return $result');

    return result;

    // db.collection("cities").get().then(
    //   (querySnapshot) {
    //     print("Successfully completed");
    //     for (var docSnapshot in querySnapshot.docs) {
    //       print('${docSnapshot.id} => ${docSnapshot.data()}');
    //     }
    //   },
    //   onError: (e) => print("Error completing: $e"),
    // );
  }

  Future<void> getDocument() async {
    Logger.root.level = Level.OFF;
    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(Facility.kitchen.name);
    log.info("getDocument called facilityRef : $facilityRef");
    final kitchens = db
        .collection("reservations")
        // .withConverter(
        //   fromFirestore: Reservation.fromFirestore,
        //   toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
        // )
        .where("status", isEqualTo: "priority");
    log.info("getDocument called kitchens : $kitchens");

    kitchens.get().then(
      (querySnapshot) {
        Logger.root.level = Level.OFF;
        log.info("Successfully completed ------------------------> ${querySnapshot.docs.length}");
        for (var docSnapshot in querySnapshot.docs) {
          // log.info('${docSnapshot.id} ===============================> ${docSnapshot.data()}');
          log.info('----------------> ${docSnapshot.id} ${docSnapshot.data()["status"]}');
        }
        log.info("Successfully completed -> ${querySnapshot.docs.length}");
      },
      onError: (e) => log.info("Error completing: $e"),
    );
    log.info("getDocument end of ");
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
        status: status.name,
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
