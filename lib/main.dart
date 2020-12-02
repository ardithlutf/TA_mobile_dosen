import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/resources/injector/injector.dart';

// void main() => runApp(App());

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(App());
  } catch (error, stacktrace) {
    print('$error & $stacktrace');
  }
}