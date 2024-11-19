import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

// ReservationStatus getReservationStatus(String rstatus) {
//   switch (rstatus) {
//     case "none":
//       return ReservationStatus.none;
//     case "tentative":
//       return ReservationStatus.tentative;
//     case "priority":
//       return ReservationStatus.priority;
//     case "reserved":
//       return ReservationStatus.reserved;
//     // case "notfound":
//     default:
//       return ReservationStatus.notFound;
//   }
// }

// String getReservationExpressionOnFirestore(ReservationStatus rstatus) {
//   switch (rstatus) {
//     case ReservationStatus.none:
//       return "none";
//     case ReservationStatus.notFound:
//       return "notFound";
//     case ReservationStatus.priority:
//       return "priority";
//     case ReservationStatus.reserved:
//       return "reserved";
//     case ReservationStatus.tentative:
//       return "tentative";
//   }
// }

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
//     logmessage(b, log, 'ReservationStatusExtension --> fromString called! status : $status');
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
//     logmessage(b, log, '--> statusToString called!');
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

// extension FacilityExtension on Facility {
//   static DocumentReference<Object?> fromString(dynamic xxx) {
//     logmessage(true, log, '---> FacilityExtension on Facility xxx.runtimeType ${xxx.runtimeType}');
//     return xxx as DocumentReference;
//   }
// }

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
//     logmessage(b, log, 'ReservationStatusConverter json : $json');
//     return ReservationStatusExtension.statusfromString(json);
//   }

//   @override
//   Map<String, dynamic> toJson(ReservationStatus reservationStatu) {
//     return ReservationStatusExtension.statusToString(reservationStatu);
//   }
// }

// class DateTimeConverter implements JsonConverter<DateTime, Timestamp> {
//   const DateTimeConverter();

//   @override
//   DateTime fromJson(Timestamp json) {
//     logmessage(b, log, '-----------------------------------------------');
//     logmessage(b, log, '-----------------------------------------------');
//     logmessage(b, log, '-----------------------------------------------');
//     logmessage(b, log, '-----------------------------------------------');
//     logmessage(b, log, '-----------------------------------------------');
//     logmessage(b, log, '-----------------------------------------------');
//     logmessage(b, log, '-----------------------------------------------');
//     return json.toDate();
//   }

//   @override
//   Timestamp toJson(DateTime dateTime) {
//     return Timestamp.fromDate(dateTime);
//   }
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
    String? status,
    required List<String>? reservers,
    String? firestoreID,
  }) = _Reservation;

  String get getrOn => DateFormat('yyyy年M月d日').format(reserveOn);
  String get getrMade => DateFormat('yyyy年M月d日').format(reserveMade);
  Future<String> get getfName async => await facilityName(facility as DocumentReference<Map<String, dynamic>>);
  String get getUid => uid.substring(0, 3);
  String get getTel => tel ?? "登録なし";
  String get getEmail => email ?? "登録なし";
  String get getStatus => getReservationDisplayName(status!);

  factory Reservation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    bool b = true;
    logmessage(b, log, 'fromFirestore1 data $data ${data?.keys}');
    logmessage(b, log, 'fromFirestore2 data ${data as Map<String, dynamic>}');
    logmessage(b, log, 'fromFirestore3 reservOn ${data["reserveOn"]} ----- ${data["reserveOn"].toDate()}');
    logmessage(b, log, 'fromFirestore4 reservers ${data["reservers"]} ----- ${data["reservers"].runtimeType}}');
    logmessage(b, log, 'fromFirestore5 status ${data["status"]} ----- ${data["status"].runtimeType}}');
    logmessage(b, log, 'fromFirestore7 status : ${data["status"]}');
    logmessage(b, log, 'fromFirestore8 facility : ${data["facility"]} --- ${data["facility"].runtimeType}}');

    final r = Reservation(
      reserveOn: data["reserveOn"].toDate(),
      reserveMade: data["reserveMade"].toDate(),
      uid: data["uid"],
      tel: data["tel"],
      email: data["email"],
      reservers: List<String>.from(data["reservers"]),
      status: data["status"],
      facility: data["facility"],
    );
    logmessage(b, log, 'fromFirestore9 r : $r');
    // Logger.root.level = Level.OFF;
    return r;
  }

  Map<String, dynamic> toFirestore() {
    bool b = true;
    logmessage(b, log, 'fromFireStore reserveOn --- $reserveOn');
    return {
      "reserveOn": Timestamp.fromDate(reserveOn),
      "reserveMade": Timestamp.fromDate(reserveMade),
      if (facility != null) "facility": facility,
      "uid": uid,
      if (tel != null) "tel": tel,
      if (email != null) "email": email,
      "status": status,
      if (reservers != null) "reservers": reservers,
    };
  }

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);
}

