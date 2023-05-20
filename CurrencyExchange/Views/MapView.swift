//
//  Map.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 15.04.2023.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    let regionRadius: CLLocationDistance = 600
    var initialLocation: CLLocation
    let bankLocations: [CLLocation]

    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        
        let coordinateRegion = MKCoordinateRegion(
            center: initialLocation.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        for location in bankLocations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            mapView.addAnnotation(annotation)
        }
        
        let button = MKUserTrackingButton(mapView: mapView)
        mapView.addSubview(button)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)
                renderer.strokeColor = UIColor.red
                renderer.fillColor = UIColor.red.withAlphaComponent(0.3)
                return renderer
            } else {
                return MKOverlayRenderer(overlay: overlay)
            }
        }
    }
}


struct MapLocal: View {
    @State var bankLocations: [CLLocation] = []
    @State var initialLocation = CLLocation(latitude: 50.4501, longitude: 30.5234)
    private let locationService = LocationService()


    var body: some View {
        VStack {
            if !bankLocations.isEmpty {
                MapView(initialLocation: initialLocation, bankLocations: bankLocations)
                    .edgesIgnoringSafeArea(.all)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            updateLocation()
        }
    }
    
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
    
    private func updateLocation() {
        locationService.onLocationUpdate = { location in
            initialLocation = location
            fetchBankLocations(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude)

        }
        locationService.startUpdatingLocation()
    }
}

struct MapLocal_Previews: PreviewProvider {
    static var previews: some View {
        MapLocal()
    }
}
