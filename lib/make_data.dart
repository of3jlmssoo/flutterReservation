import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/reservation.dart';

import 'consts.dart';
import 'firebase_auth_repository.dart';
import 'utils.dart';

final log = Logger('make_data');

List<List<int>> makeData() {
  final List<int> originalData = makeFirstData(numRecords);

  final futureData = <List<int>>[
    // numUsers分deep copyする
    [...originalData],
    [...originalData],
    [...originalData]
  ];

  return futureData;
}

List<List<int>> makeTentatives(List<List<int>> lst) {
  final len = lst[0].length;
  final numTentatives = len / 10;
  for (int i = 0; i < numTentatives; i++) {
    var pos1 = math.Random().nextInt(len); // position of lst[0][pos1]
    final userA = math.Random().nextInt(numUsers);
    var userB = math.Random().nextInt(numUsers);
    log.info('makeTentatives(1) i $i  pos1 $pos1 userA $userA userB $userB');
    while (userA == userB) {
      userB = math.Random().nextInt(numUsers);
    }
    while (lst[userA][pos1] == numFacilities) {
      pos1 = math.Random().nextInt(len);
    }

    log.info('makeTentatives(2) i $i  pos1 $pos1 userA $userA userB $userB');
    lst[userB][pos1] = lst[userA][pos1];
  }
  return lst;
}

List<int> makeFirstData(int x) {
  // var result = List<int>.empty();
  final result = List.filled(x, 0);
  for (int i = 0; i < x; i++) {
    result[i] = math.Random().nextInt(numFacilities + 1);
  }
  return result;
}

List<List<int>> updateData(List<List<int>> lst) {
  for (int i = 0; i < lst[0].length; i++) {
    log.info('updateData loop $i');
    while (lst[0][i] != 3 && (lst[0][i] == lst[1][i] || lst[0][i] == lst[2][i] || lst[1][i] == lst[2][i])) {
      log.info('updateData while $i ${lst[0][i]} ${lst[1][i]} ${lst[2][i]}');
      if (lst[0][i] == lst[1][i]) {
        lst[1][i] = updateNumber(lst[0][i], numFacilities);
      }
      if (lst[0][i] == lst[2][i]) {
        lst[2][i] = updateNumber(lst[0][i], numFacilities);
      }
      if (lst[1][i] == lst[2][i]) {
        lst[2][i] = updateNumber(lst[1][i], numFacilities);
      }
    }
  }
  return lst;
}

int updateNumber(int i, int numEle) {
  int result = i + math.Random().nextInt(2) + 1;
  if (result >= numFacilities) {
    result = result - 3;
  }
  return result;
}

ReservationStatus getRandomReservationStatus() {
  var i = math.Random().nextInt(3) + 1;
  var result = ReservationStatus.tentative;
  switch (i) {
    case 1:
      result = ReservationStatus.tentative;
    case 2:
      result = ReservationStatus.priority;
    case 3:
      result = ReservationStatus.reserved;
    default:
      result = ReservationStatus.tentative;
  }
  log.info("getRandomReservationStatus result : $result");
  return result;
}

// 3レコードのみ登録
void makeReservation1(WidgetRef ref) async {
  log.info('---> 予約情報登録1');
  // Reservation reservation = await makeReservation(ref);
  ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
  rr.addReservation(
    reserveOn: DateTime.now().add(const Duration(days: 2)),
    reserveMade: DateTime.now(),
    facility: Facility.kitchen,
    status: ReservationStatus.tentative,
    uid: ref.read(firebaseAuthProvider).currentUser!.uid,
  );
  rr.addReservation(
      reserveOn: DateTime.now().add(const Duration(days: 4)),
      reserveMade: DateTime.now(),
      facility: Facility.mtgR1,
      status: ReservationStatus.reserved,
      uid: ref.read(firebaseAuthProvider).currentUser!.uid);
  rr.addReservation(
      reserveOn: DateTime.now().add(const Duration(days: 6)),
      reserveMade: DateTime.now(),
      facility: Facility.mtgR1,
      status: ReservationStatus.tentative,
      uid: ref.read(firebaseAuthProvider).currentUser!.uid);
  log.info('---> 予約情報登録2');
}

