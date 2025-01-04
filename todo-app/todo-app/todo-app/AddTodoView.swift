//
//  AddTodoView.swift
//  todo-app
//
//  Created by stud on 05/11/2024.
//

import SwiftUI
import MapKit

struct LocationAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct AddTodoView: View {
    @Environment(ModelData.self) var modelData
    var todos: [Todo]
    @State private var newTodoTitle = ""
    @State private var newTodoDesc = ""
    @State private var newTodoPriority = ""
    @State private var newTodoDeadline = Date()
    
    @StateObject private var locationManager = LocationManager()
    @State private var selectedLocation: LocationAnnotation?
    
    var body: some View {
        @Bindable var modelData = modelData
        NavigationView{
            ScrollView{
                VStack{
                    TextField("Enter title", text: $newTodoTitle).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
                    TextField("Enter description", text: $newTodoDesc).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
                    TextField("Enter priority", text: $newTodoPriority).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
                    DatePicker("Enter deadline", selection: $newTodoDeadline).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
                    
                    MapView(region: region, onTap: selectLocation, selectedLocation: selectedLocation)
                        .frame(height: 300)
                    
                    
                    Button(action: addTodo){
                        Text("Add To-Do")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
                    
                    Spacer()
                }}
            .navigationTitle("Add To-Do")
        }
    }
    
    private func addTodo(){
        guard !newTodoTitle.isEmpty else { return }
        guard !newTodoDesc.isEmpty else { return }
        guard !newTodoPriority.isEmpty else { return }
        
        let latitude = selectedLocation?.coordinate.latitude ?? 37.7749
        let longitude = selectedLocation?.coordinate.longitude ?? -122.4194
        
        let newTodo = Todo(title: newTodoTitle, desc: newTodoDesc, priority: newTodoPriority, deadline: newTodoDeadline, longitude: Float(longitude), latitude: Float(latitude), isCompleted: false)
        modelData.todos.append(newTodo)
        newTodoTitle = ""
        newTodoDesc = ""
        newTodoPriority = ""
        newTodoDeadline = Date()
    }
    
    var region: MKCoordinateRegion{
        if let userLocation = locationManager.userLocation{
            return MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }else{
            return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    
    func selectLocation(_ coordinate: CLLocationCoordinate2D) {
            selectedLocation = LocationAnnotation(coordinate: coordinate)
        }
}
