//
//  GoogleMapUIViewRepresentable.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 20/1/21.
//

import Foundation
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
    
//    init(){
//
//    }
    
    private func cameraGCheckPoint(with cameras: [Cameras]) -> [GMSMarker] {
        var cameraAnnotations: [GMSMarker] = []
        
        for cameras in cameras {
            
//            let location = MKPointAnnotation()
//        location.coordinate = CLLocationCoordinate2D(latitude: cameras.location.latitude, longitude: cameras.location.longitude)
            
            cameraAnnotations.append(cameras.cameraGoogleCheckPoint)
            
        }
        
        return cameraAnnotations

    }
    
   func makeCoordinator() -> Coordinator {
//       return Coordinator(
//            owner: self)
    return Coordinator(
         self)
      }
     
     func makeUIView(context: Self.Context) -> GMSMapView {
//         let camera = GMSCameraPosition.camera(withLatitude: 1.290270, longitude: 103.851959, zoom: 3.0)
//         let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//         return mapView
//        [self.view layoutIfNeeded];
        
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude, zoom: zoom)
        
             let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
//             let mapView = GMSMapView.map(withFrame: CGRect.zero)
        
        mapView.delegate = context.coordinator
//        mapView.delegate = GMapCoordinator(self)
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
            
//            let cameraGCheckPointItems = cameraGCheckPoint(with: cameraItems)
            
            DispatchQueue.main.async {
                view.clear()
                for gCheckpoint in cameraItems {
                    let newMarker: GMSMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: gCheckpoint.location.latitude, longitude: gCheckpoint.location.longitude ))
//                    newMarker.position = CLLocationCoordinate2D(latitude: gCheckpoint.location.latitude, longitude: gCheckpoint.location.longitude )
//                    newMarker.title = gCheckpoint.id
                    newMarker.title = gCheckpoint.id
                    newMarker.snippet = gCheckpoint.image
                    newMarker.map = view
//                    gCheckpoint.position = gCheckpoint.coordinate
//                    gCheckpoint.position
                    
                }
            }
//            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
//            let region = MKCoordinateRegion(center: location, span: span)
//            view.setRegion(region, animated: true)
        }
        
//        view.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
      
         
     }
    
//    class Coordinator: NSObject, GMSMapViewDelegate, ObservableObject {
//
//            let owner: GoogleMapViewRepresentable
//
//            init(
//                owner: GoogleMapViewRepresentable
//            ) {
//
//                self.owner = owner
//
//
//            }
//
//            func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//
//                print("A marker has been touched")
//
//
//                return true
//
//            }
//
//        }
    
    
//}

//Coordinator name matters since protocol uses fixed naming convention
    
final class Coordinator: NSObject, GMSMapViewDelegate, ObservableObject {
    // 1.
    var parent: GoogleMapViewRepresentable

    init(_ parent: GoogleMapViewRepresentable) {
        self.parent = parent
    }

    deinit {
        print("deinit: GMapCoordinator")
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        print("A marker has been touched")
         return false
     }
    

    // 2.
//    func mapView(_ mapView: GMSMapView, didSelect view: MKAnnotationView) {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
    
//        view.canShowCallout = true
        
        
            print("mapView: GoogleMap didTapInfoWindowOf")
        
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
    
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = marker.title
        view.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
        lbl2.text = "I am a custom info window."
        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.addSubview(lbl2)
        
        let data = NSData(contentsOf: URL(string: marker.snippet!)!)
        
        let size = CGSize(width: 40.0, height: 40.0)
        
        let calloutImage = UIImage(data:data! as Data)?.scaledToFit(toSize: size)
        
//        view.detailCalloutAccessoryView = UIImageView(image: calloutImage)
        let imageView = UIImageView(image: calloutImage)
//        imageView.center = CGPoint(x: 10, y: 10)
        
//        view.leftCalloutAccessoryView = imageView
        //view.detailCalloutAccessoryView = imageView
        view.addSubview(imageView)

        return view
    }

    // 3.
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let capital = view.annotation as? Checkpoint
//              , let placeName = capital.title else {
//            return }
//        parent.annotationOnTap(capital.cameras)
//    }
    

}
}
