//
//  MapView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 28/12/20.
//

import SwiftUI
import MapKit

struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}


struct MapView: View {
    
//    let cameraItem: Cameras
    let cameraItems: [Cameras]
//    let isAddedToFavouritelist: Bool

    
//    @State private var cities: [City] = [
//        City(coordinate: .init(latitude: 40.7128, longitude: 74.0060)),
//        City(coordinate: .init(latitude: 37.7749, longitude: 122.4194)),
//        City(coordinate: .init(latitude: 47.6062, longitude: 122.3321))
//    ]

    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    var locationManager = CLLocationManager()
    func setupManager() {
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestWhenInUseAuthorization()
      locationManager.requestAlwaysAuthorization()
    }


    var body: some View {
        
        if !cameraItems.isEmpty {
        Map(
            coordinateRegion: $region,
            
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: cameraItems) { camera in
            MapPin(
                coordinate: .init(latitude: camera.location.latitude, longitude: camera.location.longitude)
//                ,
//                anchorPoint: CGPoint(x: 0.5, y: 0.5)
            )
//            {
//                Circle()
//                    .stroke(Color.green)
//                    .frame(width: 44, height: 44)
//            }
        }
        }else{
            
                ProgressView()
        
//        if cameraItem != nil {
            
//            Map(coordinateRegion: <#T##Binding<MKCoordinateRegion>#>)
//            Map(coordinateRegion: $region, MapAnnotation() { camera in
//                MapAnnotation(
//                    coordinate: .init(latitude: camera.location.latitude, longitude: camera.location.longitude),
//                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
//                ) {
//                    Circle()
//                        .stroke(Color.green)
//                        .frame(width: 44, height: 44)
//                }
//            }
    }
    }
}
