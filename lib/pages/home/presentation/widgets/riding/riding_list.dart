import 'package:flutter/material.dart';
import 'package:hikespot/pages/home/presentation/widgets/riding/rides_widgets.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/enums.dart';

import '../../../../../utils/images_paths.dart';

class RidingList extends StatefulWidget {
  const RidingList({super.key});

  @override
  State<RidingList> createState() => _RidingListState();
}

class _RidingListState extends State<RidingList> {
  late ScrollController _scrollController;
  bool _isAtEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          _isAtEnd = true;
        });
      }
    } else {
      setState(() {
        _isAtEnd = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: const Row(
            children: [
               RidesWidget(
                heading: "Ride",
                subHeading: "Business Class\n4 Seater",
                icon: AppImages.carTypeIcon,
                service: CaptainService.CARBUSSINESSRIDES,
                index: 0,
              ),
              RidesWidget(
                heading: "Ride",
                subHeading: "A/C",
                icon: AppImages.carTypeIcon,
                secIcon: AppImages.snowIcon,
                service: CaptainService.CARRIDESWITHAC,
                index: 1,
              ),
              RidesWidget(
                heading: "Ride",
                subHeading: "City to City",
                icon: AppImages.carTypeIcon,
                secIcon: AppImages.travelIcon,
                service: CaptainService.CITYTOCITYRIDES,
                index: 2,
              ),
              RidesWidget(
                heading: "Bike Ride",
                subHeading: "Easy Ride \n  ",
                icon: AppImages.bikeTypeIcon,
                service: CaptainService.BIKERIDES,
                index: 3,
              ),
              RidesWidget(
                heading: "Ride",
                subHeading: "Taxi \n  ",
                icon: AppImages.taxiImage,
                service: CaptainService.TAXIRIDES,
                index: 4,
              ),
              RidesWidget(
                heading: "Ride",
                subHeading: "Double \nCab",
                icon: AppImages.doubleCab,
                service: CaptainService.DOUBLECABRIDES,
                index: 5,
              ),
              RidesWidget(
                heading: "Ride",
                subHeading: "SUV \n  ",
                icon: AppImages.suvIcon,
                service: CaptainService.SUVRIDES,
                index: 6,
              ),
              RidesWidget(
                heading: "Ride",
                subHeading: "Utility \n  ",
                icon: AppImages.suvIcon,
                service: CaptainService.UTILITYRIDES,
                index: 7,
              ),
              RidesWidget(
                heading: "Ride",
                subHeading: "Heavy Duty\nTruck",
                icon: AppImages.truckImage,
                service: CaptainService.HEAVYDUITYTRACKRIDES,
                index: 8,
              ),
              RidesWidget(
                heading: "Ride",
                subHeading: "Tuk Tuk\nTaxi",
                icon: AppImages.rickshawIcon,
                service: CaptainService.TUKTUKRIDES,
                index: 9,
              ),
            ],
          ),
        ),
        if (!_isAtEnd)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withOpacity(0.65),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward_ios_rounded,
                    color: AppColors.whiteColor),
              ),
            ),
          ),
      ],
    );
  }
}
