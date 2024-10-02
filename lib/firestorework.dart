import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/consts.dart';

import 'appbarcomp.dart';
import 'firebase_auth_repository.dart';
import 'make_data.dart';
import 'reservation.dart';
import 'utils.dart';

final log = Logger("firestorework");

class Firestorework extends ConsumerWidget {
  const Firestorework({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(title: 'firestore work', appBar: AppBar(), widgets: const <Widget>[Icon(Icons.more_vert)]),
      body: Column(
        children: [
          const Text('firestore work menu'),
          OutlinedButton(
            onPressed: () {
              final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(Facility.kitchen.name);
              var r = Reservation(
                reserveOn: DateTime.now(),
                reserveMade: DateTime.now(),
                facility: facilityRef,
                reservers: [ref.read(authRepositoryProvider).currentUser!.uid],
                uid: ref.read(authRepositoryProvider).currentUser!.uid,
                status: ReservationStatus.priority.name,
              );
              showReservationInstanceVariables(true, log, r);
            },
            child: const Text('Reservatin runtimeType'),
          ),
          OutlinedButton(
            onPressed: () {
              registerFacilities();
            },
            child: const Text('施設登録'),
          ),
          OutlinedButton(
            onPressed: () async {
              makeReservation1(ref);
            },
            child: const Text('予約情報登録'),
          ),
          OutlinedButton(
              onPressed: () {
                checkReservationExist(context);
              },
              child: const Text('レコード有無照会')),
          OutlinedButton(
              onPressed: () async {
                makeReservations(ref);
              },
              child: const Text('予約情報登録2')),
          OutlinedButton(
              onPressed: () async {
                logmessage(false, log, '予約データ照会(id特定) 1');
                var result = await getReservationWithID(context, "3TllYctRVw43gPzhu4bT");
                logmessage(false, log, '予約データ照会(id特定) 2 $result');
              },
              child: const Text('予約データ照会(id特定)')),
          OutlinedButton(
              onPressed: () async {
                Logger.root.level = Level.OFF;
                log.info('firestorework 予約情報照会2-1');
                ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
                await rr.getDocument();
                log.info('---> 予約情報照会2-2');
                Logger.root.level = Level.OFF;
              },
              child: const Text('予約データ照会2')),
          OutlinedButton(
            onPressed: () async {},
            child: const Text('ユーザー登録'),
          ),
          OutlinedButton(
            onPressed: () {
              log.info('BaseAppBar user info pressed');
              log.info(ref.read(authRepositoryProvider).currentUser);
            },
            child: const Text('ユーザー情報(ログ)'),
          ),
          OutlinedButton(
            onPressed: () async {
              ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
              List<Reservation> reservationList = await rr.getAllDocuments();
              if (reservationList.isEmpty) {
                logmessage(true, log, "appbarcomp listreservations 予約情報が無いか取得できませんでした");
                if (context.mounted) GoRouter.of(context).go('/firestorework');
              } else {
                // logmessage(true, log, "appbarcomp listreservations ${reservationList[0].getStatus}");
              }
              if (context.mounted) GoRouter.of(context).push('/listreservations', extra: reservationList);
            },
            child: const Text('予約一覧表示'),
          ),
          OutlinedButton(
            onPressed: () async {
              ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
              List<DateTime> reservableKitichen = await rr.getFacilityAvailableDates(Facility.kitchen);
              List<DateTime> reservableMtgR1 = await rr.getFacilityAvailableDates(Facility.mtgR1);
              List<DateTime> reservableMtgR2 = await rr.getFacilityAvailableDates(Facility.mtgR2);

              logmessage(true, log,
                  "Q unAvailable Date --- kitchen ${reservableKitichen.length} days unavailable $reservableKitichen");
              logmessage(true, log,
                  "Q unAvailable Date --- mtgR1   ${reservableMtgR1.length} days unavailable $reservableMtgR1");
              logmessage(true, log,
                  "Q unAvailable Date --- mtgR2   ${reservableMtgR2.length} days unavailable $reservableMtgR2");

              // if (reservationList.isEmpty) {
              //   logmessage(true, log, "appbarcomp listreservations 予約情報が無いか取得できませんでした");
              //   if (context.mounted) GoRouter.of(context).go('/firestorework');
              // } else {
              //   // logmessage(true, log, "appbarcomp listreservations ${reservationList[0].getStatus}");
              // }
              // if (context.mounted) GoRouter.of(context).push('/listreservations', extra: reservationList);
            },
            child: const Text('Query where(f=x).where(date=x)'),
          ),
          OutlinedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('戻る'),
          ),
        ],
      ),
    );
  }

  Future<void> registerUsers() async {
    log.info('BaseAppBar create users pressed');

    List<Map<String, String>> users = [
      {"name": "dummy1", "email": "dummy1@dummy.com", "password": "dummy1dummy1"},
      {"name": "dummy2", "email": "dummy2@dummy.com", "password": "dummy2dummy2"},
      {"name": "dummy3", "email": "dummy3@dummy.com", "password": "dummy3dummy3"}
    ];

    for (var user in users) {
      try {
        log.info('in try! ${user["email"]} ${user["password"]}');
        var credential = await userCreate(user);
        log.info('credential : $credential');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          log.warning('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          log.warning('The account already exists for that email.');
        }
      } catch (e) {
        log.warning(e);
      }

      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: user["email"]!, password: user["password"]!);
        credential.user!.updateDisplayName(user["name"]);
      } catch (e) {
        log.warning(e);
      }
    }
  }

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

        log.info('makeReservations getRandomReservationStatus will be cOFFed');
        ReservationStatus rs = getRandomReservationStatus();

        log.info("makeReservations addReservation cOFFed rs : $rs ${rs.runtimeType}");

        var newReservationRef = FirebaseFirestore.instance
            .collection('reservations')
            // .withConverter(
            //   fromFirestore: Reservation.fromFirestore,
            //   toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
            // )
            .doc();

        log.info("makeReservations addReservation will be cOFFed 2");
        // Reservation reservation = Reservation(
        //     reserveOn: cD.add(Duration(days: l + 1)),
        //     reserveMade: cDD,
        //     uid: uid,
        //     reservers: [uid],
        //     facility: facilityRef,
        //     status: rs);
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

  Future<Reservation?> getReservationWithID(dynamic context, String id) async {
    ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
    Reservation? r = await rr.queryReservationID(id);
    if (r == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('対象レコードがありませんでした'),
        ));
      }
    } else {
      Logger.root.level = Level.ALL;
      showReservationInstanceVariables(true, log, r);
      Logger.root.level = Level.OFF;
    }
    Logger.root.level = Level.ALL;
    log.info("getReservationWithID will return $r");
    Logger.root.level = Level.OFF;
    return r;
  }

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

  void registerFacilities() {
    var db = FirebaseFirestore.instance;

    for (var ele in Facility.values) {
      try {
        var doc = {"name": ele.displayName, "capacity": ele.capacity, "description": ele.description};
        db.collection("facilities").doc(ele.name).set(doc);
        // .onError((e, _) => log.info("Error writing document: $e"));
      } catch (e) {
        log.info("Error writing document: $e");
      }
    }
  }

  // Future<void> getReservationWithID(String id) async {
  //   Logger.root.level = Level.ALL;

  //   final ref = FirebaseFirestore.instance.collection("reservations").doc(id).withConverter(
  //         fromFirestore: Reservation.fromFirestore,
  //         toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
  //       );
  //   final docSnap = await ref.get();
  //   final reservation = docSnap.data(); // Convert to City object
  //   Logger.root.level = Level.ALL;
  //   if (reservation != null) {
  //     showReservationInstanceVariables(true, log, reservation);
  //   } else {
  //     log.info("getReservationWithID No such document.");
  //   }
  //   Logger.root.level = Level.OFF;
  // }

  // Future<Reservation> makeReservation(WidgetRef ref) async {
  //   final reservation = Reservation(
  //     reserveOn: DateTime.now(),
  //     reserveMade: DateTime.now().add(const Duration(days: 1)),
  //     facility: FirebaseFirestore.instance.collection("facilities").doc("kitchen"),
  //     uid: ref.read(authRepositoryProvider).currentUser!.uid,
  //     status: ReservationStatus.none,
  //   );

  //   final docRef = FirebaseFirestore.instance
  //       .collection("reservations")
  //       .withConverter(
  //         fromFirestore: Reservation.fromFirestore,
  //         toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
  //       )
  //       .doc();
  //   await docRef.set(reservation);
  //   return reservation;
  // }

  Future<UserCredential> userCreate(Map<String, String> user) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user["email"]!,
      password: user["password"]!,
    );
    return credential;
  }
}