class ReservationRepository {
  ReservationRepository({required this.db});
  final FirebaseFirestore db;
  final bool b = false;

  /// ファシリティレファレンスを返す
  DocumentReference getfacilityRef(Enum facility) {
    return FirebaseFirestore.instance.collection("facilities").doc(facility.name);
  }

  /// 日付とファシリティの組合せでレコードがあるか。あればそれを返す
  ///
  /// - レコード数が1以外はUnimlementedError()
  /// - レコード数が1の場合、firestoreのレコードIDをセット
  Future<Reservation?> queryReservationDateFacility(DateTime t, Facility f) async {
    logmessage(b, log, 'queryReservationDateFacility called $t $f ${f.runtimeType}');

    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(f.name);
    Reservation? result;

    final docRef = await db
        .collection("reservations")
        .orderBy("reserveOn")
        .where("reserveOn", isEqualTo: t)
        .where("facility", isEqualTo: facilityRef)
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .get();

    logmessage(b, log, "queryReservationDateFacility docRef.size : ${docRef.size}");
    if (docRef.size == 1) {
      logmessage(b, log, "queryReservationDateFacility docRef.docs : ${docRef.docs}");
      logmessage(b, log, "queryReservationDateFacility docRef.docs.data() : ${docRef.docs[0].data()}");
      result = docRef.docs[0].data();
      result = result.copyWith(firestoreID: docRef.docs[0].id);
    } else {
      logmessage(b, log, "queryReservationDateFacility docRef.size <> 1");
      UnimplementedError();
    }
    logmessage(b, log, "queryReservationDateFacility docRef.runtimeType ${docRef.runtimeType}");
    logmessage(b, log, 'queryReservationDateFacility Exist return');

    return result;
  }

  /// firestoreのレコードIDでデータをfirestoreから取得して返す
  Future<Reservation?> queryReservationID(String id) async {
    logmessage(b, log, 'queryReservationID called $id');

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
    result = result!.copyWith(firestoreID: docRef.id);

    logmessage(b, log, "queryReservationID docRef.runtimeType ${docRef.runtimeType}");
    logmessage(b, log, 'queryReservationID Exist return');

    return result;
  }

  // DONE: 修正前はreservedのみを取得=>reservedとpriorityを取得するようにする
  // DONE: 修正後は、reservedの予約日とreserversに自分がいるのをaddする

