import 'dart:async';

import 'package:dev_partner_exam2/constants/end_points.dart';
import 'package:dev_partner_exam2/controllers/app_controller.dart';
import 'package:dio/dio.dart';

class BaseResource{
  late Dio dio;
  BaseResource(AppController appController){
   dio = appController.dio;
  }
}