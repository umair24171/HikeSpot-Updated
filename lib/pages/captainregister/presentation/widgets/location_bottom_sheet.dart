import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/captainregister/presentation/bloc/cubit/create_captain_register_cubit.dart';
import 'package:hikespot/pages/home/presentation/widgets/location_search_field.dart';
import 'package:hikespot/utils/app_colors.dart';
import 'package:hikespot/utils/app_text_style.dart';
import 'package:hikespot/utils/images_paths.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hikespot/utils/sizes.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CaptainLocationAddSheet extends StatefulWidget {
  const CaptainLocationAddSheet({super.key});

  @override
  State<CaptainLocationAddSheet> createState() => _CaptainLocationAddSheetState();
}

class _CaptainLocationAddSheetState extends State<CaptainLocationAddSheet> {
  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    // Load existing location if available
    if (_createCaptainRegisterCubit.placemark != null) {
      _controller.text = 
          "${_createCaptainRegisterCubit.placemark?.locality}, ${_createCaptainRegisterCubit.placemark?.subLocality}, ${_createCaptainRegisterCubit.placemark?.thoroughfare}, ${_createCaptainRegisterCubit.placemark?.country}";
    }
    
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken.isNotEmpty) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    if (_controller.text.length > 2) {
      getSuggestion(_controller.text);
    } else {
      setState(() {
        _placeList = [];
      });
    }
  }

  void getSuggestion(String input) async {
    const String PLACES_API_KEY = AppConstants.googleMapApiKey;

    try {
      setState(() {
        _isLoading = true;
      });
      
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
      
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      
      if (kDebugMode) {
        print('🔍 Captain Location Search - Status: ${data['status']}');
        print('🔍 Found ${data['predictions']?.length ?? 0} suggestions');
      }
      
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'] ?? [];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print('❌ Error in getSuggestion: ${e.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void getPlaceDetails(String placeId, String placeDescription) async {
    const String PLACES_API_KEY = AppConstants.googleMapApiKey;

    try {
      setState(() {
        _isLoading = true;
      });
      
      // Show loading feedback
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
                Text("Setting location..."),
              ],
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
      
      String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
      String request = '$baseURL?place_id=$placeId&key=$PLACES_API_KEY';

      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var result = data['result'];
        var geometry = result['geometry'];
        var location = geometry['location'];
        double latitude = location['lat'];
        double longitude = location['lng'];

        if (kDebugMode) {
          print("✅ Captain Location Selected: $placeDescription");
          print("📍 Coordinates: $latitude, $longitude");
        }

        // Get placemark for the location
        List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          latitude, 
          longitude
        );
        
        // Save to cubit
        _createCaptainRegisterCubit.locationData = Position(
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        
        _createCaptainRegisterCubit.placemark = placemarks.first;
        _createCaptainRegisterCubit.emit(CreateCaptainRegisterLoaded());
        
        print("✅ Location saved to cubit");
        
        // Show success and close
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("✓ Location set: ${placemarks.first.locality}, ${placemarks.first.country}"),
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.primaryDark,
            ),
          );
          
          Navigator.pop(context);
        }
        
        setState(() {
          _placeList = [];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      print('❌ Error in getPlaceDetails: ${e.toString()}');
      
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to set location. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        border: Border(
          top: BorderSide(color: AppColors.dialogeColor, width: 1.5),
        ),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              const AppTextStyle(
                text: "Choose Location",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withOpacity(0.37),
                    shape: BoxShape.circle,
                  ),
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
          const SizedBox(height: 21),
          
          // Search field
          LocationSearchField(
            hintText: "Search location",
            controller: _controller,
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.whiteColor,
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: AppColors.whiteColor,
                    ),
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _placeList = [];
                      });
                    },
                  )
                : null,
          ),
          const SizedBox(height: 14),
          
          // Hint text
          if (_placeList.isEmpty && _controller.text.isEmpty)
            Row(
              children: [
                SvgPicture.asset(AppImages.locationMarker),
                const AppTextStyle(
                  text: "  Search for your location",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.redColor,
                )
              ],
            ),
          
          const SizedBox(height: 14),
          
          // Loading indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(
                color: AppColors.primaryDark,
              ),
            ),
          
          // Suggestions list
          Expanded(
            child: _placeList.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print('🔍 Captain selected: ${_placeList[index]["description"]}');
                          getPlaceDetails(
                            _placeList[index]["place_id"],
                            _placeList[index]["description"],
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: AppColors.secContainerColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.primaryDark,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _placeList[index]["description"],
                                  style: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.whiteColor,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : !_isLoading && _controller.text.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 64,
                              color: AppColors.whiteColor.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            AppTextStyle(
                              text: "Start typing to search",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor.withOpacity(0.5),
                            ),
                          ],
                        ),
                      )
                    : !_isLoading
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: AppColors.whiteColor.withOpacity(0.3),
                                ),
                                const SizedBox(height: 16),
                                AppTextStyle(
                                  text: "No locations found",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor.withOpacity(0.5),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

final CreateCaptainRegisterCubit _createCaptainRegisterCubit = 
    Di().sl<CreateCaptainRegisterCubit>();