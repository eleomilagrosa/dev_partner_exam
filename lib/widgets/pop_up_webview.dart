import 'package:dev_partner_exam2/constants/colors.dart';
import 'package:dev_partner_exam2/constants/font_style.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PopUpWebView{
  static show(BuildContext context,String url,String type){
    showDialog(context: context,
      builder: (context){
        return Scaffold(
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text( type, style: AppFontStyle.font20.copyWith(fontWeight: FontWeight.bold,color: AppColors.colorAll),),
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
          ),
          body: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
          ),
        );
      }
    );
  }

}