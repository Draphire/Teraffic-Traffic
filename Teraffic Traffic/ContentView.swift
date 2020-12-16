//
//  ContentView.swift
//  Teraffic Traffic
//
//  Created by WeeLiang Ng on 2/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedCamera: Cameras?
    @State var selection: String = "summary"
    
    var body: some View {
        TrafficSummaryView()
            .tabItem {
                VStack {
                    Image(systemName: "chart.bar")
                    Text("Summary")
                }
            }
            .tag("summary")
//        Text("Hello, world!")
//            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