  /// 指定されたファシリティで予約できない日をリストで返す
  ///
  /// - 既にreservedとなっている
  /// - 自分が予約している
  Future<List<DateTime>> getFacilityUnAvailableDates(Facility facility) async {
    List<DateTime> result = [];
    List<Map<String, Reservation>> result2 = [];

    const bool l = false;

    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(facility.getFname(facility));
    await db
        .collection("reservations")
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .where(Filter("facility", isEqualTo: facilityRef))
        .get()
        .then((querySnapshot) {
      logmessage(l, log, "getFacilityAvailableDates --- Successfully completed ${facility.getFname(facility)} ");
      for (var docSnapshot in querySnapshot.docs) {
        var d = docSnapshot.data();
        logmessage(l, log, 'getFacilityAvailableDates ${docSnapshot.id} => $d ==> ${d.status}');

        result2.add(<String, Reservation>{docSnapshot.id: d});
        if (d.status == "reserved" || d.reservers!.contains(FirebaseAuth.instance.currentUser!.uid)) {
          result.add(d.reserveOn);
        }
      }
    }, onError: (e) => logmessage(true, log, "getFacilityAvailableDates error $e"));

    logmessage(l, log, "getFacilityAvailableDates result:$result");
    logmessage(l, log, "getFacilityAvailableDates result2:$result2");
    logmessage(l, log, "getFacilityAvailableDates result2.length:${result2.length} $facility");

    return result;
  }

  /// reserversに自分が含まれているレコードをログする
  ///
  /// firestorework用メソッド
  void queryArrayContains() {
    bool b = true;

    final rRef = db.collection("reservations");
    final myReservations = rRef.where("reservers", arrayContains: FirebaseAuth.instance.currentUser!.uid);

    logmessage(b, log, "queryArrayContains myReservations $myReservations");
    myReservations.get().then((onValue) {
      for (var docSnapshot in onValue.docs) {
        var d = docSnapshot.data();
        logmessage(b, log, "queryArrayContains data $d");
      }
    });
  }

  /// 指定されたレコードのreserversを指定されたリストで更新する
  ///
  /// リストはチェックせずにそのままで更新する
  bool addUID2Record(String recordID, List<String> lst) {
    logmessage(b, log, "addUID2Record $recordID $lst");
    bool result = false;
    final docRef = db.collection("reservations").doc(recordID);
    docRef.update({"reservers": lst}).then((value) {
      logmessage(b, log, "addUID2Record DocumentSnapshot successfully updated!");
      result = true;
    }, onError: (e) {
      logmessage(b, log, "addUID2Record Error updating document $recordID $lst $e");
      result = false;
    });

    return result;
  }

  /// 指定された日付とファシリティのレコードをレコードIDと紐付けて返す.
  ///
  /// 新規利用禁止。現状のReservatonにはfirestoreIDがある。
  /// 現状このメソッドを使っているのはfirestoreworkとmake_dataのみ
  Future<List<Map<String, Reservation>>> queryRecordsWithDateAndFacility(DateTime targetDate, Facility facility) async {
    // const bool b = false;

    final facilityRef = getfacilityRef(facility);

    List<Map<String, Reservation>> result = [];
    final ref = FirebaseFirestore.instance
        .collection("reservations")
        .where("facility", isEqualTo: facilityRef)
        .where("reserveOn", isEqualTo: targetDate)
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        );

    await ref.get().then(
      (querySnapshot) {
        logmessage(b, log, "queryRecordsWithDateAndFacility Successfully completed");
        if (querySnapshot.docs.isEmpty) {
          logmessage(b, log, "queryRecordsWithDateAndFacility querySnapshot.docs.isEmpty");
        }
        for (var docSnapshot in querySnapshot.docs) {
          logmessage(b, log, 'queryRecordsWithDateAndFacility ${docSnapshot.id} => ${docSnapshot.data().runtimeType} ${docSnapshot.data()}');
          var id = docSnapshot.id;
          var r = docSnapshot.data();
          result.add(<String, Reservation>{id: r});
        }
      },
      onError: (e) => logmessage(b, log, "queryRecordsWithDateAndFacility Error completing: $e"),
    );