/*
従来のテストデータ作成の課題：同一日、同一ファシリティであっても予約者が異なる場合レコードとして別のものになっていた
修正内容：同一日、同一ファシリティの予約の場合、同じレコードでreserversに追加するようにする。



*/
void makeReservations(WidgetRef ref) async {
  Logger.root.level = Level.OFF;
  log.info('makeReservations ---> 予約情報登録2-1');

  var futureData = makeData();
  updateData(futureData);
  makeTentatives(futureData);
  for (var v in futureData) {
    log.info('makeReservations() futureData $v');
  }

  final users = ["dummy1@dummy.com", "dummy2@dummy.com", "dummy3@dummy.com"];
  final passwords = ["dummy1dummy1", "dummy2dummy2", "dummy3dummy3"];
  if (FirebaseAuth.instance.currentUser != null) {
    log.info('makeReservations signOut ');
    await FirebaseAuth.instance.signOut();
  }

  for (int i = 0; i < numUsers; i++) {
    await FirebaseAuth.instance.signOut();

    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: users[i], password: passwords[i]);
      log.info('makeReservations credential $credential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log.info('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log.info('Wrong password provided for that user.');
      }
    }

    Logger.root.level = Level.OFF;
    log.info(
        'makeReservations --> log in as ${FirebaseAuth.instance.currentUser!.displayName} --> ${users[i]} --- ${passwords[i]}}');
    log.info('makeReservations ---------------------------> futureData[i].length ${futureData[i].length}');

    final batch = FirebaseFirestore.instance.batch();

    log.info('makeReservations batch cOFFed');
    for (int l = 0; l < futureData[i].length; l++) {
      log.info('makeReservations second loop');
      // Logger.root.level = Level.OFF;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      // log.info('makeReservations second loop --- user is $uid');
      // makeReservation1(ref);

      final cDD = DateTime.now();
      final cD = DateTime(cDD.year, cDD.month, cDD.day);
      Facility fac = Facility.kitchen;

      switch (futureData[i][l]) {
        case 0:
          fac = Facility.kitchen;
        case 1:
          fac = Facility.mtgR1;
        case 2:
          fac = Facility.mtgR2;
        default:
          break;
      }
      log.info('makeReservations fac set');
      final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(fac.name);

      // log.info('makeReservations getRandomReservationStatus will be called');
      // ReservationStatus rs = getRandomReservationStatus();
      // log.info("makeReservations addReservation cOFFed rs : $rs ${rs.runtimeType}");

      var newReservationRef = FirebaseFirestore.instance
          .collection('reservations')
          // .withConverter(
          //   fromFirestore: Reservation.fromFirestore,
          //   toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
          // )
          .doc();

      log.info("makeReservations addReservation will be called 2");

      batch.set(
        newReservationRef,
        {
          "reserveOn": cD.add(Duration(days: l + 1)),
          "reserveMade": cDD,
          "uid": uid,
          "reservers": [uid],
          "facility": facilityRef,
          "status": ReservationStatus.none,
        },
      );

      log.info("makeReservations addReservation will be cOFFed 3");
    }
    log.info("makeReservations beofe commit()");
    batch.commit().then(
          (res) => log.info("Successfully completed"),
          onError: (e) => log.info("Error completing: $e"),
        );

    await FirebaseAuth.instance.signOut();

    log.info('makeReservations 予約情報登録2-2');
    Logger.root.level = Level.OFF;
  }
}

Future<void> checkReservationExist(dynamic context) async {
  ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
  Reservation? r = await rr.queryReservationDateFacility(DateTime(2024, 9, 24), Facility.kitchen);
  if (r == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('対象レコードがありませんでした'),
      ));
    }
  } else {
    Logger.root.level = Level.OFF;
    showReservationInstanceVariables(true, log, r);
    Logger.root.level = Level.OFF;
  }
}

