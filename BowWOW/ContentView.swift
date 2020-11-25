//
//  ContentView.swift
//  BowWOW
//
//  Created by Russell Gordon on 2020-11-24.
//

// Dog CEO API
// https://dog.ceo/dog-api/

import SwiftUI

enum FetchType {
    case random
    case specific
}

struct ContentView: View {
    
    @State private var dogImage = UIImage()
    
    @State private var breeds: [Breed] = []
    @State private var selectedBreed = 0
    
    var body: some View {
        NavigationView {
            VStack {

                Form {
                    
                    Section {
                        
                        Picker("Breed", selection: $selectedBreed) {
                            List(breeds) { breed in
                                Text(breed.name)
                            }
                        }
                        
                    }
                    
                    Section {
                        
                        Button(action: {
                            fetchMoreCuteness(breed: .specific)
                        }, label: {
                            Text("Fetch selected breed")
                        })
                        // Centre the button
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        
                    }

                    Section {
                        
                        Button(action: {
                            fetchMoreCuteness(breed: .random)
                        }, label: {
                            Text("Surprise me")
                        })
                        // Centre the button
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        
                    }

                    Image(uiImage: dogImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationTitle("Bow WOW!")
        }
        .onAppear() {
            fetchMoreCuteness()
            fetchBreeds()
        }
    }
    
    // Get a random pooch pic!
    func fetchMoreCuteness(breed: FetchType = .random) {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        var url = URL(string: "")
        if breed == .random {
            // Random dog pic endpoint
            url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        } else {
            // Accounts for fact that arrays are zero based and selectedBreed gets set to whatever the id is for the selected item
            // The first breed in the list returned from the spreadsheet had an id of 2
            // So, we subtract 2 from the selectedBreed value
            url = URL(string: "https://dog.ceo/api/breed/\(breeds[selectedBreed - 2].slug)/images/random")!
            
        }
        var request = URLRequest(url: url!)
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
                
                // Now fetch the image at the address we were given
                fetchImage(from: decodedDoggieData.message)

            } else {

                print("Invalid response from server.")
            }
            
        }.resume()
        
    }
    
    // Get the actual image data
    func fetchImage(from address: String) {

        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: address)!
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let imageData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                                    
                // Attempt to create an instance of UIImage using the data from the server
                guard let loadedDog = UIImage(data: imageData) else {
                    
                    // If we could not load the image from the server, show a default image
                    dogImage = UIImage(named: "example")!
                    return
                }
                
                // Set the image loaded from the server so that it shows in the user interface
                dogImage = loadedDog
                
            }
            
        }.resume()
        
    }

    // Get the list of breeds
    func fetchBreeds() {
        
        // 1. Prepare a URLRequest to retrieve our encoded data as JSON
        let url = URL(string: "https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/dogBreeds/list")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Attempt to unwrap the optional data that is returned
            guard let breedsData = data else {
                
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
                
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: breedsData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of breeds
            if let decodedBreedsList = try? JSONDecoder().decode(BreedsSummary.self, from: breedsData) {
                
                print("Breeds list decoded from JSON successfully.")
                
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    
                    // Set the list of breeds
                    breeds = decodedBreedsList.list
                    
                    // Set the selected breed
                    selectedBreed = -1  // No breed will be selected at first
                    
                }
                
            }

        }.resume()
        
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
