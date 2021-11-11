import 'package:dev_partner_exam2/controllers/app_controller.dart';
import 'package:flutter/cupertino.dart';

class BaseController extends ChangeNotifier{
  AppController appController;
  BaseController(this.appController);
}