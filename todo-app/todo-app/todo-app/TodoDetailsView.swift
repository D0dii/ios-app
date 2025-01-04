//
//  TodoDetailsView.swift
//  todo-app
//
//  Created by stud on 05/11/2024.
//

import SwiftUI
import MapKit

struct TodoDetailsView: View {
    var todo: Todo
    
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: Double(todo.latitude), longitude: Double(todo.longitude))
        }
        
        // Create a LocationAnnotation that conforms to Identifiable
    struct LocationAnnotation: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }
    
    var body: some View {
        Text(todo.title)
        Text(todo.desc)
        Text(todo.priority)
        Text(todo.deadline, style: .date)
        Text(String(todo.latitude))
        Text(String(todo.longitude))
        Map(coordinateRegion: .constant(
                            MKCoordinateRegion(
                                center: coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                        ),
                        annotationItems: [LocationAnnotation(coordinate: coordinate)]) { location in
                            MapPin(coordinate: location.coordinate, tint: .red)
                        }
    }
}


