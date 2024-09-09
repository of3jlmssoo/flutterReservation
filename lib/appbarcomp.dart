import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/firebase_auth_repository.dart';
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
              // final reservation = Reservation(
              //     reserveOn: DateTime.now(),
              //     reserveMade: DateTime.now().add(Duration(days: 1)),
              //     uid: ref.read(firebaseAuthProvider).currentUser!.uid);
              // final rRepository = ReservationRepository(reservation: reservation, db: FirebaseFirestore.instance);
              // rRepository.addReservation(reservation: reservation);

              final reservation = Reservation(
                reserveOn: DateTime.now(),
                reserveMade: DateTime.now().add(const Duration(days: 1)),
                facility: FirebaseFirestore.instance.collection("facilities").doc("kitchen"),
                uid: ref.read(authRepositoryProvider).currentUser!.uid,
                status: ReservationStatus.none,
                // status: ReservationStatus.none,
              );

              final docRef = FirebaseFirestore.instance
                  .collection("reservations")
                  .withConverter(
                    fromFirestore: Reservation.fromFirestore,
                    toFirestore: (Reservation reservation, options) => reservation.toFirestore(),
                  )
                  .doc();
              await docRef.set(reservation);
              log.info('---> 予約情報登録2 $reservation');
              // var db = FirebaseFirestore.instance;
              // final docRef = db.collection("facilities").doc("kitchen");

              // log.info("-----> $docRef ---> ${docRef.runtimeType}");
              // log.info("-----> ${ref.read(authRepositoryProvider).currentUser}"); //.runtimeType}");
              // final reservation = <String, dynamic>{
              //   "name": "Los Angeles",
              //   "facility": docRef,
              //   // "user": ref.read(authRepositoryProvider).currentUser
              // };

              // var setData = db
              //     .collection("reservations")
              //     .doc()
              //     .set(reservation)
              //     .onError((e, _) => log.info("Error writing document: $e"));
              // log.info("-----> $setData");
            },
            child: const Text('予約情報登録'),
          ),
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

  Future<UserCredential> userCreate(Map<String, String> user) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user["email"]!,
      password: user["password"]!,
    );
    return credential;
  }
}
