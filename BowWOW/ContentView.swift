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
        .onAppear() {
            fetchMoreCuteness()
        }
    }
    
    // Get a random pooch pic!
    func fetchMoreCuteness() {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let doggieData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: doggieData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of Swift native data types
            if let decodedDoggieData = try? JSONDecoder().decode(RandomDog.self, from: doggieData) {

                print("Doggie data decoded from JSON successfully")
                print("URL is: \(decodedDoggieData.message)")

            } else {

                print("Invalid response from server.")
            }
            
        }.resume()

        
    }
        
}

struct RandomDog: Codable {
    var message: String
    var status: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