/*
new makeReservtions





WORKDAYS.values().length
*/
void makeReservations3(WidgetRef ref) async {
  List<int> r = List.filled(numRecords, 0);
  List<List<int>> rrecords = [
    [...r],
    [...r],
    [...r],
  ];
  void printAll() {
    logmessage(true, log, rrecords[0].toString());
    logmessage(true, log, rrecords[1].toString());
    logmessage(true, log, rrecords[2].toString());
  }

  // fill the lists with random number
  for (int i = 0; i < numUsers; i++) {
    for (int j = 0; j < numRecords; j++) {
      rrecords[i][j] = math.Random().nextInt(numFacilities);
    }
  }

  printAll();

  // check the result
  // 3つのファシリティ全てが予約されているのは20％以下とする
  bool checkthreshold() {
    // 3つのファシリティ全てが予約されている日の割合を20％以下とする
    // 20%以下であればtrue
    // そうでなければfalse
    //
    // 3ユーザー限定

    int allFacilitiesReserved = 0;
    logmessage(true, log, "allFacilitiesReserved is $allFacilitiesReserved");
    for (int i = 0; i < numRecords; i++) {
      if ((rrecords[0][i] != rrecords[1][i]) &&
          (rrecords[0][i] != rrecords[2][i]) &&
          (rrecords[1][i] != rrecords[2][i])) {
        allFacilitiesReserved++;
      }
    }

    return allFacilitiesReserved <= (numRecords * 0.2);
  }

  // 閾値越えの場合、同じレコードコピーで閾値以下にする
  while (!checkthreshold()) {
    for (int i = 0; i < numRecords; i++) {
      if ((rrecords[0][i] != rrecords[1][i]) &&
          (rrecords[0][i] != rrecords[2][i]) &&
          (rrecords[1][i] != rrecords[2][i])) {
        rrecords[0][i] = rrecords[1][i];
      }
    }
  }
  printAll();

  final users = ["dummy1@dummy.com", "dummy2@dummy.com", "dummy3@dummy.com"];
  final passwords = ["dummy1dummy1", "dummy2dummy2", "dummy3dummy3"];
  if (FirebaseAuth.instance.currentUser != null) {
    logmessage(true, log, 'makeReservations signOut ');
    await FirebaseAuth.instance.signOut();
  }

  for (int i = 0; i < numUsers; i++) {
    await FirebaseAuth.instance.signOut();

    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: users[i], password: passwords[i]);
      logmessage(true, log, 'makeReservations credential $credential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logmessage(true, log, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logmessage(true, log, 'Wrong password provided for that user.');
      }
    }

    logmessage(true, log,
        'makeReservations --> log in as ${FirebaseAuth.instance.currentUser!.displayName} --> ${users[i]} --- ${passwords[i]}}');

    final batch = FirebaseFirestore.instance.batch();

    logmessage(true, log, 'makeReservations batch cOFFed');
    for (int l = 0; l < rrecords[i].length; l++) {
      log.info('makeReservations second loop');
      // Logger.root.level = Level.OFF;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      // log.info('makeReservations second loop --- user is $uid');
      // makeReservation1(ref);

      final cDD = DateTime.now();
      final cD = DateTime(cDD.year, cDD.month, cDD.day);
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
      logmessage(true, log, 'makeReservations fac set');
      final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(fac.name);

      log.info('makeReservations getRandomReservationStatus will be called');
      ReservationStatus rs = getRandomReservationStatus();

      log.info("makeReservations addReservation cOFFed rs : $rs ${rs.runtimeType}");

      var newReservationRef = FirebaseFirestore.instance.collection('reservations').doc();

      log.info("makeReservations addReservation will be cOFFed 2");
      batch.set(
        newReservationRef,
        {
          "reserveOn": cD.add(Duration(days: l + 1)),
          "reserveMade": cDD,
          "uid": uid,
          "reservers": [uid],
          "facility": facilityRef,
          "status": rs.name,
        },
      );

      log.info("makeReservations addReservation will be cOFFed 3");
    }
    log.info("makeReservations beofe commit()");
    batch.commit().then(
          (res) => log.info("Successfully completed"),
          onError: (e) => log.info("Error completing: $e"),
        );

    await FirebaseAuth.instance.signOut();

    log.info('makeReservations 予約情報登録2-2');
    Logger.root.level = Level.OFF;
  }
}
