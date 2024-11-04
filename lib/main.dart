import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reservations2/app.dart';

import 'firebase_options.dart';

// white 0xFFFFFFFF
// yellow 0xFFFFFF00

final log = Logger('MainLogger');

Future<void> main() async {
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint('[${rec.loggerName}] ${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  log.info("main started");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      // ignore: avoid_print
      log.info("error at emulator start $e");
    }
  }

  runApp(
    ProviderScope(
        child: MaterialApp(
            home: const MyApp(),
            theme: ThemeData(useMaterial3: true, textTheme: const TextTheme(displaySmall: TextStyle(fontSize: 10))))),
  );
}