    logmessage(b, log, "queryRecordsWithDateAndFacility result is $result");
    return result;
  }

  /// 全レコードを照会し、予約情報をリストで返す
  ///
  /// firestoreworkからのみ呼び出されている
  Future<List<Reservation>> getAllDocuments() async {
    bool b = true;
    logmessage(b, log, 'getAllDocuments called');

    List<Reservation> result = [];

    // final docRef = await db
    await db
        .collection("reservations")
        .orderBy("reserveOn")
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .get()
        .then((querySnapshot) {
      logmessage(b, log, "getAllDocuments --- Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        logmessage(b, log, '${docSnapshot.id} => ${docSnapshot.data()}');
        result.add(docSnapshot.data());
      }
    }, onError: (e) => logmessage(true, log, "getAllDocuments error $e"));

    logmessage(b, log, 'getAllDocuments Exist return $result');

    return result;
  }

  /// status=priorityのレコードをログする
  ///
  /// firestorework専用
  Future<void> getDocument() async {
    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(Facility.kitchen.name);
    logmessage(b, log, "getDocument called facilityRef : $facilityRef");
    final docPriorityRef = db.collection("reservations").where("status", isEqualTo: "priority");
    logmessage(b, log, "getDocument called docPriorityRef : $docPriorityRef");

    docPriorityRef.get().then(
      (querySnapshot) {
        Logger.root.level = Level.OFF;
        logmessage(b, log, "getDocument Successfully completed querySnapshot.docs.length ${querySnapshot.docs.length}");
        for (var docSnapshot in querySnapshot.docs) {
          logmessage(b, log, 'getDocument id: ${docSnapshot.id}, status: ${docSnapshot.data()["status"]}');
        }
        logmessage(b, log, "getDocument Successfully completed -> ${querySnapshot.docs.length}");
      },
      onError: (e) => logmessage(b, log, "getDocument Error: $e"),
    );
    logmessage(b, log, "getDocument end");
  }

  /// 指定された情報でfirestoeレコードを追加(set)
  Future<void> addReservation({
    required DateTime reserveOn,
    required DateTime reserveMade,
    required Facility facility,
    required ReservationStatus status,
    required String uid,
    // required List<String> reservers,
  }) async {
    logmessage(b, log, 'addReservation-1 $reserveOn $reserveOn $facility ${facility.name} $status $uid');
    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(facility.name);
    final formattedReserveOn = DateTime(reserveOn.year, reserveOn.month, reserveOn.day);

    final reservation =
        Reservation(reserveOn: formattedReserveOn, reserveMade: reserveMade, facility: facilityRef, uid: uid, status: status.name, reservers: [uid]);

    db
        .collection(collectionReservation)
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
        )
        .doc()
        .set(reservation);
    logmessage(b, log, 'addReservation-2');
  }

  /// 指定された日付とファシリティのレコードのfirestore IDを返す
  ///
  /// レコード数が１以外の場合はnullを返す
  Future<String?> getIDByDateFacility(DateTime t, Facility f) async {
    String? result;

    logmessage(b, log, 'getIDByDateFacility called $t $f ${f.runtimeType}');

    final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(f.name);

    final docRef = await db
        .collection("reservations")
        .where("reserveOn", isEqualTo: t)
        .where("facility", isEqualTo: facilityRef)
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .get();

    logmessage(b, log, "getIDByDateFacility docRef.size : ${docRef.size}");
    if (docRef.size == 1) {
      logmessage(b, log, "getIDByDateFacility --- docRef.docs[0].id: ${docRef.docs[0].id}");
      result = docRef.docs[0].id;
    } else {
      result = null;
    }
    return result;
  }

  //  TODO: add before or after
  /// queryGreaterThanあるいはqueryLessThanと共に指定されたuidの予約状をリスト形式で返す
  Future<List<Reservation>> queryMyReservations(String uid, bool future) async {
    const bool b = false;

    List<Reservation> result = [];

    if (future == true) {
      await queryGreaterThan(uid, b, result);
    } else {
      await queryLessThan(uid, b, result);
    }

    logmessage(b, log, "queryMyReservations result.length ${result.length}");
    return result;
  }

  /// queryMyReservationsから呼ばれる。過去の予約情報を返す.
  Future<void> queryLessThan(String uid, bool b, List<Reservation> result) async {
    await db
        .collection("reservations")
        .orderBy("reserveOn")
        .where("reservers", arrayContains: uid)
        .where("reserveOn", isLessThan: DateTime.now())
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .get()
        .then(
      (querySnapshot) {
        logmessage(b, log, "queryMyReservations Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          logmessage(b, log, 'queryMyReservations ${docSnapshot.id} => ${docSnapshot.data()}');
          result.add(docSnapshot.data());
        }
      },
      onError: (e) => logmessage(b, log, "queryMyReservations Error completing: $e"),
    );
  }

  /// queryMyReservationsから呼ばれる。将来の予約情報を返す.
  Future<void> queryGreaterThan(String uid, bool b, List<Reservation> result) async {
    await db
        .collection("reservations")
        .orderBy("reserveOn")
        .where("reservers", arrayContains: uid)
        .where("reserveOn", isGreaterThan: DateTime.now())
        .withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        )
        .get()
        .then(
      (querySnapshot) {
        logmessage(b, log, "queryMyReservations Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          logmessage(b, log, 'queryMyReservations ${docSnapshot.id} => ${docSnapshot.data()}');
          result.add(docSnapshot.data());
        }
      },
      onError: (e) => logmessage(b, log, "queryMyReservations Error completing: $e"),
    );
  }

  Future<bool> cancelReservation(DateTime dt, Facility f) async {
    // Future<bool> cancelReservation() async {
    bool result = true;
    const bool b = true;
    // DateTime dt = DateTime(2024, 10, 25);
    // Facility f = Facility.mtgR2;

    Reservation? r = await queryReservationDateFacility(dt, f);
    if (r != null) {
      logmessage(b, log, "cancelReservations r.reservers   : ${r.reservers}");
      logmessage(b, log, "cancelReservations r.firestoreID : ${r.firestoreID}");
      logmessage(b, log, "cancelReservations f(Facility) : ${f.runtimeType} $f");

      if (r.reservers!.length == 1) {
        // 予約者一人だけのケース
        db.collection("reservations").doc(r.firestoreID).delete().then(
          (doc) => logmessage(b, log, "cancelReservation Document deleted"),
          onError: (e) {
            logmessage(true, log, "cancelReservation Error updating document $e");
            result = false;
          },
        );
      } else if (r.reservers!.length > 1) {
        // 予約者複数のケース

        // TODO: reservationのuidメンテナンス(リストのindex0のIDがuidを兼ねる)
        String? docID = await getIDByDateFacility(dt, f);
        final sfDocRef = db.collection("reservations").doc(docID);
        await db.runTransaction((transaction) async {
          final snapshot = await transaction.get(sfDocRef);
          // Note: this could be done without a transaction
          //       by updating the population using FieldValue.increment()
          final newReservers = snapshot.get("reservers");
          logmessage(b, log, "cancelReservation newPopulation ${newReservers.runtimeType} $newReservers");
          newReservers.remove(FirebaseAuth.instance.currentUser!.uid);
          transaction.update(sfDocRef, {"reservers": newReservers});
        }).then(
          (value) => logmessage(b, log, "cancelReservation DocumentSnapshot successfully updated!"),
          onError: (e) {
            logmessage(true, log, "cancelReservation Error updating document $e");
            result = false;
          },
        );
      }
    }

    return result;
  }

  Future<bool> addReserver(String docID, String uid) async {
    bool result = true;

    final docRef = db.collection("reservations").doc(docID);
    docRef.update({
      "reservers": FieldValue.arrayUnion([uid]),
    }).onError((e, _) {
      result = false;
      logmessage(true, log, "addReserver Error : $e");
    });

    return result;
  }
}

class ReservationService {}

@freezed
class ReservationsAndText with _$ReservationsAndText {
  const ReservationsAndText._();
  const factory ReservationsAndText({
    required String title,
    required List<Reservation> reservations,
  }) = _ReservationsAndText;

  // String get getrOn => title;
}
