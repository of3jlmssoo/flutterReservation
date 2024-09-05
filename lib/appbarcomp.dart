import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/firebase_auth_repository.dart';

import 'consts.dart';

final log = Logger('BaseAppBar');

class BaseAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Color backgroundColor = commonBackgroundColor;
  final String title;
  final AppBar appBar;
  final List<Widget> widgets;

  /// you can add more fields that meet your needs

  const BaseAppBar(
      {required this.title, required this.appBar, required this.widgets});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return commonAppBarWidget(title: title, backgroundColor: backgroundColor);
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

class commonAppBarWidget extends ConsumerWidget {
  const commonAppBarWidget({
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
        style: TextStyle(color: brightFontColor),
      ),
      backgroundColor: backgroundColor,
      actions: <Widget>[
        MenuAnchor(
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
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
              child: const Text('logout'),
            ),
            MenuItemButton(
              onPressed: () {
                log.info('BaseAppBar user info pressed');
                log.info(ref.read(authRepositoryProvider).currentUser);
              },
              child: const Text('log.info user info'),
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
              onPressed: () async {
                log.info('BaseAppBar create users pressed');

                List<Map<String, String>> users = [
                  {
                    "name": "dummy1",
                    "email": "dummy1@dummy.com",
                    "password": "dummy1dummy1"
                  },
                  {
                    "name": "dummy2",
                    "email": "dummy2@dummy.com",
                    "password": "dummy2dummy2"
                  }
                ];

                users.forEach(
                  (user) async {
                    log.info(
                        '---> ${user["name"]}  ${user["email"]}  ${user["password"]}');
                    try {
                      log.info('in try! ${user["email"]} ${user["password"]}');
                      userCreate(user).then((credential) async {
                        log.info('user creation ${credential.user}');
                        await credential.user!.updateDisplayName(user["name"]);
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        log.warning('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        log.warning(
                            'The account already exists for that email.');
                      }
                    } catch (e) {
                      log.warning(e);
                    }
                  },
                );
              },
              child: const Text('create users'),
            )
          ],
        )
      ],
    );
  }

  Future<UserCredential> userCreate(Map<String, String> user) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user["email"]!,
      password: user["password"]!,
    );
    return credential;
  }
}

class firestorework extends ConsumerWidget {
  const firestorework({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(
          title: 'firestore work',
          appBar: AppBar(),
          widgets: <Widget>[Icon(Icons.more_vert)]),
      body: Column(
        children: [
          Text('abc'),
          OutlinedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('戻る'))
        ],
      ),
    );
  }
}
