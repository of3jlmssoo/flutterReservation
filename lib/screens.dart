import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import 'appbarcomp.dart';
import 'commonclass.dart';
import 'consts.dart';
import 'firebase_auth_repository.dart';
import 'reservation.dart';
import 'utils.dart';

final log = Logger('Screens');

List<String> strunselectable2 = [
  DateFormat.yMd().format(DateTime.now().add(const Duration(days: 2))),
  DateFormat.yMd().format(DateTime.now().add(const Duration(days: 3))),
  // DateFormat.yMd().format(DateTime.now())
];

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  final bool b = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            // DONE: display user name. need to fixed
            // 'ユーザー ${ref.read(authRepositoryProvider).currentUser?.displayName == null ? ref.read(authRepositoryProvider).currentUser?.email : "dummy"}',
            'ユーザー ${FirebaseAuth.instance.currentUser!.displayName}',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          colDivider,
          Card(
            child: ListTile(
              onTap: () {
                logmessage(b, log, 'MainScreen ListTile Tapped(新規予約)');
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
              onTap: () async {
                logmessage(b, log, 'MainScreen ListTile Tapped(予約状況)');
                await myReservations(context, true);
              },
              leading: const FlutterLogo(size: 56.0),
              title: const Text('予約どうなった?'),
              subtitle: const Text('予約状況確認'),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () async {
                logmessage(b, log, 'MainScreen ListTile Tapped(利用実績)');
                // context.go('/usagestatus');
                // DONE: delete usagestatus
                await myReservations(context, false);
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

// DONE: "no reservation" message when myReservations is empty
// DONE: merge myPastReservations and myFutureReservations
// Future<void> myPastReservations(BuildContext context) async {
//   const bool b = true;
//   ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
//   List<Reservation> myReservations = await rr.queryMyReservations(FirebaseAuth.instance.currentUser!.uid, false);
//   logmessage(b, log, "myreservations myReservations --- $myReservations");
//   ReservationsAndText rt = ReservationsAndText(title: "過去の予約一覧", reservations: myReservations);
//   // context.go('/listmyreservations');
//   // context.push('/listmyreservations', extra: myReservations);
//   if (context.mounted) context.push('/listmyreservations', extra: rt);
// }

// DOEN: "no reservation" message when myReservations is empty SnackBar

Future<void> myReservations(BuildContext context, bool futurePast) async {
  // bool futurePast    true : future reservations
  //                    false : past reservations
  const bool b = true;
  ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
  List<Reservation> myReservations = await rr.queryMyReservations(FirebaseAuth.instance.currentUser!.uid, futurePast);
  logmessage(b, log, "myreservations myReservations --- $myReservations");

  if (myReservations.isEmpty && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('予約がありません'),
    ));
  }

  ReservationsAndText rt = ReservationsAndText(title: "今後の予約一覧", reservations: myReservations);
  // context.go('/listmyreservations');
  // context.push('/listmyreservations', extra: myReservations);
  if (context.mounted) context.push('/listmyreservations', extra: rt);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    log.info('Log in pressed');
                    ref.read(firebaseAuthProvider).signInWithEmailAndPassword(email: "dummy1@dummy.com", password: "dummy1dummy1");
                    log.info('current User is ${ref.read(firebaseAuthProvider).currentUser}');
                  },
                  child: const Text('ログイン1'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    log.info('Log in pressed');
                    ref.read(firebaseAuthProvider).signInWithEmailAndPassword(email: "dummy2@dummy.com", password: "dummy2dummy2");
                    log.info('current User is ${ref.read(firebaseAuthProvider).currentUser}');
                  },
                  child: const Text('ログイン2'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    log.info('Log in pressed');
                    ref.read(firebaseAuthProvider).signInWithEmailAndPassword(email: "dummy3@dummy.com", password: "dummy3dummy3");
                    log.info('current User is ${ref.read(firebaseAuthProvider).currentUser}');
                  },
                  child: const Text('ログイン3'),
                ),
              ],
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

  final bool l = false;

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
                logmessage(l, log, 'NewReservationScreen ListTile Tapped(台所)');
                context.push('/dateselection', extra: Facility.kitchen);
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
                logmessage(l, log, 'NewReservationScreen ListTile Tapped(会議室1)');
                context.push('/dateselection', extra: Facility.mtgR1);
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
                logmessage(l, log, 'NewReservationScreen ListTile Tapped(会議室2)');
                context.push('/dateselection', extra: Facility.mtgR2);
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

  final Facility facility;

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
        appBar: BaseAppBar(title: '日付選択画面(${facility.displayName})', appBar: AppBar(), widgets: const <Widget>[Icon(Icons.more_vert)]),
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

  final Facility facility;
  final bool l = false;

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 300,
                child: Text(
                  "まず予約日を選択します。\nその後、予約に必要な情報を入力してください。",
                  style: TextStyle(fontSize: 18),
                )),
          ],
        ),
        ElevatedButton(
            onPressed: () async {
              logmessage(l, log, 'ShowDatePickerWidget FacilitySelectionScreen ');
              ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
              List<DateTime> unreservable = await rr.getFacilityAvailableDates(facility);

              // DONE:"日付"以降でquery -> firstDate = now()
              // DONE: 期間設定修正 -> reservablePeriod
              if (context.mounted) {
                final selectedDate = await showDatePicker(
                  locale: const Locale("ja"),
                  context: context,
                  cancelText: 'キャンセル',
                  confirmText: '確定',
                  // initialDate: testDataInitialDate,
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: reservablePeriod)),
                  selectableDayPredicate: (DateTime val) {
                    logmessage(l, log, "ShowDatePickerWidget --- selectableDayPredicate --- $val");
                    // return !strunselectable2.contains(DateFormat.yMd().format(val));
                    return !unreservable.contains(val);
                  },
                );

                if (selectedDate == null) {
                  logmessage(l, log, "ShowDatePickerWidget selectedDate == null");
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('翌日以降を選んでください'),
                    ));
                  }
                  return;
                }

                var currentdate = DateTime.now();
                var justdate = DateTime(currentdate.year, currentdate.month, currentdate.day);

                logmessage(l, log, 'ShowDatePickerWidget $selectedDate ${selectedDate.runtimeType} now $justdate');
                logmessage(l, log, 'ShowDatePickerWidget ${selectedDate.difference(justdate).inDays}');

                if (selectedDate.difference(justdate).inDays > 0) {
                  var reservationinput = ReservationInputsBase(reservationDate: selectedDate, facility: facility);
                  if (context.mounted) GoRouter.of(context).push('/reservationinput', extra: reservationinput);
                }
              } else {
                log.warning("予約情報がありません");
              }
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

