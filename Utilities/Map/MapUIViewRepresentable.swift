//
//  MapUIViewRepresentable.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 6/1/21.
//

import SwiftUI
import MapKit


struct MapViewRepresentable: UIViewRepresentable {
    let locationManager = CLLocationManager()
    let cameraItems: [Cameras]
//    var cameraAnnotations: [MKAnnotation]
    
    private func cameraAnnotated(with cameras: Cameras) -> MKAnnotation {
        
            let location = MKPointAnnotation()
        location.coordinate = CLLocationCoordinate2D(latitude: cameras.location.latitude, longitude: cameras.location.longitude)
        
        return location
//        cameraAnnotations.append(MKAnnotation())
//        guard let favouriteList = trafficCameras.trafficCameras?.items[0].cameras else {
//            return nil
//        }
//        return favouriteList.first { camera.id == $0.id}
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
//        let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        
//        ForEach(cameraItems){
//            cameraItems in
            
//            if let
        let cameraAnnotationItem = cameraAnnotated(with: cameraItems[0])
//                cameraAnnotations.append(cameraAnnotationItem)
            view.addAnnotation(cameraAnnotationItem)
            
            
//            if let cameras = camerasFavourited(with: camerasInList){
//                TrafficCameraRowView(cameraItem: cameras, isAddedToFavouritelist: favouriteList.isAddedToFavouritelist(camera: cameras.camera)).padding(.vertical)
//            } else {
//                Text(camerasInList.id)
//            }
            
//        }
//        view.addAnnotations([MKAnnotation])
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            view.setRegion(region, animated: true)
        }
    }
    
}
