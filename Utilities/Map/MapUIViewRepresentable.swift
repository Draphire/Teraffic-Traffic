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
    
    // 1.
    var annotationOnTap: (_ title: String) -> Void
    
    private func cameraAnnotated(with cameras: Cameras) -> MKAnnotation {
        
//            let location = MKPointAnnotation()
//        location.coordinate = CLLocationCoordinate2D(latitude: cameras.location.latitude, longitude: cameras.location.longitude)
        
        return cameras.cameraCheckPoint
        
    }
    
    private func cameraAnnotated(with cameras: [Cameras]) -> [MKAnnotation] {
        var cameraAnnotations: [MKAnnotation] = []
        
        for cameras in cameras {
            
//            let location = MKPointAnnotation()
//        location.coordinate = CLLocationCoordinate2D(latitude: cameras.location.latitude, longitude: cameras.location.longitude)
            
            cameraAnnotations.append(cameras.cameraCheckPoint)
            
        }
        
        return cameraAnnotations

    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true

        let cameraAnnotationItem = cameraAnnotated(with: cameraItems)

        view.addAnnotations(cameraAnnotationItem)
            
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
    
    func makeCoordinator() -> MapCoordinator {
           MapCoordinator(self)
       }
    

    
}

final class MapCoordinator: NSObject, MKMapViewDelegate {
    // 1.
    var parent: MapViewRepresentable

    init(_ parent: MapViewRepresentable) {
        self.parent = parent
    }

    deinit {
        print("deinit: MapCoordinator")
    }
    // 2.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.canShowCallout = true

        let btn = UIButton(type: .detailDisclosure)
        view.rightCalloutAccessoryView = btn
    }

    // 3.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Checkpoint, let placeName = capital.title else {
            return }
        parent.annotationOnTap(placeName)
    }

}
