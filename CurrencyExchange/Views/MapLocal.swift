//
//  Map.swift
//  CurrencyExchange
//
//  Created by Artem Manakov on 15.04.2023.
//

import SwiftUI
import MapKit

struct MapLocal: View {
    @StateObject var vm = MapLocalViewModel()
    var body: some View {
        VStack {
            if !vm.bankLocations.isEmpty {
                MapView(initialLocation: vm.initialLocation, bankLocations: vm.bankLocations)
                    .edgesIgnoringSafeArea(.all)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            vm.updateLocation()
        }
    }
}

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

struct MapLocal_Previews: PreviewProvider {
    static var previews: some View {
        MapLocal()
    }
}
