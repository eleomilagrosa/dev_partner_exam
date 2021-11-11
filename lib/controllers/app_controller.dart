import 'dart:async';

import 'package:dev_partner_exam2/constants/end_points.dart';
import 'package:dev_partner_exam2/utils/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AppController extends ChangeNotifier{
  final Completer<bool> isInitialized = Completer();

  Dio? _dio;
  Dio get dio => _dio!;
  late SharedPreferenceHelper sharedPreferenceHelper;

  AppController(){
    sharedPreferenceHelper = SharedPreferenceHelper();
    _initDio();
  }

  _initDio(){
    _dio = Dio();
    dio..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.sendTimeout = Endpoints.receiveTimeout
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,RequestInterceptorHandler handler){
            // Handling Access Token

            // var token = sharedPreferenceHelper.getUser?.accessToken;
            // if (token != null) {
            //   options.headers.putIfAbsent('Authorization', () => token);
            // }else{
            //   print("No Token");
            // }
            handler.next(options);
          },
        ),
      );
    isInitialized.complete(true);
  }

}