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
//        view.image =
        
    
        
        let btn = UIButton(type: .detailDisclosure)
        view.rightCalloutAccessoryView = btn
        
        guard let capital = view.annotation as? Checkpoint, let cameraImage = capital.image else {
            return }
        
//        let cameraImageView = AsyncImage(
//            url : URL(string: cameraImage)!,
//            placeholder: { Text("Loading ...")},
//            image: { Image(uiImage: $0).resizable()}
//        )
        
        //show Image on callout Accessory

//                    let url = NSURL(string: cameraImage)
        
        let data = NSData(contentsOf: URL(string: cameraImage)!)
        
        let size = CGSize(width: 150.0, height: 150.0)
        
        let calloutImage = UIImage(data:data! as Data)?.scaledToFit(toSize: size)
        
//        view.detailCalloutAccessoryView = UIImageView(image: calloutImage)
        let imageView = UIImageView(image: calloutImage)
//        imageView.center = CGPoint(x: 10, y: 10)
        
//        view.leftCalloutAccessoryView = imageView
        view.detailCalloutAccessoryView = imageView
        
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
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Checkpoint, let placeName = capital.title else {
            return }
        parent.annotationOnTap(placeName)
    }
    

}

extension UIImage {

    func scaledToFit(toSize newSize: CGSize) -> UIImage {
        if (size.width < newSize.width && size.height < newSize.height) {
            return copy() as! UIImage
        }

        let widthScale = newSize.width / size.width
        let heightScale = newSize.height / size.height

        let scaleFactor = widthScale < heightScale ? widthScale : heightScale
        let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

        return self.scaled(toSize: scaledSize, in: CGRect(x: 0.0, y: 0.0, width: scaledSize.width, height: scaledSize.height))
    }

    func scaled(toSize newSize: CGSize, in rect: CGRect) -> UIImage {
        if UIScreen.main.scale == 2.0 {
            UIGraphicsBeginImageContextWithOptions(newSize, !hasAlphaChannel, 2.0)
        }
        else {
            UIGraphicsBeginImageContext(newSize)
        }

        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? UIImage()
    }

    var hasAlphaChannel: Bool {
        guard let alpha = cgImage?.alphaInfo else {
            return false
        }
        return alpha == CGImageAlphaInfo.first ||
            alpha == CGImageAlphaInfo.last ||
            alpha == CGImageAlphaInfo.premultipliedFirst ||
            alpha == CGImageAlphaInfo.premultipliedLast
    }
}
