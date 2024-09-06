import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import 'appbarcomp.dart';
import 'consts.dart';
import 'firebase_auth_repository.dart';

final log = Logger('Screens');

List<String> strunselectable2 = [
  DateFormat.yMd().format(DateTime.now().add(const Duration(days: 2))),
  DateFormat.yMd().format(DateTime.now().add(const Duration(days: 3))),
  // DateFormat.yMd().format(DateTime.now())
];

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    // return Text('this is the main screen');
    return Scaffold(
      appBar: BaseAppBar(
        title: '施設予約システム',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      body: ListView(
        children: [
          colDivider,
          Text(
            'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName ?? ref.read(authRepositoryProvider).currentUser!.email}',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          colDivider,
          Card(
            child: ListTile(
              onTap: () {
                log.info('MainScreen ListTile Tapped(新規予約)');
                context.go('/facilityselection');
              },
              leading: const FlutterLogo(size: 56.0),
              title: const Text('予約しよう！'),
              subtitle: const Text('新規予約'),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                log.info('MainScreen ListTile Tapped(予約状況)');
              },
              leading: const FlutterLogo(size: 56.0),
              title: const Text('予約どうなった?'),
              subtitle: const Text('予約状況確認'),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                log.info('MainScreen ListTile Tapped(利用実績)');
              },
              leading: const FlutterLogo(size: 56.0),
              title: const Text('使ってよかった！'),
              subtitle: const Text('利用実績'),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    // return Text('this is the login screen');
    return Scaffold(
      appBar: BaseAppBar(
        title: 'ログイン',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
            'ログインするかID登録してください',
            style: TextStyle(fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                log.info('Log in pressed');
                ref
                    .read(firebaseAuthProvider)
                    .signInWithEmailAndPassword(email: "dummy1@dummy.com", password: "dummy1dummy1");
                log.info('current User is ${ref.read(firebaseAuthProvider).currentUser}');
              },
              child: const Text('ログイン'),
            ),
          ),
        ],
      )),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text('this is the not found screen');
  }
}

class FacilitySelectionScreen extends ConsumerWidget {
  const FacilitySelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    // return const Text('NewReserationScreen');
    return Scaffold(
      appBar: BaseAppBar(
        title: '新規予約：施設選択',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      // body: Container(
      //     child: Text(
      //         'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName != null ? ref.read(authRepositoryProvider).currentUser?.displayName : ref.read(authRepositoryProvider).currentUser!.email}')),
      body: ListView(
        children: [
          colDivider,
          Text(
            'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName ?? ref.read(authRepositoryProvider).currentUser!.email}',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          colDivider,
          Card(
            child: ListTile(
              onTap: () {
                log.info('NewReservationScreen ListTile Tapped(台所)');
                context.push('/dateselection', extra: "台所");
              },
              leading: const FlutterLogo(size: 56.0),
              title: const Text('みんなで美味しく！'),
              subtitle: const Text('台所'),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                log.info('NewReservationScreen ListTile Tapped(会議室1)');
                context.push('/dateselection', extra: "会議室1");
              },
              leading: const FlutterLogo(size: 56.0),
              title: const Text('熱く語り合う'),
              subtitle: const Text('会議室1'),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                log.info('NewReservationScreen ListTile Tapped(会議室2)');
                context.push('/dateselection', extra: "会議室2");
              },
              leading: const FlutterLogo(size: 56.0),
              title: const Text('お茶会で使って！'),
              subtitle: const Text('会議室2'),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }
}

class DateSelectionScreen extends ConsumerWidget {
  const DateSelectionScreen({super.key, required this.facility});

  final String facility;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ja"),
      ],
      home: Scaffold(
        appBar: BaseAppBar(title: '施設選択画面', appBar: AppBar(), widgets: const <Widget>[Icon(Icons.more_vert)]),
        body: const ShowDatePickerWidget(),
      ),
    );
  }
}

class ShowDatePickerWidget extends StatelessWidget {
  const ShowDatePickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              log.info('FacilitySelectionScreen ');
              final selectedDate = await showDatePicker(
                locale: const Locale("ja"),
                context: context,
                cancelText: 'キャンセル',
                confirmText: '確定',
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 20)),
                selectableDayPredicate: (DateTime val) {
                  return !strunselectable2.contains(DateFormat.yMd().format(val));
                },
              );
              // final selectedDate = await DatePickerDialog(
              //   firstDate: DateTime.now(),
              //   lastDate: DateTime.now().add(Duration(days: 20)),
              // );
              log.info('FacilitySelectionScreen $selectedDate');

              // context.push('/datetimepickerapp');
            },
            child: const Text('日付')),
        ElevatedButton(
            onPressed: () async {
              context.pop();
            },
            child: const Text('戻る'))
      ],
    );
  }
}

class ReservationInputScreen extends StatelessWidget {
  const ReservationInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text('ReservationInputScreen');
  }
}

class ReservationConfirmationScreen extends StatelessWidget {
  const ReservationConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text('ReservationConfirmationScreen');
  }
}

class ReservationStatusScreen extends StatelessWidget {
  const ReservationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text('ReservationStatusScreen');
  }
}

class ReservationDetailsScreen extends StatelessWidget {
  const ReservationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text('ReservationDetailsScreen');
  }
}

class UserInformationScreen extends StatelessWidget {
  const UserInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text('UserInformationScreen');
  }
}

class UserInformationUpdateScreen extends StatelessWidget {
  const UserInformationUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Text('UserInformationUpdateScreen');
  }
}
