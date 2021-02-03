//
//  TrafficGoogleMapView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 2/2/21.
//

//GoogleMapViewRepresentable()
//    .edgesIgnoringSafeArea(.top)
//    .frame(height: 300)
//PlacesList()

import SwiftUI

struct TrafficGoogleMapView: View{
    
    
    var body: some View {
        
        GoogleMapViewRepresentable()
            .edgesIgnoringSafeArea(.top)
            .frame(height: 300)
        PlacesList()
    
    }
    
}
