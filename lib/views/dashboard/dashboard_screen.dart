import 'package:cached_network_image/cached_network_image.dart';
import 'package:dev_partner_exam2/constants/colors.dart';
import 'package:dev_partner_exam2/constants/font_style.dart';
import 'package:dev_partner_exam2/constants/routes.dart';
import 'package:dev_partner_exam2/controllers/app_controller.dart';
import 'package:dev_partner_exam2/controllers/dashboard_controller.dart';
import 'package:dev_partner_exam2/data/model/content.dart';
import 'package:dev_partner_exam2/data/model/tags.dart';
import 'package:dev_partner_exam2/views/dashboard/widgets/item_content.dart';
import 'package:dev_partner_exam2/views/dashboard/widgets/item_tags.dart';
import 'package:dev_partner_exam2/widgets/pop_up_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardController>(create: (_) =>
            DashboardController(Provider.of<AppController>(context))
        ),
      ],
      builder: (context,_){
        return Consumer<DashboardController>(
          builder: (context,dashboardController,_){
            return Scaffold(
              appBar: loadAppBar(dashboardController),
              body: loadBody(dashboardController),
            );
          }
        );
      },
    );
  }


  AppBar loadAppBar(DashboardController dashboardController){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text( "Learn", style: AppFontStyle.font20.copyWith(fontWeight: FontWeight.bold,color: AppColors.colorAll),),
      actions: [
        IconButton(
          onPressed: ()async{
            gotoBookmarkScreen(dashboardController);
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: AppColors.backgroundBtn,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Image.asset("assets/images/save-white-icon.png")
          )
        )
      ],
      // iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget loadBody(DashboardController dashboardController){
    return Column(
      children:[
        _buildTags(dashboardController),
        Expanded(child: _buildContents(dashboardController)),
        const SizedBox(height: 8,)
      ],
    );
  }

  Widget _buildTags(DashboardController dashboardController){
    return StreamBuilder<List<Tags>>(
        stream: dashboardController.dataTagsStream.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Container();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: snapshot.data!
                .map((tag){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ItemTagWidget(
                      tag: tag,
                      isSelected: tag.isSelected,
                      onTap:(){
                        tag.isSelected = !tag.isSelected;
                        setState((){});
                      }
                    ),
                  );
              }).toList(),
            ),
          );
        }
    );
  }
  Widget _buildContents(DashboardController dashboardController){
    return StreamBuilder<List<Content>>(
        stream: dashboardController.dataContentStream.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Container();
          return ListView(
            children: snapshot.data!
              .where((content) => content.tags.where((tag){
                List<Tags> allTags = dashboardController.dataTagsStream.valueOrNull ?? [];
                bool isAll = allTags.firstOrNull?.isSelected ?? true;
                if(isAll){
                  return true;
                }else{
                  return dashboardController.dataTagsStream.valueOrNull
                      ?.where((iTag) => iTag.name == tag.name && iTag.isSelected)
                      .isNotEmpty ?? true;
                }
              }).isNotEmpty)
              .map((content) => ItemContentWidget(
                content: content,
                isBookMarked: content.isBookMarked,
                onTapBody: (){
                  PopUpWebView.show(context, content.contentUrl);
                },
                onTapBookMarked:(){
                  content.isBookMarked = !content.isBookMarked;
                  setState((){});
                }
              )).toList(),
          );
        }
    );
  }


  void gotoBookmarkScreen(DashboardController dashboardController)async{
    await Navigator.pushNamed(context, Routes.BOOKMARKED_PAGE, arguments: dashboardController);
    setState(() {});
  }
}
