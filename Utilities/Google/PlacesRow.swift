//
//  PlacesRow.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 31/1/21.
//

import SwiftUI
import GooglePlaces

struct PlaceRow: View {
    // 1
    var place: GMSPlace
    
    var body: some View {
        HStack {
            // 2
            Text(place.name ?? "")
                .foregroundColor(.white)
            Spacer()
        }
    }
}