class ReservationInputScreen extends StatefulWidget {
  const ReservationInputScreen({super.key, required this.r});

  final ReservationInputsBase r;

  @override
  State<ReservationInputScreen> createState() => _ReservationInputScreenState();
}

class _ReservationInputScreenState extends State<ReservationInputScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  String tel = "";
  final bool b = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: BaseAppBar(
            title: '必要情報入力',
            appBar: AppBar(),
            widgets: const <Widget>[Icon(Icons.more_vert)],
          ),
          // body: Container(
          //     child: Text(
          //         'ユーザー : ${ref.read(authRepositoryProvider).currentUser?.displayName != null ? ref.read(authRepositoryProvider).currentUser?.displayName : ref.read(authRepositoryProvider).currentUser!.email}')),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("予約対象：${widget.r.facility.displayName}"),
                  Text("予約日：${date4Display()}"),
                  const SizedBox(height: 20),
                  const Text(
                    "連絡先電話番号を入力してください。",
                    style: TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: [
                      const Text("連絡先電話番号:"),
                      SizedBox(
                        height: 45,
                        width: 190,
                        child: TextField(
                          style: const TextStyle(fontSize: 23),
                          controller: myController,
                          // style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                              hintText: "数字のみ入力", hintStyle: TextStyle(color: Colors.grey, fontSize: 18), border: OutlineInputBorder()),
                          textAlignVertical: TextAlignVertical.center,
                          // onSubmitted: (value) {
                          //   tel = value;
                          //   logmessage(b, log, "_ReservationInputScreenState --- tel : $tel");
                          // },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      FilledButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('戻る'),
                      ),
                      FilledButton(
                        onPressed: () {
                          logmessage(b, log, "_ReservationInputScreenState --- myController.text: ${myController.text}");

                          // FirebaseAuth.instance.currentUser.
                          var rext = ReservationInputsExt(
                            // name: '名無し',
                            // emaill: 'dummyX@dummy.com',
                            name: FirebaseAuth.instance.currentUser!.displayName!,
                            emaill: FirebaseAuth.instance.currentUser!.email!,
                            tel: myController.text,
                            reservationDate: widget.r.reservationDate,
                            facility: widget.r.facility.displayName,
                          );
                          context.push('/reservationconfirmation', extra: rext);
                          // if (context.mounted) GoRouter.of(context).push('/reservationinput', extra: reservationinput);
                        },
                        child: const Text('進む'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }

  // String date4Display() => r.reservationDate.toString();
  String date4Display() {
    // r.reservationDate.toString();
    return DateFormat.yMd().format(widget.r.reservationDate);
  }
}

class ReservationConfirmationScreen extends StatelessWidget {
  const ReservationConfirmationScreen({super.key, required this.rext});

  final ReservationInputsExt rext;
  final bool b = true;

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("以下で予約します。"),
              SizedBox(
                height: 20,
              )
            ],
          ),
          Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // DONE: 整形

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const Align(alignment: Alignment.bottomLeft, child: Text('以下で予約します。')),
                      const SizedBox(height: 20),
                      retrunFormatedRow("予約対象\t", rext.facility),
                      retrunFormatedRow("\t\t\t\t予約日\t", dateOnlyString()),
                      retrunFormatedRow("\t\t\t\tお名前\t", "${rext.name} さん"),
                      retrunFormatedRow("電話番号\t", rext.tel),
                      retrunFormatedRow("\t\t\t\tメール\t", rext.emaill),
                      const SizedBox(height: 20),
                      // const Row(children: [Text("abc "), Text("def")]),
                      // const Row(children: [Text("abc "), Text("def")]),
                      // const Row(children: [Text("abc "), Text("def")]),
                      // const Row(children: [Text("abc "), Text("def")]),
                      // const Text("お名前", style: TextStyle(fontSize: 20)),
                      // Text("     ${rext.name}"),
                      // const SizedBox(height: 20),
                      // Text("電話番号 ${rext.tel}"),
                      // Text("メール ${rext.emaill}"),
                    ]),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // DONE: 整形
              const SizedBox(height: 100),
              FilledButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('戻る'),
              ),
              const SizedBox(width: 10),
              FilledButton(
                onPressed: () async {
                  // DONE: 予約処理
                  ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
                  // Reservation? r = await rr.queryReservationDateFacility(DateTime(2024, 10, 29), Facility.kitchen);
                  Reservation? r = await rr.queryReservationDateFacility(rext.reservationDate, getFacilitybyDisplayName(rext.facility));
                  logmessage(b, log, "reservationconfirmation --- r:$r");
                  String? id = await rr.getIDByDateFacility(rext.reservationDate, getFacilitybyDisplayName(rext.facility));
                  logmessage(b, log, "reservationconfirmation --- id:$id");
                  // 1) 追加パターン
                  //  facilities/kitchen
                  //  reserveOn  Thu Oct 24 2024 00:00:00 GMT+0900
                  //  reservers h3pe6WYTJ4SrokyQsE7XicinY1G9  dummy3
                  //  reserversにo0P96bo20UdkLHBRAQiV4JkBFzJMが追加された
                  //
                  // 2) 新規パターン
                  //  会議室2の10/25
                  // もともと19件
                  // 会議室2は5件

                  // final washingtonRef = FirebaseFirestore.instance.collection("reservations").doc(id);
                  // washingtonRef.update({
                  //   "reservers": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
                  // });

                  // テストユーザーはdummy1 o0P96bo20UdkLHBRAQiV4JkBFzJM

                  if (id != null) {
                    bool result = await rr.addReserver(id, FirebaseAuth.instance.currentUser!.uid);
                    logmessage(b, log, "reservationconfirmation --- result:$result");
                  } else {
                    rr.addReservation(
                        reserveOn: rext.reservationDate,
                        reserveMade: DateTime.now(),
                        facility: getFacilitybyDisplayName(rext.facility),
                        status: ReservationStatus.priority,
                        uid: FirebaseAuth.instance.currentUser!.uid);
                  }

                  if (context.mounted) {
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
                  }
                },
                child: const Text('確定'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row retrunFormatedRow(String title, String f) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      const SizedBox(width: 20),
      Text(title, style: const TextStyle(fontSize: 20)), // style: Theme.of(context).textTheme.displaySmall,
      Text(f)
    ]);
  }

  String dateOnlyString() {
    // logmessage(b, log, "reservationconfirmation --- ${rext.reservationDate.runtimeType}");
    return "${rext.reservationDate.year}年${rext.reservationDate.month}月${rext.reservationDate.day}日";
    // return rext.reservationDate.toString();
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
                context.go('/listmyreservations');
              },
              child: const Text('詳細')),
        ],
      ),
    );
  }
}

