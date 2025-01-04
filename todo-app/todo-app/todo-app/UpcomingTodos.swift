//
//  UpcomingTodos.swift
//  todo-app
//
//  Created by stud on 03/12/2024.
//

import SwiftUI

struct UpcomingTodos: View {
    @Environment(ModelData.self) var modelData
    var todos: [Todo]
    var closestTodos: [Todo] {
        todos.filter{$0.deadline > Date() && $0.isCompleted == false}.sorted{$0.deadline < $1.deadline}.prefix(5).map{$0}
    }
    
    var body: some View {
        @Bindable var modelData = modelData
        
        NavigationStack{
            List{
                ForEach(closestTodos){ todo in
                    NavigationLink(destination: TodoDetailsView(todo: todo)) {
                        HStack{
                            Text(todo.title)
                                .strikethrough(todo.isCompleted, color:.gray)
                            Spacer()
                            Image(systemName: "checkmark.circle.fill").foregroundColor(todo.isCompleted ? .green : .gray).onTapGesture {
                                if let index = todos.firstIndex(where: { $0.id == todo.id}){
                                    modelData.todos[index].isCompleted.toggle()
                                }
                            }
                            
                        }
                        .contentShape(Rectangle())
                    }
                    
                    
                }
            }
            .navigationTitle("Upcoming todos")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddTodoView(todos: todos)) {
                        Image(systemName: "plus").font(.title)
                    }
                }
            }
            .navigationBarTitleDisplayMode (.inline)
        }
    }
}


