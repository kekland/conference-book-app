import 'package:conference/book_page.dart';
import 'package:conference/create_page.dart';
import 'package:conference/login_page.dart';
import 'package:conference/main_page.dart';
import 'package:conference/profile_page.dart';
import 'package:conference/registration_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static String list = '/';
  static String login = '/login';
  static String registration = '/register';
  static String registrationInfo = '/registerInfo';
  static String create = '/create';
  static String book = '/book';
  static String profile = '/profile/:username';

  static Handler listHandler = new Handler(handlerFunc: (context, params) {
    return MainPage();
  }, type: HandlerType.route);
  
  static Handler loginHandler = new Handler(handlerFunc: (context, params) {
    return LoginPage();
  }, type: HandlerType.route);
  
  static Handler registrationHandler = new Handler(handlerFunc: (context, params) {
    return RegistrationPage();
  }, type: HandlerType.route);
  
  static Handler createHandler = new Handler(handlerFunc: (context, params) {
    return CreateConferencePage();
  });
  static Handler profileHandler = new Handler(handlerFunc: (context, params) {
    return ProfilePage(username: params['username'][0]);
  });
  static Handler bookHandler = new Handler(handlerFunc: (context, params) {
    return BookPage();
  });
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("Route was not found.");
    });
    router.define(list, handler: listHandler);
    router.define(login, handler: loginHandler);
    router.define(registration, handler: registrationHandler);
    router.define(create, handler: createHandler);
    router.define(profile, handler: profileHandler);
    router.define(book, handler: bookHandler);
  }
}