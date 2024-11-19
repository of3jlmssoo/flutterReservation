import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/reservation.dart';

import 'consts.dart';
import 'utils.dart';

final log = Logger('make_data');

// List<List<int>> makeData() {
//   final List<int> originalData = makeFirstData(numRecords);

//   final futureData = <List<int>>[
//     // numUsers分deep copyする
//     [...originalData],
//     [...originalData],
//     [...originalData]
//   ];

//   return futureData;
// }

// List<List<int>> makeTentatives(List<List<int>> lst) {
//   final len = lst[0].length;
//   final numTentatives = len / 10;
//   for (int i = 0; i < numTentatives; i++) {
//     var pos1 = math.Random().nextInt(len); // position of lst[0][pos1]
//     final userA = math.Random().nextInt(numUsers);
//     var userB = math.Random().nextInt(numUsers);
//     log.info('makeTentatives(1) i $i  pos1 $pos1 userA $userA userB $userB');
//     while (userA == userB) {
//       userB = math.Random().nextInt(numUsers);
//     }
//     while (lst[userA][pos1] == numFacilities) {
//       pos1 = math.Random().nextInt(len);
//     }

//     log.info('makeTentatives(2) i $i  pos1 $pos1 userA $userA userB $userB');
//     lst[userB][pos1] = lst[userA][pos1];
//   }
//   return lst;
// }

// List<int> makeFirstData(int x) {
//   // var result = List<int>.empty();
//   final result = List.filled(x, 0);
//   for (int i = 0; i < x; i++) {
//     result[i] = math.Random().nextInt(numFacilities + 1);
//   }
//   return result;
// }

// List<List<int>> updateData(List<List<int>> lst) {
//   for (int i = 0; i < lst[0].length; i++) {
//     log.info('updateData loop $i');
//     while (lst[0][i] != 3 && (lst[0][i] == lst[1][i] || lst[0][i] == lst[2][i] || lst[1][i] == lst[2][i])) {
//       log.info('updateData while $i ${lst[0][i]} ${lst[1][i]} ${lst[2][i]}');
//       if (lst[0][i] == lst[1][i]) {
//         lst[1][i] = updateNumber(lst[0][i], numFacilities);
//       }
//       if (lst[0][i] == lst[2][i]) {
//         lst[2][i] = updateNumber(lst[0][i], numFacilities);
//       }
//       if (lst[1][i] == lst[2][i]) {
//         lst[2][i] = updateNumber(lst[1][i], numFacilities);
//       }
//     }
//   }
//   return lst;
// }

// int updateNumber(int i, int numEle) {
//   int result = i + math.Random().nextInt(2) + 1;
//   if (result >= numFacilities) {
//     result = result - 3;
//   }
//   return result;
// }

// ReservationStatus getRandomReservationStatus() {
//   var i = math.Random().nextInt(3) + 1;
//   var result = ReservationStatus.tentative;
//   switch (i) {
//     case 1:
//       result = ReservationStatus.tentative;
//     case 2:
//       result = ReservationStatus.priority;
//     case 3:
//       result = ReservationStatus.reserved;
//     default:
//       result = ReservationStatus.tentative;
//   }
//   log.info("getRandomReservationStatus result : $result");
//   return result;
// }

// // 3レコードのみ登録
// void makeReservation1(WidgetRef ref) async {
//   log.info('---> 予約情報登録1');
//   // Reservation reservation = await makeReservation(ref);
//   ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
//   rr.addReservation(
//     reserveOn: DateTime.now().add(const Duration(days: 2)),
//     reserveMade: DateTime.now(),
//     facility: Facility.kitchen,
//     status: ReservationStatus.tentative,
//     uid: ref.read(firebaseAuthProvider).currentUser!.uid,
//   );
//   rr.addReservation(
//       reserveOn: DateTime.now().add(const Duration(days: 4)),
//       reserveMade: DateTime.now(),
//       facility: Facility.mtgR1,
//       status: ReservationStatus.reserved,
//       uid: ref.read(firebaseAuthProvider).currentUser!.uid);
//   rr.addReservation(
//       reserveOn: DateTime.now().add(const Duration(days: 6)),
//       reserveMade: DateTime.now(),
//       facility: Facility.mtgR1,
//       status: ReservationStatus.tentative,
//       uid: ref.read(firebaseAuthProvider).currentUser!.uid);
//   log.info('---> 予約情報登録2');
// }

// /*
// 従来のテストデータ作成の課題：同一日、同一ファシリティであっても予約者が異なる場合レコードとして別のものになっていた
// 修正内容：同一日、同一ファシリティの予約の場合、同じレコードでreserversに追加するようにする。

// */
// void makeReservations(WidgetRef ref) async {
//   Logger.root.level = Level.OFF;
//   log.info('makeReservations ---> 予約情報登録2-1');

//   var futureData = makeData();
//   updateData(futureData);
//   makeTentatives(futureData);
//   for (var v in futureData) {
//     log.info('makeReservations() futureData $v');
//   }

