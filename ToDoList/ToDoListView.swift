//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Steve on 11/2/22.
//
// https://www.youtube.com/watch?v=KMtdBgHwvGY&list=PL9VJ9OpT-IPSM6dFSwQCIl409gNBsqKTe&index=60
import SwiftUI

struct ToDoListView: View {
    @State private var sheetIsPresented = false
    @EnvironmentObject var toDosVM: ToDosViewModel

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDosVM.toDos) { toDo in
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDosVM.toggleCompleted(toDo: toDo)
                            }
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                                Text(toDo.item)
                        }
                    }
                    .font(.title2)
                }
               
                // Shorthand calls to .onDelete and .onMove here
                .onDelete(perform: toDosVM.deleteToDo)
                .onMove(perform: toDosVM.moveToDo)
                
// Traditional calls below
//                .onDelete { indexSet in
//                    toDosVM.delete(indexSet: indexSet)
//                }
//                .onMove(perform: { fromOffsets, toOffset in
//                    toDosVM.move(fromOffsets: fromOffsets, toOffset: toOffset)
//                })

            }
            
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                   
                
            }
            .sheet(isPresented: $sheetIsPresented) {
                
                // Set value if entering new todo
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView().environmentObject(ToDosViewModel())
    }
}


