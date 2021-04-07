//
//  Teraffic_TrafficApp.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 2/12/20.
//

import SwiftUI

@main
struct Teraffic_TrafficApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

//    var body: some Scene {
        
//        @StateObject var watchlist = WatchlistObservableObject()
//        @StateObject var dailySummary = DailySummaryObservableObject()
        
        @StateObject var trafficCameras = TrafficCamerasObservableObject()
        
        @StateObject var favouriteList = FavouriteListObservableObject()
        
    @StateObject var  cameraSelected = TrafficCameraSelectedObservableObject()
    
    
    @StateObject var trafficDetail = TrafficCameraDetailObservableObject()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                    .environmentObject(favouriteList)
                    .environmentObject(trafficCameras)
                .environmentObject(cameraSelected)
                .environmentObject(trafficDetail)
                    .onAppear {
                        trafficCameras.fetchTrafficCameras()
        }
    }
    }
}
//}
