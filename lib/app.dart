import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservations2/riverpods.dart';

import 'app_router.dart';
import 'consts.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("ja"),
      ],
      routerConfig: goRouter,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 30),
          bodyMedium: TextStyle(fontSize: 25),
        ),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStatus = ref.watch(exampleProvider);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          MenuAnchor(
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return IconButton(
                color: Colors.white,
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.density_medium),
                tooltip: 'Show menu',
              );
            },
            menuChildren: [
              MenuItemButton(
                onPressed: () {
                  ref.read(exampleProvider.notifier).setToZero();
                  print(ref.watch(exampleProvider));
                },
                child: const Text('set to 0'),
              ),
              MenuItemButton(
                onPressed: () {
                  ref.read(exampleProvider.notifier).setToOne();
                  print(ref.watch(exampleProvider));
                },
                child: const Text('set to 1'),
              ),
              MenuItemButton(
                onPressed: () {},
                child: const Text('answer check'),
              ),
              MenuItemButton(
                child: const Text('main'),
                onPressed: () {},
              )
            ],
          ),
        ],

        backgroundColor:
            commonBackgroundColor, // Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "widget.title",
          style: TextStyle(color: brightFontColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userStatus == 1
                ? Text(
                    'You have pushed the button this many times:',
                  )
                : Text('abc'),
            Text(
              '7',
              // '$_counter',
              // style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _counter = _counter + 1;
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
