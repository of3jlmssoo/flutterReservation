import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> strunselectable = [
  DateFormat.yMd().format(DateTime.now().add(const Duration(days: 2))),
  DateFormat.yMd().format(DateTime.now().add(const Duration(days: 3))),
  // DateFormat.yMd().format(DateTime.now())
];

class DatePickerApp extends StatelessWidget {
  const DatePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      restorationScopeId: 'app',
      home: DatePickerExample(restorationId: 'main'),
    );
  }
}

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerExampleState extends State<DatePickerExample>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      // RestorableDateTime(DateTime(2021, 7, 25));
      RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          // initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          // initialDate: unselectableDates[1],
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 20)),
          selectableDayPredicate: (DateTime val) {
            // print('---------> ${DateFormat.yMd().format(val)}');
            // print("$val,  and  ${unselectableDates.contains(val)}");
            // return val.weekday == 6 || val.weekday == 7 ? false : true;
            return !strunselectable.contains(DateFormat.yMd().format(val));
          },
          // unselectableDates.contains(val) ? true : false,
          // val.weekday == 6 || val.weekday == 7 ? false : true,
          // unselectableDates.contains(val),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              '選ばれたのは: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          child: const Text('Open Date Picker'),
        ),
      ),
    );
  }
}
