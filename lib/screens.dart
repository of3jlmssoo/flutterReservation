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
  DateFormat.yMd().format(DateTime.now().add(Duration(days: 2))),
  DateFormat.yMd().format(DateTime.now().add(Duration(days: 3))),
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
        title: Text(
          '施設予約システム',
          style: TextStyle(color: brightFontColor),
        ),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      // body: Container(
      //     child: Text(
      //         'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName != null ? ref.read(authRepositoryProvider).currentUser?.displayName : ref.read(authRepositoryProvider).currentUser!.email}')),
      body: ListView(
        children: [
          colDivider,
          Text(
            'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName != null ? ref.read(authRepositoryProvider).currentUser?.displayName : ref.read(authRepositoryProvider).currentUser!.email}',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          colDivider,
          Card(
            child: ListTile(
              onTap: () {
                log.info('MainScreen ListTile Tapped(新規予約)');
                context.go('/newreservation');
              },
              leading: FlutterLogo(size: 56.0),
              title: Text('予約しよう！'),
              subtitle: Text('新規予約'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                log.info('MainScreen ListTile Tapped(予約状況)');
              },
              leading: FlutterLogo(size: 56.0),
              title: Text('予約どうなった?'),
              subtitle: Text('予約状況確認'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                log.info('MainScreen ListTile Tapped(利用実績)');
              },
              leading: FlutterLogo(size: 56.0),
              title: Text('使ってよかった！'),
              subtitle: Text('利用実績'),
              trailing: Icon(Icons.more_vert),
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
        title: Text(
          'this is the login screen',
          style: TextStyle(color: brightFontColor),
        ),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      body: Center(
          child: Column(
        children: [
          Text('please login ${ref.read(firebaseAuthProvider).currentUser}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                log.info('Log in pressed');
                ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
                    email: "dummy1@dummy.com", password: "dummy1dummy1");
                // ref.read(firebaseAuthProvider).signInWEP();
                log.info(
                    'current User is ${ref.read(firebaseAuthProvider).currentUser}');
              },
              child: const Text('Log In'),
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
    return Text('this is the not found screen');
  }
}

class NewReservationScreen extends ConsumerWidget {
  const NewReservationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    // return const Text('NewReserationScreen');
    return Scaffold(
      appBar: BaseAppBar(
        title: Text(
          '新規予約：施設選択',
          style: TextStyle(color: brightFontColor),
        ),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      // body: Container(
      //     child: Text(
      //         'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName != null ? ref.read(authRepositoryProvider).currentUser?.displayName : ref.read(authRepositoryProvider).currentUser!.email}')),
      body: ListView(
        children: [
          colDivider,
          Text(
            'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName != null ? ref.read(authRepositoryProvider).currentUser?.displayName : ref.read(authRepositoryProvider).currentUser!.email}',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          colDivider,
          Card(
            child: ListTile(
              onTap: () {
                log.info('NewReservationScreen ListTile Tapped(台所)');
                context.push('/facilityselection', extra: "台所");
              },
              leading: FlutterLogo(size: 56.0),
              title: Text('みんなで美味しく！'),
              subtitle: Text('台所'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                log.info('NewReservationScreen ListTile Tapped(会議室1)');
                context.push('/facilityselection', extra: "会議室1");
              },
              leading: FlutterLogo(size: 56.0),
              title: Text('熱く語り合う'),
              subtitle: Text('会議室1'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                log.info('NewReservationScreen ListTile Tapped(会議室2)');
                context.push('/facilityselection', extra: "会議室2");
              },
              leading: FlutterLogo(size: 56.0),
              title: Text('お茶会で使って！'),
              subtitle: Text('会議室2'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }
}

class FacilitySelectionScreen extends ConsumerWidget {
  const FacilitySelectionScreen({super.key, required this.facility});

  final String facility;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("ja"),
      ],
      home: Scaffold(
        appBar: BaseAppBar(
            title: Text('施設選択画面'),
            appBar: AppBar(),
            widgets: <Widget>[Icon(Icons.more_vert)]),
        body: showDatePickerWidget(),
      ),
    );
  }
}

class showDatePickerWidget extends StatelessWidget {
  const showDatePickerWidget({
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
                lastDate: DateTime.now().add(Duration(days: 20)),
                selectableDayPredicate: (DateTime val) {
                  return !strunselectable2
                      .contains(DateFormat.yMd().format(val));
                },
              );
              // final selectedDate = await DatePickerDialog(
              //   firstDate: DateTime.now(),
              //   lastDate: DateTime.now().add(Duration(days: 20)),
              // );
              log.info('FacilitySelectionScreen $selectedDate');

              // context.push('/datetimepickerapp');
            },
            child: Text('日付')),
        ElevatedButton(
            onPressed: () async {
              context.pop();
            },
            child: Text('戻る'))
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
