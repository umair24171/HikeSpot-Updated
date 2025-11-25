import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  static final Connectivity _connectivity = Connectivity();

  /// Check if device has internet connectivity
  /// Returns true if connected to WiFi or Mobile data
  static Future<bool> hasInternetConnection() async {
    try {
      final List<ConnectivityResult> connectivityResults =
          await _connectivity.checkConnectivity();

      // Check if any connection type is active
      bool isConnected = connectivityResults.any(
        (result) =>
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.ethernet
      );

      log('hk-connectivity: ${isConnected ? "Connected" : "Disconnected"} - $connectivityResults');
      return isConnected;
    } catch (e) {
      log('hk-connectivity-error: ${e.toString()}');
      // If error checking connectivity, assume connected to avoid blocking user
      return true;
    }
  }

  /// Stream for real-time connectivity changes
  static Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }

  /// Check connectivity and return descriptive message
  static Future<String> getConnectivityStatus() async {
    try {
      final List<ConnectivityResult> results = await _connectivity.checkConnectivity();

      if (results.contains(ConnectivityResult.wifi)) {
        return "Connected via WiFi";
      } else if (results.contains(ConnectivityResult.mobile)) {
        return "Connected via Mobile Data";
      } else if (results.contains(ConnectivityResult.ethernet)) {
        return "Connected via Ethernet";
      } else {
        return "No internet connection";
      }
    } catch (e) {
      return "Unable to check connection";
    }
  }
}
