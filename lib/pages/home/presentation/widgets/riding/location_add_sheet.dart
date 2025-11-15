import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/create_ride_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/location_search_field.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../../bloc/cubit/google_map_cubit.dart';

class LocationAddSheet extends StatefulWidget {
  const LocationAddSheet({super.key});

  @override
  State<LocationAddSheet> createState() => _LocationAddSheetState();
}

class _LocationAddSheetState extends State<LocationAddSheet> {
  final _controller = TextEditingController();
  final _stepOverController = TextEditingController();
  final _destinationController = TextEditingController();
  bool isSkipingStepover = false;
  int textControlleris = 0;
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
  
  @override
  void initState() {
    super.initState();
    // 🔥 Load existing values from CreateRideCubit
    _controller.text = Di().sl<GoogleMapCubit>().getAddressFromPlacemark();
    
    // 🔥 NEW: Load previously selected destination if exists
    if (_createRideCubit.destinationAddress.isNotEmpty) {
      _destinationController.text = _createRideCubit.destinationAddress;
    }
    
    // 🔥 NEW: Load previously selected stepover if exists
    if (_createRideCubit.stepOverAddress.isNotEmpty) {
      _stepOverController.text = _createRideCubit.stepOverAddress;
    }
    
    _controller.addListener(() {
      textControlleris = 0;
      _onChanged(_controller.text);
      _createRideCubit.setSearchingLocation(isFrom: true);
    });
    _stepOverController.addListener(() {
      textControlleris = 1;
      _onChanged(_stepOverController.text);
      _createRideCubit.setSearchingLocation(isStepOver: true);
    });
    _destinationController.addListener(() {
      textControlleris = 2;
      _onChanged(_destinationController.text);
      _createRideCubit.setSearchingLocation(isTo: true);
    });
  }

  _onChanged(String text) {
    if (_sessionToken.isNotEmpty) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(text);
  }

  void getSuggestion(String input) async {
    const String PLACES_API_KEY = AppConstants.googleMapApiKey;

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      
      if (kDebugMode) {
        print('Autocomplete response: $data');
      }
      
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      debugPrint('Error in getSuggestion: ${e.toString()}');
    }
  }

  void getPlaceDetails(String placeId, String placeDescription) async {
    const String PLACES_API_KEY = AppConstants.googleMapApiKey;

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/details/json';
      String request = '$baseURL?place_id=$placeId&key=$PLACES_API_KEY';

      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var result = data['result'];
        var geometry = result['geometry'];
        var location = geometry['location'];
        double latitude = location['lat'];
        double longitude = location['lng'];

        // Set the text based on which controller is active
        if (textControlleris == 0) {
          _controller.text = placeDescription;
        } else if (textControlleris == 1) {
          _stepOverController.text = placeDescription;
        } else if (textControlleris == 2) {
          _destinationController.text = placeDescription;
        }

        if (kDebugMode) {
          print("Latitude: $latitude, Longitude: $longitude");
          print("Selected place: $placeDescription");
        }

        // Save the location
        _createRideCubit.getAddressAccording(
            latitude, longitude, placeDescription);
        
        // 🔥 FIXED: Only draw route and close sheet if DESTINATION was selected
        if (textControlleris == 2) {
          print("🔥 DESTINATION SELECTED - Starting route calculation...");
          
          // Show loading indicator
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("Calculating route and fare..."),
                  ],
                ),
                duration: Duration(seconds: 3),
              ),
            );
          }
          
          // Try to draw route and calculate distance
          print("🔥 Calling getPolyPoints...");
          await _googleMapCubit.getPolyPoints(latitude, longitude);
          print("🔥 getPolyPoints completed!");
          
          // 🔥 CRITICAL FIX: Calculate fare after getting distance
          print("🔥 Distance calculated: ${_googleMapCubit.routeDistanceInKm} km");
          
          if (_googleMapCubit.routeDistanceInKm > 0) {
            print("🔥 Calling calculateAndSetFare with distance: ${_googleMapCubit.routeDistanceInKm}");
            
            // Call the fare calculation
            _createRideCubit.calculateAndSetFare(_googleMapCubit.routeDistanceInKm);
            
            // Small delay to ensure state updates
            await Future.delayed(const Duration(milliseconds: 200));
            
            print("🔥 Fare controller text after calculation: ${_createRideCubit.fareController.text}");
          } else {
            print("❌ Distance is 0, cannot calculate fare");
          }
          
          // Show success feedback with distance and fare
          if (mounted) {
            ScaffoldMessenger.of(context).clearSnackBars();
            
            String message;
            if (_createRideCubit.fareController.text.isNotEmpty) {
              if (_googleMapCubit.polylineCoordinates.isNotEmpty) {
                message = "✓ Route: ${_googleMapCubit.routeDistanceText}\nFare: R${_createRideCubit.fareController.text}";
              } else {
                message = "✓ Distance: ${_googleMapCubit.routeDistanceText}\nFare: R${_createRideCubit.fareController.text}";
              }
            } else {
              message = "✓ Distance: ${_googleMapCubit.routeDistanceText}\nFare calculation pending...";
            }
            
            print("🔥 Showing snackbar: $message");
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 3),
                backgroundColor: AppColors.primaryDark,
              ),
            );
          }
          
          // Close the bottom sheet only for destination
          if (mounted) {
            print("🔥 Closing location sheet...");
            Navigator.pop(context);
          }
        } else {
          // 🔥 For "From" and stepover, just show feedback but keep sheet open
          print("🔥 From/Stepover location updated (controller: $textControlleris)");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(textControlleris == 0 
                    ? "Pickup location updated" 
                    : "Stopover location set"),
                duration: const Duration(seconds: 1),
                backgroundColor: AppColors.primaryDark,
              ),
            );
          }
        }
        
        // Clear the suggestion list
        setState(() {
          _placeList = [];
        });
      } else {
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      debugPrint('Error in getPlaceDetails: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _stepOverController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: const BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border(
              top: BorderSide(color: AppColors.dialogeColor, width: 1.5))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 40,
              ),
              const AppTextStyle(
                text: "Enter your route",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      color: AppColors.primaryDark.withOpacity(0.37),
                      shape: BoxShape.circle),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.cancelIcon),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          LocationSearchField(
            hintText: "From",
            controller: _controller,
            prefixIcon: const Icon(
              Icons.my_location_rounded,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const SizedBox(
            height: 20,
          ),
          LocationSearchField(
            controller: _destinationController,
            hintText: "To",
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    getPlaceDetails(
                      _placeList[index]["place_id"],
                      _placeList[index]["description"],
                    );
                  },
                  child: ListTile(
                    title: Text(
                      _placeList[index]["description"],
                      style: const TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

final CreateRideCubit _createRideCubit = Di().sl<CreateRideCubit>();
final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();