class ListMyReservations extends StatelessWidget {
  const ListMyReservations({super.key, this.myReservations});

  final List<Reservation>? myReservations;
  final bool b = true;

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
              onPressed: () async {
                // context.push('/usagedetails', extra: '1234567');

                ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
                List<Reservation> myReservations = await rr.queryMyReservations(FirebaseAuth.instance.currentUser!.uid, false);
                logmessage(b, log, "利用実績確認 myReservations --- $myReservations");
                ReservationsAndText rt = ReservationsAndText(title: "わたしの過去の予約一覧", reservations: myReservations);
                // context.go('/listmyreservations');
                // context.push('/listmyreservations', extra: myReservations);
                if (context.mounted) context.push('/listmyreservations', extra: rt);
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
  const ListReservations({super.key, required this.rt});

  final ReservationsAndText rt;
  final bool b = true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BaseAppBar(title: rt.title, appBar: AppBar(), widgets: const <Widget>[Icon(Icons.more_vert)]),
      body: Column(
        children: [
          Container(width: double.infinity, alignment: Alignment.center, color: Colors.green, child: const Text("予約一覧")),
          Expanded(
            child: Container(
              color: Colors.green,
              child: ListView.builder(
                itemCount: rt.reservations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Card.outlined(
                      color: Colors.green[100],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                            child: ListTile(
                              // leading: selectIcon(),
                              leading: Text(
                                "${index + 1}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              // title: Text(reservationList[index]!.getrOn),
                              title: Text(rt.reservations[index].getrOn),
                              subtitle: GetFacilityNameStatus(r: rt.reservations[index]),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                height: 35,
                                child: TextButton(
                                  child: const Text('キャンセル'),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('本当にキャンセルしますか?'),
                                        duration: const Duration(seconds: 10),
                                        action: SnackBarAction(
                                          label: '本当にキャンセルする',
                                          onPressed: () async {
                                            // TODO: キャンセル時初期画面に戻る
                                            await callCancelReservation(index, context);
                                          },
                                        ),
                                      ),
                                    );

                                    /* ... */
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> callCancelReservation(int index, BuildContext context) async {
    if (rt.reservations.isNotEmpty) {
      ReservationRepository rr = ReservationRepository(db: FirebaseFirestore.instance);
      logmessage(b, log,
          "ListReservations rt.reservations[index].facility ${rt.reservations[index].facility.runtimeType} --> ${rt.reservations[index].facility}");
      // if (rt.reservations[index].facility.toString() == "facilities/mtgR2") {
      //   logmessage(b, log,
      //       "ListReservations ${getFacilitybyDisplayName(await rt.reservations[index].getfName)} then then then then then then then then then then then ");
      // } else {
      //   logmessage(b, log,
      //       "ListReservations ${getFacilitybyDisplayName(await rt.reservations[index].getfName)} else else else else else else else else else else else ");
      // }

      bool result = await rr.cancelReservation(rt.reservations[index].reserveOn, getFacilitybyDisplayName(await rt.reservations[index].getfName));
      // bool result = await rr.cancelReservation();
      logmessage(b, log, "ListReservations result $result and ${context.mounted}");
      if (result && context.mounted) {
        myReservations(context, true);
      }
    }
  }

  Icon selectIcon() => const Icon(Icons.album);

// Text getFacilityName(Reservation r) => const Text('BUY TICKETS');
// Text getFacilityName(Reservation r) {
//   // var fname = await r.getfName;
//   // return Text("${fname}") as Text;
//   FutureBuilder(
//     future: null,
//     builder: (BuildContext context, AsyncSnapshot<String> snapshot) async {
//       var fname = await r.getfName;
//       return Text("$fname");
//     },
//   );
// }
}

class GetFacilityNameStatus extends StatelessWidget {
  const GetFacilityNameStatus({super.key, required this.r});

  final Reservation r;

  Future<String> f() async {
    // var fname = await r.getfName;
    // return fname;

    return await r.getfName;
  }

  @override
  Widget build(BuildContext context) {
    // var status4display = getReservationDisplayName(r.getStatus);
    // logmessage(true, log, status4display);
    return FutureBuilder(
      future: f(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text(
            "${snapshot.data!} --- ${r.getStatus}",
            style: const TextStyle(fontSize: 22),
          );
        } else {
          return const Text("無いぞ");
        }
      },
    );
  }
}
