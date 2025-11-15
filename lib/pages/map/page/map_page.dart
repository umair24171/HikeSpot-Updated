import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/pages/home/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:hikespot/pages/map/bloc/cubit/map_controller_cubit.dart';

import '../../../utils/app_colors.dart';

@RoutePage()
class MapPage extends StatelessWidget {
  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _mapControllerCubit,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
                fortyFiveDegreeImageryEnabled: true,
                buildingsEnabled: true,
                markers: _mapControllerCubit.getMarkers(),
                style: _googleMapCubit.mapStyle,
                polylines: _mapControllerCubit.getPolyline(),
                initialCameraPosition: CameraPosition(
                    target: _googleMapCubit.cameraPosition, zoom: 15),
                onMapCreated: _onMapCreated,
                onCameraMove: _onCameraMove,
              ),
               Positioned(
                top: 20,
                // right: 20,
                left: 20,
                 child: SafeArea(
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                        color: AppColors.primaryDark.withOpacity(0.37),
                        shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () {
                        AutoRouter.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.whiteColor),
                    ),
                  ),
                               ),
               ),
            ],
          ),
        );
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapCubit.mapController.complete(controller);
    controller.setMapStyle(_googleMapCubit.mapStyle);
    _googleMapCubit.customInfoWindowController.googleMapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _mapControllerCubit.updatePointerMarker(position);
    // _googleMapCubit.customInfoWindowController.hideInfoWindow!();
  }

  final GoogleMapCubit _googleMapCubit = Di().sl<GoogleMapCubit>();
  final MapControllerCubit _mapControllerCubit = Di().sl<MapControllerCubit>();
}
