import 'package:conference/api.dart';
import 'package:conference/application.dart';
import 'package:conference/create_page.dart';
import 'package:conference/login_page.dart';
import 'package:conference/main_page.dart';
import 'package:conference/registration_page.dart';
import 'package:conference/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Application.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    API.init();
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
    SystemChrome.setSystemUIOverlayStyle(new SystemUiOverlayStyle(
        statusBarColor: const Color(0x00FFFFFF),
        statusBarIconBrightness: Brightness.light));
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.blueAccent,
        primaryColor: Colors.white,
      ),
      initialRoute: (Application.prefs.getString("token") != null)? '/' : '/register',
      onGenerateRoute: Application.router.generator,
    );
  }
}
