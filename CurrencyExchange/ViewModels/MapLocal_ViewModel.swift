//
//  MapLocal_ViewModel.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 28.05.2023.
//

import Foundation
import MapKit

class MapLocalViewModel: ObservableObject {
    @Published var bankLocations: [CLLocation] = []
    @Published var initialLocation = CLLocation(latitude: 50.4501, longitude: 30.5234)
    private let locationService = LocationService()
    
    func fetchBankLocations(latitude: Double, longitude: Double) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=5000&type=bank&key=AIzaSyBioLkNiNlJPNetFNFA1Js1Xp2RIRgpy5k"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(APIResponse.self, from: data)
                let coordinates = results.results.map { CLLocation(latitude: Double($0.geometry.location.lat), longitude: Double($0.geometry.location.lng)) }
                DispatchQueue.main.async {
                    self.bankLocations = coordinates
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func updateLocation() {
        locationService.onLocationUpdate = { [self] location in
            initialLocation = location
            fetchBankLocations(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude)

        }
        locationService.startUpdatingLocation()
    }
}
