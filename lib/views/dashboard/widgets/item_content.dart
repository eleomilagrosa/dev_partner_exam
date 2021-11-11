import 'package:cached_network_image/cached_network_image.dart';
import 'package:dev_partner_exam2/constants/colors.dart';
import 'package:dev_partner_exam2/constants/font_style.dart';
import 'package:dev_partner_exam2/data/model/content.dart';
import 'package:dev_partner_exam2/utils/extension.dart';
import 'package:dev_partner_exam2/views/dashboard/widgets/item_tags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemContentWidget extends StatelessWidget {
  final Content content;
  final bool isBookMarked;
  final Function()? onTapBookMarked;
  final Function()? onTapBody;

  const ItemContentWidget({
    required this.content,
    this.isBookMarked = false,
    this.onTapBookMarked,
    this.onTapBody,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget placeHolder = const SizedBox(
        height: 50,
        child: Center(
            child: CircularProgressIndicator()
        )
    );
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      child: InkWell(
        onTap: onTapBody,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CachedNetworkImage(
                      imageUrl: content.thumbnailUrl,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                          image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                        ),
                      ),
                      placeholder: (context, url) {
                        return placeHolder;
                      },
                      errorWidget: (context, url, _) {
                        return placeHolder;
                      },
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2,),
                          Row(
                            children: [
                              Image.asset("assets/images/article-icon.png",height: 18,),
                              Text(" ${content.type.capitalizeFirstLetter} \u2022 ${content.toDateString}", style: AppFontStyle.font12.copyWith(color: AppColors.greyText),),
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Text(content.title, style: AppFontStyle.font14Bold,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          Text(content.description, style: AppFontStyle.font12.copyWith(color: AppColors.greyText),maxLines: 2,overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: onTapBookMarked,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(isBookMarked ? "assets/images/save-grey-icon.png" : "assets/images/save-white-icon.png",height: 24,),
                      )
                  )
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text("Shared by OnLoop", style: AppFontStyle.font12.copyWith(color: AppColors.greyText),),
                        ),
                        Wrap(
                          children: content.tags.map((tag) => ItemTagWidget(tag: tag)).toList(),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/thumbs-down.png",height: 30),
                      Image.asset("assets/images/thumbs-up.png",height: 30),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
