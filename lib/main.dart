import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:volunteer/providers/main_provider.dart';
import 'package:volunteer/screens/splash_screen.dart';




var isWebOrDesktop = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  isWebOrDesktop =
      kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  if (!isWebOrDesktop) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  initializeDateFormatting('uk_UA', null).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Волонтер',
          theme: ThemeData(
              primarySwatch: Colors.pink,
              appBarTheme: AppBarTheme(elevation: 0)),
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
