//
//  AppDelegate.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 20/1/21.
//


import UIKit
import GoogleMaps
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBltbAqGSl6dYVcINqGTiZ4penFGeQQD18")
//        GMSPlacesClient.provideAPIKey("AIzaSyBltbAqGSl6dYVcINqGTiZ4penFGeQQD18")
        GMSPlacesClient.provideAPIKey("AIzaSyBltbAqGSl6dYVcINqGTiZ4penFGeQQD18")
        print("Your code here")
        return true
    }
}
