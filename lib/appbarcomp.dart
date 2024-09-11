import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/firebase_auth_repository.dart';
import 'package:reservations2/make_data.dart';
import 'package:reservations2/reservation.dart';

import 'consts.dart';

final log = Logger('BaseAppBar');

class BaseAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Color backgroundColor = commonBackgroundColor;
  final String title;
  final AppBar appBar;
  final List<Widget> widgets;

  /// you can add more fields that meet your needs

  const BaseAppBar({super.key, required this.title, required this.appBar, required this.widgets});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonAppBarWidget(title: title, backgroundColor: backgroundColor);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class CommonAppBarWidget extends ConsumerWidget {
  const CommonAppBarWidget({
    super.key,
    required this.title,
    required this.backgroundColor,
  });

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: brightFontColor),
      ),
      backgroundColor: backgroundColor,
      actions: <Widget>[
        MenuAnchor(
          builder: (BuildContext context, MenuController controller, Widget? child) {
            return IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: const Icon(
                Icons.density_medium,
                // Icons.access_alarm_outlined,
                color: brightFontColor,
              ),
              tooltip: 'Show menu',
            );
          },
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                log.info('BaseAppBar logoug pressed');
                ref.read(firebaseAuthProvider).signOut();
                // ref.read(firebaseAuthProvider).sign;
              },
              child: const Text('ログアウト'),
            ),
            MenuItemButton(
              onPressed: () {
                log.info('BaseAppBar firestore pressed');
                log.info(ref.read(authRepositoryProvider).currentUser);
                context.push('/firestorework');
              },
              child: const Text('firestore!'),
            ),
            MenuItemButton(
              onPressed: () {
                log.info('BaseAppBar user info pressed ${ref.read(authRepositoryProvider).currentUser!.uid}');
                if (ref.read(authRepositoryProvider).currentUser != null) {
                  var uid = ref.read(authRepositoryProvider).currentUser!.uid;
                  // context.push('/userinformation', extra: uid);
                  context.push('/userinformation/$uid');
                }
              },
              child: const Text('ユーザー情報'),
            ),
          ],
        )
      ],
    );
  }
}

class Firestorework extends ConsumerWidget {
  const Firestorework({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(title: 'firestore work', appBar: AppBar(), widgets: const <Widget>[Icon(Icons.more_vert)]),
      body: Column(
        children: [
          const Text('abc'),
          OutlinedButton(
            onPressed: () {
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
            },
            child: const Text('施設登録'),
          ),
          OutlinedButton(
            onPressed: () async {
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
            },
            child: const Text('予約情報登録'),
          ),
          OutlinedButton(
              onPressed: () {
                ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
                log.info('reservationExist-------> ${rr.reservationExist(DateTime(2024, 9, 17), Facility.mtgR1)}');
                // if (ref.read(authRepositoryProvider).currentUser != null) {
                //   ref.read(authRepositoryProvider).signOut();
                // }
                // ref
                //     .read(firebaseAuthProvider)
                //     .signInWithEmailAndPassword(email: "dummy3@dummy.com", password: "dummy3dummy3");
                // final reserveRef = FirebaseFirestore.instance.collection("reservations");
                // final facilityRef = FirebaseFirestore.instance.collection("facilities").doc(Facility.mtgR1.name);
                // log.info('--------------------------------------------------> facilityRef ${facilityRef.toString()}');
                // reserveRef
                //     .where("reserveOn", isEqualTo: DateTime(2024, 9, 17))
                //     .where("facility", isEqualTo: facilityRef)
                //     .get()
                //     .then(
                //   (querySnapshot) {
                //     log.info("レコード有無照会    Successfully completed ${querySnapshot.docs.length} ${querySnapshot.docs}");
                //     for (var docSnapshot in querySnapshot.docs) {
                //       log.info('${docSnapshot.id} ====> ${docSnapshot.data()}');
                //     }
                //   },
                //   onError: (e) => log.info("Error completing: $e"),
                // );
              },
              child: const Text('レコード有無照会')),
          OutlinedButton(
              onPressed: () async {
                log.info('---> 予約情報登録2-1');

                var futureData = makeData();
                updateData(futureData);
                makeTentatives(futureData);
                for (var v in futureData) {
                  log.info(v);
                }

                final users = ["dummy1@dummy.com", "dummy2@dummy.com", "dummy3@dummy.com"];
                final passwords = ["dummy1dummy1", "dummy2dummy2", "dummy3dummy3"];
                if (ref.read(authRepositoryProvider).currentUser != null) {
                  ref.read(authRepositoryProvider).signOut();
                }

                for (int i = 0; i < numUsers; i++) {
                  ref.read(firebaseAuthProvider).signInWithEmailAndPassword(email: users[i], password: passwords[i]);
                  log.info('--> log in as ${ref.read(authRepositoryProvider).currentUser!.displayName}');
                }
                log.info('---> 予約情報登録2-2');
              },
              child: const Text('予約情報登録2')),
          OutlinedButton(
              onPressed: () async {
                log.info('---> 予約情報照会1');
                await getReservationWithID("FDSn1I3TPS7POOzNsdri");
                log.info('---> 予約情報照会2');
              },
              child: const Text('予約データ照会')),
          OutlinedButton(
              onPressed: () async {
                log.info('---> 予約情報照会2-1');
                ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
                rr.getDocument();
                log.info('---> 予約情報照会2-2');
              },
              child: const Text('予約データ照会2')),
          OutlinedButton(
            onPressed: () async {
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
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: user["email"]!, password: user["password"]!);
                  credential.user!.updateDisplayName(user["name"]);
                } catch (e) {
                  log.warning(e);
                }
              }
            },
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
            onPressed: () {
              context.pop();
            },
            child: const Text('戻る'),
          ),
        ],
      ),
    );
  }

  Future<void> getReservationWithID(String id) async {
    final ref = FirebaseFirestore.instance.collection("reservations").doc(id).withConverter(
          fromFirestore: Reservation.fromFirestore,
          toFirestore: (Reservation reservation, _) => reservation.toFirestore(),
        );
    final docSnap = await ref.get();
    final reservation = docSnap.data(); // Convert to City object
    if (reservation != null) {
      log.info('--> reserveOn   ${reservation.reserveOn}');
      log.info('--> reserveMade ${reservation.reserveMade}');
      log.info('--> facility    ${reservation.facility}');
      log.info('--> uid         ${reservation.uid}');
      log.info('--> tel         ${reservation.tel}');
      log.info('--> email       ${reservation.email}');
      log.info('--> status      ${reservation.status.displayName}');
    } else {
      log.info("No such document.");
    }
  }

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
