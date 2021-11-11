import 'package:dev_partner_exam2/constants/font_style.dart';
import 'package:dev_partner_exam2/data/model/tags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemTagWidget extends StatelessWidget {

  final Tags tag;
  final bool isSelected;
  final Function()? onTap;
  const ItemTagWidget({
    required this.tag,
    this.isSelected = false,
    this.onTap,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
        decoration: BoxDecoration(
            color: tag.toColor.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: tag.toColor.withOpacity(isSelected ? 1 : .5),
                width: isSelected ? 2 : .5
            )
        ),
        constraints: const BoxConstraints(
            minWidth: 50
        ),
        child: Text(tag.name,
          style: AppFontStyle.font12.copyWith(
            fontWeight: FontWeight.bold,
            color: tag.toColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
