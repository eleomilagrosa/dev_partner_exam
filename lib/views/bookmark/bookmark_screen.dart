import 'package:dev_partner_exam2/constants/colors.dart';
import 'package:dev_partner_exam2/constants/font_style.dart';
import 'package:dev_partner_exam2/controllers/dashboard_controller.dart';
import 'package:dev_partner_exam2/data/model/content.dart';
import 'package:dev_partner_exam2/views/dashboard/widgets/item_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  final DashboardController dashboardController;
  const BookmarkScreen(this.dashboardController,{Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loadAppBar(),
      body: StreamBuilder<List<Content>>(
          stream: widget.dashboardController.dataContentStream.stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Container();
            return ListView(
              children: snapshot.data!
                  .where((content) => content.isBookMarked)
                  .map((content) => ItemContentWidget(
                  content: content,
                  isBookMarked: content.isBookMarked,
                  onTapBody: (){

                  },
                  onTapBookMarked:(){
                    content.isBookMarked = !content.isBookMarked;
                    setState((){});
                  }
              )).toList(),
            );
          }
      ),
    );
  }


  AppBar loadAppBar(){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text( "Saved for later", style: AppFontStyle.font20.copyWith(fontWeight: FontWeight.bold,color: AppColors.colorAll),),
      leading: IconButton(
          onPressed: ()async{
            Navigator.pop(context);
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: AppColors.backgroundBtn,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Image.asset("assets/images/x-button.png",height: 18,)
          )
      )
      // iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
