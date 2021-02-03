//
//  GoogleMapUIViewRepresentable.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 20/1/21.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct GoogleMapViewRepresentable: UIViewRepresentable {
    let locationManager = LocationManager()
    private let zoom: Float = 15.0
//    let cameraItems: [Cameras]
//    private let zoom: Float = 15.0
     
     func makeUIView(context: Self.Context) -> GMSMapView {
//         let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//         let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//         return mapView
//        [self.view layoutIfNeeded];
        
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        
             let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
             return mapView
     }
     
     func updateUIView(_ view: GMSMapView, context: Context) {
//        [self.view, layoutIfNeeded];
//        view.layoutIfNeeded()
//        view.myLocation
//        view.mapType = GMSMapView.
        view.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
      
         
     }
}
