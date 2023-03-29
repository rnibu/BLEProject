import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      //GMSPlacesClient.provideAPIKey("AIzaSyCY4-GJep_ewH6gaRDrBETyOyBJJVMGLSc")
      GMSServices.provideAPIKey("AIzaSyCY4-GJep_ewH6gaRDrBETyOyBJJVMGLSc")
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
