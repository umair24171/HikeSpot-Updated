import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final List<String> images;
  final String hint;
  final bool isNeedAddCard;
  const CustomDropdown({
    super.key,
    required this.items,
    this.hint = 'Payment method',
    required this.images, required this.isNeedAddCard,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _selectItem(String item) {
    setState(() {
      _selectedItem = item;
      _isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleMenu,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.secContainerColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextStyle(
                  text: _selectedItem ?? widget.hint,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primaryDark,
                ),
              ],
            ),
          ),
        ),
        if (_isMenuOpen)
          Container(
            height: 210,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: AppColors.customColor(0xff363636).withOpacity(0.65),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.dialogeColor, width: 1)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  children: [
                    if(widget.isNeedAddCard)
                    Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryDark, width: 1),
                            borderRadius: BorderRadius.circular(11)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.addMoneyIcon),
                            const SizedBox(
                              width: 10,
                            ),
                            const AppTextStyle(
                              text: "Add Card",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final image = widget.images[index];
                          return GestureDetector(
                              onTap: () => _selectItem(item),
                              child: Row(
                                children: [
                                  SvgPicture.asset(image),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  AppTextStyle(
                                    text: item,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                  const Spacer(),
                                  Radio<String>(
                                    value: item,
                                    groupValue: _selectedItem,
                                    activeColor: AppColors.primaryDark,
                                    onChanged: (value) {
                                      if (value != null) {
                                        _selectItem(value);
                                      }
                                    },
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
