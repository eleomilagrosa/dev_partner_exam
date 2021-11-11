import 'package:dev_partner_exam2/constants/end_points.dart';
import 'package:dev_partner_exam2/constants/error_codes.dart';
import 'package:dev_partner_exam2/controllers/app_controller.dart';
import 'package:dev_partner_exam2/data/model/tags.dart';
import 'package:dev_partner_exam2/data/network/base_resource.dart';
import 'package:dio/dio.dart';

class TagsResource extends BaseResource{
  TagsResource(AppController appController): super(appController);

  Future<List<Tags>> getAllTags()async{
    Response response = await dio.get(Endpoints.getAllTags);
    if((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300){
      return response.data["tags"].map<Tags>((tag) => Tags.fromJson(tag)).toList();
    }else{
      // or any error handling
      throw ErrorCodes.no_tags;
    }
  }
}