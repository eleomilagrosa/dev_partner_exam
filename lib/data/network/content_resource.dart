import 'package:dev_partner_exam2/constants/end_points.dart';
import 'package:dev_partner_exam2/constants/error_codes.dart';
import 'package:dev_partner_exam2/controllers/app_controller.dart';
import 'package:dev_partner_exam2/data/model/content.dart';
import 'package:dev_partner_exam2/data/network/base_resource.dart';
import 'package:dio/dio.dart';

class ContentResource extends BaseResource{
  ContentResource(AppController appController): super(appController);
  Future<List<Content>> getAllContent()async{
    Response response = await dio.get(Endpoints.getAllContent);
    if((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300){
      return response.data["learn_content"].map<Content>((content) => Content.fromJson(content)).toList();
    }else{
      // or any error handling
      throw ErrorCodes.no_content;
    }
  }
}