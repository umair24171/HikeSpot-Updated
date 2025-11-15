import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/data/model/ride/ride_data_model.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/dialog/rider_dialoge.dart';
import 'package:hikespot/utils/app_text_style.dart';
import '../../../../../utils/app_colors.dart';

class RiderArrivedDialoge extends StatefulWidget {
  const RiderArrivedDialoge({super.key, required this.acceptRideModel});
  final RideDataModel acceptRideModel;

  @override
  State<RiderArrivedDialoge> createState() => _RiderArrivedDialogeState();
}

class _RiderArrivedDialogeState extends State<RiderArrivedDialoge> {
  Timer? _timer;
  bool _isLoading = false;
  
  @override
  void initState() {
    // Auto-start ride after 5 minutes if user doesn't confirm
    _timer = Timer(const Duration(minutes: 5), () async {
      if (mounted && !_isLoading) {
        await _startRide();
      }
    });
    super.initState();
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  Future<void> _startRide() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Update ride status to start_destination
      await FirebaseFirestore.instance
          .collection('rides')
          .doc(widget.acceptRideModel.rideId)
          .update({'rideStatus': 'start_destination'});
      
      print("✅ Ride started - going to destination");
      
      // Get the updated ride data
      DocumentSnapshot rideDoc = await FirebaseFirestore.instance
          .collection('rides')
          .doc(widget.acceptRideModel.rideId)
          .get();
      
      if (rideDoc.exists) {
        RideDataModel updatedRide = RideDataModel.fromJson(
          rideDoc.data() as Map<String, dynamic>
        );
        
        // Update map to show route to destination
        final GoogleMapCubit googleMapCubit = Di().sl<GoogleMapCubit>();
        googleMapCubit.getPolyPoints(
          updatedRide.destinationLatitude,
          updatedRide.destinationLongitude,
        );
        
        // Close the dialog
        if (mounted) {
          Navigator.pop(context);
          
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Ride started! Going to destination 🚗"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
      
    } catch (e) {
      print("❌ Error starting ride: $e");
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error starting ride: $e"),
            backgroundColor: AppColors.redColor,
          ),
        );
        
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.containerColor.withOpacity(0.4),
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: 320,
            decoration: BoxDecoration(
                color: const Color(0xff1e2124).withOpacity(.6),
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.only(top: 17, left: 11, right: 11, bottom: 17),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Driver info
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 59,
                        width: 59,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryDark.withOpacity(0.5)),
                        child: widget.acceptRideModel.driverImage.isNotEmpty
                            ? Image.network(
                                widget.acceptRideModel.driverImage,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                                size: 30,
                              ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: widget.acceptRideModel.driverName,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                          const AppTextStyle(
                            text: "has arrived!",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Message
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primaryDark,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: AppTextStyle(
                          text: "Your driver is waiting at the pickup location",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Okay Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DialogBoxButton(
                        text: _isLoading ? 'Starting...' : 'Start Ride',
                        onTap: _isLoading ? null : _startRide,
                      
                        textColor: _isLoading 
                            ? AppColors.primaryGreyColor 
                            : AppColors.blackColor,
                        bgColor: _isLoading 
                            ? AppColors.primaryGreyColor.withOpacity(0.3)
                            : const Color(0xffffbc07),
                        borderColor: _isLoading
                            ? AppColors.primaryGreyColor
                            : const Color(0xff7a561c),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Button Widget
class DialogBoxButton extends StatelessWidget {
  const DialogBoxButton({
    super.key,
    required this.text,
    this.onTap,
    this.bgColor,
    required this.borderColor,
    required this.textColor,
  });
  
  final String text;
  final Color textColor;
  final Color? bgColor;
  final Color borderColor;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11.7),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(11.7),
            border: Border.all(width: 2.6, color: borderColor)),
        child: AppTextStyle(
          text: text,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}