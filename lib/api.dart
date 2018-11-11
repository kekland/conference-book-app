import 'package:conference/application.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class API {
  static Dio dio;
  static String baseURL = 'http://conference-book.eu-4.evennode.com';
  static String token = "";
  static init() {
    dio = new Dio();
    dio.cookieJar = new CookieJar();
    token = Application.prefs.getString("token");
  }

  static Future<String> login(String username, String password) async {
    Map data = {
      'username': username,
      'password': password,
    };
    try {
      var response = await dio.post(baseURL + '/account/login', data: data);
      token = response.data['token'];
      await Application.prefs.setString("token", token);
      await Application.prefs.setString("username", username);
      return response.data['token'];
    } catch (e) {
      if (e.runtimeType == DioError) {
        var message = e.response.data['message'];
        print(message);
        throw message;
      } else {
        throw e;
      }
    }
  }

  static Future<String> register(
    String username,
    String email,
    String password,
  ) async {
    Map data = {
      'username': username,
      'email': email,
      'password': password,
    };
    try {
      var response = await dio.post(baseURL + '/account/register', data: data);
      token = response.data['token'];
      await Application.prefs.setString("token", token);
      await Application.prefs.setString("username", username);
      return response.data['token'];
    } catch (e) {
      if (e.runtimeType == DioError) {
        var message = e.response.data['message'];
        print(message);
        throw message;
      } else {
        throw e;
      }
    }
  }

  static Future<List> getConferences() async {
    try {
      var response = await dio.get(
        baseURL + '/conferences',
      );
      return response.data;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var message = e.response.data['message'];
        print(message);
        throw message;
      } else {
        throw e;
      }
    }
  }

  static Future<Map> createConference(Map data) async {
    try {
      var response = await dio.post(
        baseURL + '/conferences',
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );
      return response.data;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var message = e.response.data['message'];
        print(message);
        throw message;
      } else {
        throw e;
      }
    }
  }

  static Future<List> getProfile(String username) async {
    Map data = {'username': username};
    try {
      var response = await dio.get(
        baseURL + '/conferences/user',
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
        data: data,
      );
      return response.data;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var message = e.response.data['message'];
        print(message);
        throw message;
      } else {
        throw e;
      }
    }
  }

  static Future<Map> book(TimeOfDay from, TimeOfDay to, String cost) async {
    try {
      DateTime now = DateTime.now();
      int stamp1 =
          DateTime.utc(now.year, now.month, now.day, from.hour, from.minute)
              .millisecondsSinceEpoch;
      int stamp2 =
          DateTime.utc(now.year, now.month, now.day, to.hour, to.minute)
              .millisecondsSinceEpoch;
      Map data = {
        "from": stamp1.toString(),
        "to": stamp2.toString(),
        "cost": cost,
        "room": Application.tempBooking['id']
      };
      var response = await dio.post(
        baseURL + '/order',
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );
      return response.data;
    } catch (e) {
      if (e.runtimeType == DioError) {
        var message = e.response.data['message'];
        print(message);
        throw message;
      } else {
        throw e;
      }
    }
  }
}
