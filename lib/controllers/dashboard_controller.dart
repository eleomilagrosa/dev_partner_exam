import 'package:dev_partner_exam2/constants/colors.dart';
import 'package:dev_partner_exam2/controllers/app_controller.dart';
import 'package:dev_partner_exam2/controllers/base_controller.dart';
import 'package:dev_partner_exam2/data/model/content.dart';
import 'package:dev_partner_exam2/data/model/tags.dart';
import 'package:dev_partner_exam2/data/network/content_resource.dart';
import 'package:dev_partner_exam2/data/network/tags_resource.dart';
import 'package:rxdart/rxdart.dart';

class DashboardController extends BaseController{

  final ContentResource _contentResource;
  final TagsResource _tagsResource;
  DashboardController(AppController appController):
        _contentResource = ContentResource(appController),
        _tagsResource = TagsResource(appController),
        super(appController) {
    _init();
  }

  BehaviorSubject<List<Content>> dataContentStream = BehaviorSubject();
  BehaviorSubject<List<Tags>> dataTagsStream = BehaviorSubject();

  _init()async{
    await appController.isInitialized.future;
    await Future.wait([
      loadTags(),
      loadContent()
    ]);
  }

  Future loadTags()async{
    try{
      var tags = await _tagsResource.getAllTags();
      tags.insert(0, Tags(color: "all", name: "All")..isSelected = true);
      dataTagsStream.add(tags);
    }catch(e,trace){
      // handle API error;
      print([e,trace]);
    }
  }
  Future loadContent()async{
    try{
      var contents = await _contentResource.getAllContent();
      dataContentStream.add(contents);
    }catch(e,trace){
      // handle API error;
      print([e,trace]);
    }
  }

}