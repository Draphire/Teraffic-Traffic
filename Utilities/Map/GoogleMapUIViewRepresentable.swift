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
//    let locationManager = LocationManager()
    let locationManager = CLLocationManager()
    private let zoom: Float = 15.0
    
    let cameraItems: [Cameras]
//    let cameraItems: [Cameras]
//    private let zoom: Float = 15.0
     
     func makeUIView(context: Self.Context) -> GMSMapView {
         let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//         let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//         return mapView
//        [self.view layoutIfNeeded];
        
//        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        
             let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
             return mapView
     }
     
     func updateUIView(_ view: GMSMapView, context: Context) {
//        [self.view, layoutIfNeeded];
//        view.layoutIfNeeded()
//        view.myLocation
//        view.mapType = GMSMapView.
        view.isTrafficEnabled = true
        
        let status = CLLocationManager.authorizationStatus()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            
            view.animate(toLocation:location
            )
//            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
//            let region = MKCoordinateRegion(center: location, span: span)
//            view.setRegion(region, animated: true)
        }
        
//        view.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
      
         
     }
    
}


final class GMapCoordinator: NSObject, GMSMapViewDelegate {
    // 1.
    var parent: GoogleMapViewRepresentable

    init(_ parent: GoogleMapViewRepresentable) {
        self.parent = parent
    }

    deinit {
        print("deinit: GMapCoordinator")
    }
    // 2.
//    func mapView(_ mapView: GMSMapView, didSelect view: MKAnnotationView) {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
    
//        view.canShowCallout = true
        
    
        
//        let btn = UIButton(type: .detailDisclosure)
//        view.rightCalloutAccessoryView = btn
        
//        guard let capital = view.annotation as? Checkpoint, let cameraImage = capital.image else {
//            return }
        
        //show Image on callout Accessory

//                    let url = NSURL(string: cameraImage)
        
//        let data = NSData(contentsOf: URL(string: cameraImage)!)
        
//        let size = CGSize(width: 150.0, height: 150.0)
//
//        let calloutImage = UIImage(data:data! as Data)?.scaledToFit(toSize: size)
        
        
//        let imageView = UIImageView(image: calloutImage)
//        view.detailCalloutAccessoryView = imageView
        
//        let loader = ImageLoader(url:  URL(string: cameraImage)!, cache: Environment(\.imageCache).wrappedValue)
//
//        if loader.image != nil {
//            view.image = loader.image
//
//
//            view.rightCalloutAccessoryView = UIImageView(image: loader.image)
//        }
        
//        view.detailCalloutAccessoryView =UIImageView(image: loader.image)
        
//        view.image = rightCalloutAccessoryView(cameraImageView) .rightCalloutAccessoryView = cameraImageView
      
    }

    // 3.
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let capital = view.annotation as? Checkpoint
//              , let placeName = capital.title else {
//            return }
//        parent.annotationOnTap(capital.cameras)
//    }
    

}