//   final users = ["dummy1@dummy.com", "dummy2@dummy.com", "dummy3@dummy.com"];
//   final passwords = ["dummy1dummy1", "dummy2dummy2", "dummy3dummy3"];
//   if (FirebaseAuth.instance.currentUser != null) {
//     log.info('makeReservations signOut ');
//     await FirebaseAuth.instance.signOut();
//   }

//   for (int i = 0; i < numUsers; i++) {
//     await FirebaseAuth.instance.signOut();

//     try {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: users[i], password: passwords[i]);
//       log.info('makeReservations credential $credential');
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         log.info('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         log.info('Wrong password provided for that user.');
//       }
//     }

//     // Logger.root.level = Level.OFF;
//     logmessage(true, log, 'makeReservations --> log in as ${FirebaseAuth.instance.currentUser!.displayName} --> ${users[i]} --- ${passwords[i]}}');
//     // log.info('makeReservations ---------------------------> futureData[i].length ${futureData[i].length}');

//     final batch = FirebaseFirestore.instance.batch();

//     logmessage(true, log, 'makeReservations batch called');
//     for (int l = 0; l < futureData[i].length; l++) {
//       logmessage(true, log, 'makeReservations second loop');
//       // Logger.root.level = Level.OFF;
//       String uid = FirebaseAuth.instance.currentUser!.uid;
//       // log.info('makeReservations second loop --- user is $uid');
//       // makeReservation1(ref);

//       final cDD = DateTime.now();
//       final cD = DateTime(cDD.year, cDD.month, cDD.day);
//       Facility fac = Facility.kitchen;

//       switch (futureData[i][l]) {
//         case 0:
//           fac = Facility.kitchen;
//         case 1:
//           fac = Facility.mtgR1;
//         case 2:
//           fac = Facility.mtgR2;
//         default:
//           break;
//       }
//       // log.info('makeReservations fac set');
//       final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(fac.name);

//       // log.info('makeReservations getRandomReservationStatus will be called');
//       // ReservationStatus rs = getRandomReservationStatus();
//       // log.info("makeReservations addReservation called rs : $rs ${rs.runtimeType}");

//       var newReservationRef = FirebaseFirestore.instance
//           .collection('reservations')
//           // .withConverter(
//           //   fromFirestore: Reservation.fromFirestore,
//           //   toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
//           // )
//           .doc();

//       log.info("makeReservations addReservation will be called 2");

//       batch.set(
//         newReservationRef,
//         {
//           "reserveOn": cD.add(Duration(days: l + 1)),
//           "reserveMade": cDD,
//           "uid": uid,
//           "reservers": [uid],
//           "facility": facilityRef,
//           "status": ReservationStatus.none,
//         },
//       );

//       log.info("makeReservations addReservation will be called 3");
//     }
//     log.info("makeReservations beofe commit()");
//     batch.commit().then(
//           (res) => log.info("Successfully completed"),
//           onError: (e) => log.info("Error completing: $e"),
//         );

//     await FirebaseAuth.instance.signOut();

//     log.info('makeReservations 予約情報登録2-2');
//     Logger.root.level = Level.OFF;
//   }
// }

// /*
// new makeReservtions

// WORKDAYS.values().length
// */

// テストユーザー３名分のテストデータを作成、登録.
void makeReservations3(WidgetRef ref) async {
  bool b = false;

  ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
  List<int> r = List.filled(numRecords, 0);
  List<List<int>> rrecords = [
    [...r],
    [...r],
    [...r],
  ];
  void printAll() {
    logmessage(b, log, rrecords[0].toString());
    logmessage(b, log, rrecords[1].toString());
    logmessage(b, log, rrecords[2].toString());
  }

  /// 乱数をセットする
  for (int i = 0; i < numUsers; i++) {
    for (int j = 0; j < numRecords; j++) {
      rrecords[i][j] = math.Random().nextInt(numFacilities);
    }
  }

  printAll();

  // ３人のテストユーザーの予約対象が全て異なるケースをカウントし、全レコード数の20%以下かどうかboolとして返す.
  //
  // 3人とも予約し、かつ、予約対象が全て異なるケースは全レコードの20%以下とする。
  // 80%以上のデータは、
  // -予約なし
  // -あるファシリティに2人以上が予約
  // となる。
  bool checkthreshold() {
    int allFacilitiesReserved = 0;
    logmessage(b, log, "allFacilitiesReserved is $allFacilitiesReserved");
    for (int i = 0; i < numRecords; i++) {
      if ((rrecords[0][i] != rrecords[1][i]) && (rrecords[0][i] != rrecords[2][i]) && (rrecords[1][i] != rrecords[2][i])) {
        allFacilitiesReserved++;
      }
    }

    return allFacilitiesReserved <= (numRecords * 0.2);
  }

  /// 3人共異なるファシリティを予約している場合、同一ファシリティへの予約に変更する.
  while (!checkthreshold()) {
    for (int i = 0; i < numRecords; i++) {
      if ((rrecords[0][i] != rrecords[1][i]) && (rrecords[0][i] != rrecords[2][i]) && (rrecords[1][i] != rrecords[2][i])) {
        /// 同一ファシリティの予約とする.
        rrecords[0][i] = rrecords[1][i];
      }
    }
  }
  printAll();

  /// firestoreへデータ送付
  final users = ["dummy1@dummy.com", "dummy2@dummy.com", "dummy3@dummy.com"];
  final passwords = ["dummy1dummy1", "dummy2dummy2", "dummy3dummy3"];
  if (FirebaseAuth.instance.currentUser != null) {
    logmessage(b, log, 'makeReservations signOut ');
    await FirebaseAuth.instance.signOut();
  }

  for (int i = 0; i < numUsers; i++) {
    await FirebaseAuth.instance.signOut();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: users[i], password: passwords[i]);
      logmessage(b, log, 'makeReservations credential $credential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logmessage(b, log, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logmessage(b, log, 'Wrong password provided for that user.');
      }
    }

    logmessage(b, log, 'makeReservations --> log in as ${FirebaseAuth.instance.currentUser!.displayName} --> ${users[i]} --- ${passwords[i]}}');

    final batch = FirebaseFirestore.instance.batch();

    /// 既にレコードがある場合、reserversにuidを追加する
    ///
    ///
    // DONE: sort data from firestore
    // DONE: 確定データを作成する。ある割合
    // TODO:use getfacility()
    logmessage(b, log, 'makeReservations batch called --- $rrecords');
    for (int l = 0; l < rrecords[i].length; l++) {
      logmessage(b, log, 'makeReservations second loop');
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final currentDateTime = DateTime.now();
      final currentDate = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day);
      Facility fac = Facility.kitchen;

      switch (rrecords[i][l]) {
        case 0:
          fac = Facility.kitchen;
        case 1:
          fac = Facility.mtgR1;
        case 2:
          fac = Facility.mtgR2;
        default:
          break;
      }
      logmessage(b, log, 'makeReservations date fac ${currentDate.add(Duration(days: l + 1))} $fac');
      final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(fac.name);

      // DONE: 日付とファシリティの組み合わせのレコードが存在するか？
      var result = await rr.queryRecordsWithDateAndFacility(currentDate.add(Duration(days: l + 1)), fac);
      logmessage(b, log, "result is $result from ${currentDate.add(Duration(days: l + 1))} --- {$fac}");

      /// 既にレコードが存在する場合reserversにuidを追加する
      if (result.isNotEmpty) {
        if (result.length > 1) {
          logmessage(true, log, "makeReservations result.length > 1. ${result.length}");
        }

        String recordID = List.from(result[0].keys)[0];

        Reservation reservationRecord = result[0][recordID]!;
        List<String> reservers = [];
        for (var v in reservationRecord.reservers!) {
          reservers.add(v);
        }
        reservers.add(FirebaseAuth.instance.currentUser!.uid);
        logmessage(true, log,
            "makeReservations record exists --- recordID:$recordID --- reserveOn:${reservationRecord.reserveOn} --- uid:${reservationRecord.uid} --- ${reservationRecord.reservers}");

        logmessage(true, log, "makeReservations lst2.uid ${reservationRecord.uid} lst3 $reservers");
        if (!rr.addUID2Record(recordID, reservers)) {
          logmessage(true, log, "makeReservations addUID2Record failed");
        }
      } else {
        /// 予約日とファシリティの組合せでレコードが無い場合は新規予約する
        logmessage(b, log, "makeReservations addReservation will be called 2");
        var newReservationRef = FirebaseFirestore.instance.collection('reservations').doc();
        batch.set(
          newReservationRef,
          {
            "reserveOn": currentDate.add(Duration(days: l + 1)),
            "reserveMade": currentDateTime,
            "uid": uid,
            "reservers": [uid],
            "facility": facilityRef,
            // "status": ReservationStatus.priority.name,
            "status": setStatus(),
          },
        );

        logmessage(b, log, "makeReservations addReservation will be called 3");
      }
    }
    logmessage(b, log, "makeReservations beofe commit()");
    await batch.commit().then(
          (res) => logmessage(true, log, "makeReservations Successfully completed"),
          onError: (e) => logmessage(true, log, "MakeReservations Error completing: $e"),
        );

    await FirebaseAuth.instance.signOut();

    logmessage(b, log, 'makeReservations 予約情報登録3-2');
    Logger.root.level = Level.OFF;
  }
}

String setStatus() {
  // 10%か20％の確率でステータスをreservedにする。それ以外はpriority

  logmessage(true, log, "setStatus called");
  double threshdold = math.Random().nextBool() ? 0.1 : 0.2;

  return math.Random().nextDouble() < threshdold ? ReservationStatus.reserved.name : ReservationStatus.priority.name;

  // return ReservationStatus.priority.name;
}

// Future<void> checkReservationExist(dynamic context) async {
//   ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
//   Reservation? r = await rr.queryReservationDateFacility(DateTime(2024, 9, 24), Facility.kitchen);
//   if (r == null) {
//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('対象レコードがありませんでした'),
//       ));
//     }
//   } else {
//     Logger.root.level = Level.OFF;
//     showReservationInstanceVariables(true, log, r);
//     Logger.root.level = Level.OFF;
//   }
// }
