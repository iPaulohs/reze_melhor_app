import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:reze_melhor/firebase_options.dart';

import 'env.dart';

class InitFirebase {
  static Future<void> start() async {

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if(Env.env == "dev") {

      FirebaseAppCheck.instance.activate(
          androidProvider: AndroidProvider.debug
      );

      FirebaseFunctions.instance.useFunctionsEmulator("192.168.1.150", 5050);

    }else{
      FirebaseAppCheck.instance.activate(
          androidProvider: AndroidProvider.playIntegrity
      );
    }

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
