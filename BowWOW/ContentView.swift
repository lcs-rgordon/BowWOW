//
//  ContentView.swift
//  BowWOW
//
//  Created by Russell Gordon on 2020-11-24.
//

// Dog CEO API
// https://dog.ceo/dog-api/

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("example")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Spacer()
            }
            .navigationTitle("Bow WOW")
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
