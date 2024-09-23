import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/utils.dart';

import 'appbarcomp.dart';
import 'commonclass.dart';
import 'consts.dart';
import 'firebase_auth_repository.dart';
import 'reservation.dart';

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
            'ユーザー a ${ref.read(authRepositoryProvider).currentUser?.displayName == null ? ref.read(authRepositoryProvider).currentUser?.email : "dummy"}',
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
                context.go('/reservationstatus');
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
                context.go('/usagestatus');
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
        appBar: BaseAppBar(title: '日付選択画面', appBar: AppBar(), widgets: const <Widget>[Icon(Icons.more_vert)]),
        body: ShowDatePickerWidget(facility: facility),
      ),
    );
  }
}

class ShowDatePickerWidget extends StatelessWidget {
  const ShowDatePickerWidget({
    super.key,
    required this.facility,
  });

  final String facility;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              Logger.root.level = Level.OFF;
              log.info('ShowDatePickerWidget FacilitySelectionScreen ');
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

              if (selectedDate == null) {
                log.info("ShowDatePickerWidget selectedDate == null");
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('翌日以降を選んでください'),
                  ));
                }
                return;
              }

              var currentdate = DateTime.now();
              var justdate = DateTime(currentdate.year, currentdate.month, currentdate.day);

              log.info('ShowDatePickerWidget $selectedDate ${selectedDate.runtimeType} now $justdate');
              log.info('ShowDatePickerWidget ${selectedDate.difference(justdate).inDays}');

              if (selectedDate.difference(justdate).inDays > 0) {
                var reservationinput = ReservationInputsBase(reservationDate: selectedDate, facility: facility);
                if (context.mounted) GoRouter.of(context).push('/reservationinput', extra: reservationinput);
              }

              // if (selectedDate!.difference(justdate).inDays > 0) {
              //   var reservationinput = ReservationInputsBase(reservationDate: selectedDate, facility: facility);
              //   if (context.mounted) GoRouter.of(context).push('/reservationinput', extra: reservationinput);
              // } else {
              //   if (!context.mounted) return;
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       content: Text('翌日以降を選んでください'),
              //     ),
              //   );
              // }

              // context.push('/datetimepickerapp');
              Logger.root.level = Level.OFF;
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
  const ReservationInputScreen({super.key, required this.rbase});

  final ReservationInputsBase rbase;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: '必要情報入力',
          appBar: AppBar(),
          widgets: const <Widget>[Icon(Icons.more_vert)],
        ),
        // body: Container(
        //     child: Text(
        //         'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName != null ? ref.read(authRepositoryProvider).currentUser?.displayName : ref.read(authRepositoryProvider).currentUser!.email}')),
        body: Column(
          children: [
            Text(rbase.reservationDate.toString()),
            Text(rbase.facility),
            FilledButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('戻る'),
            ),
            FilledButton(
              onPressed: () {
                var rext = ReservationInputsExt(
                  name: '名無し',
                  emaill: 'dummyX@dummy.com',
                  tel: '01-234-5678',
                  reservationDate: rbase.reservationDate,
                  facility: rbase.facility,
                );
                context.push('/reservationconfirmation', extra: rext);
                // if (context.mounted) GoRouter.of(context).push('/reservationinput', extra: reservationinput);
              },
              child: const Text('進む'),
            ),
          ],
        ));
  }
}

class ReservationConfirmationScreen extends StatelessWidget {
  const ReservationConfirmationScreen({super.key, required this.rext});

  final ReservationInputsExt rext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '予約確認',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      // body: Container(
      //     child: Text(
      //         'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName != null ? ref.read(authRepositoryProvider).currentUser?.displayName : ref.read(authRepositoryProvider).currentUser!.email}')),
      body: Column(
        children: [
          const Text('以下で予約します。'),
          Text(rext.name),
          Text(rext.tel),
          Text(rext.emaill),
          Text(rext.facility),
          Text(rext.reservationDate.toString()),
          FilledButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('戻る'),
          ),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('予約しました！'),
                  // action: SnackBarAction(
                  //   label: 'Action',
                  //   onPressed: () {
                  //     // Code to execute.
                  //   },
                  // ),
                ),
              );
              context.go('/main');
            },
            child: const Text('確定'),
          ),
        ],
      ),
    );
  }
}

class ReservationStatusScreen extends StatelessWidget {
  const ReservationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '予約確認',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      body: Column(
        children: [
          const Text('ReservationStatus'),
          OutlinedButton(
              onPressed: () {
                context.push('/reservationdetails', extra: "1234567");
              },
              child: const Text('詳細')),
        ],
      ),
    );
  }
}

class ReservationDetailsScreen extends StatelessWidget {
  const ReservationDetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '予約詳細',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      body: Column(
        children: [
          Text('Reservation details for $id'),
          OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('更新しました！'),
                    // action: SnackBarAction(
                    //   label: 'Action',
                    //   onPressed: () {
                    //     // Code to execute.
                    //   },
                    // ),
                  ),
                );
                context.go('/reservationstatus');
              },
              child: const Text('詳細')),
        ],
      ),
    );
  }
}

class UsageStatusScreen extends StatelessWidget {
  const UsageStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '利用実績確認',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      body: Column(
        children: [
          const Text('Usage Status'),
          OutlinedButton(
              onPressed: () {
                context.push('/usagedetails', extra: '1234567');
              },
              child: const Text('詳細')),
          OutlinedButton(
              onPressed: () {
                context.go('/main');
              },
              child: const Text('戻る')),
        ],
      ),
    );
  }
}

class UsageDetailsScreen extends StatelessWidget {
  const UsageDetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '利用実績詳細',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      body: Column(
        children: [
          Text('Usage details for $id'),
          OutlinedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('戻る')),
        ],
      ),
    );
  }
}

class UserInformationScreen extends StatelessWidget {
  const UserInformationScreen({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'ユーザー情報',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      body: Column(
        children: [
          // Text('User information for ${user.displayName}'),
          Text('User information for $uid'),
          OutlinedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('戻る'),
          ),
          OutlinedButton(
            onPressed: () {
              context.push('/userinformationupdate', extra: uid);
            },
            child: const Text('更新画面へ'),
          ),
        ],
      ),
    );
  }
}

class UserInformationUpdateScreen extends StatelessWidget {
  const UserInformationUpdateScreen({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'ユーザー情報更新',
        appBar: AppBar(),
        widgets: const <Widget>[Icon(Icons.more_vert)],
      ),
      body: Column(
        children: [
          // Text('User information update for ${user.displayName}'),
          Text('User information update for $uid'),
          OutlinedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('戻る'),
          ),
          OutlinedButton(
              onPressed: () {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('更新しました'),
                  ),
                );
                // context.push('/userinformation', extra: user);
                context.pop();
              },
              child: const Text('更新')),
        ],
      ),
    );
  }
}

class ListReservations extends ConsumerWidget {
  const ListReservations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(title: 'firestore work', appBar: AppBar(), widgets: const <Widget>[Icon(Icons.more_vert)]),
      body: Column(
        children: [
          const Text("ListReservations"),
          FloatingActionButton(onPressed: () async {
            ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
            List<Reservation?> r = await rr.getAllDocuments();
            logmessage(true, log, "ListReservations result length ${r.length}");
          })
        ],
      ),
    );
  }
}
