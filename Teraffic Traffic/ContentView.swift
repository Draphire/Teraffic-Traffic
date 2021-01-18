//
//  ContentView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 2/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedCamera: Cameras?
    @State var selectedAnnotation: Camera?
    @State var selection: String = "summary"
    
    var body: some View {
        TabView(selection: $selection){
            
        
        TrafficSummaryView()
            .tabItem {
                VStack {
                    Image(systemName: "chart.bar")
                    Text("Summary")
                }
            }
            .tag("summary")
            TrafficMapView()
                .tabItem{
                    VStack{
                        Image(systemName:"star.fill")
                        Text("Favourite List")
                    }
                    
                } .tag("trafficmap")
            FavouriteListView()
                .tabItem {
                    VStack{
                        Image(systemName:"star.fill")
                        Text("Favourite List")
                    }
                }
                .tag("favouritelist")
            
          
//        Text("Hello, world!")
//            .padding()
    }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
