//
//  ToDoViewModel.swift
//  ToDoList
//
//  Created by Steve on 11/5/22.
//

import Foundation
import SwiftUI

class ToDosViewModel: ObservableObject {
    @Published var toDos: [ToDo] = []
    @Published var completed: Bool = false
    
    init() {
            loadData()
    }
    // MARK - UPDATE THE VIEW WITHOUT HAVING TO CHANGE SCREENS
    // to update view by clicking on the checkbox
    // 1. create new toDo item
    // 2. toggle the isCompleted
    // 3. replace the current toDo item with the new toDo item
    // 4. save the data
    func toggleCompleted(toDo: ToDo) {
        //Make sure the toDo exists
        guard toDo.id != nil else {return}
        // set newToDo to the toDo that was selected
        var newToDo = toDo
        // Toggle isCompleted
        newToDo.isCompleted.toggle()
        // Find the ID for ToDo in the array of todos, then update the element at that index with the data at newToDo
        if let index = toDos.firstIndex(where: {$0.id == newToDo.id}) {toDos[index] = newToDo}
        saveData()
    }
        
    func saveToDo(toDo: ToDo) {
        //TODO: if new, append to toDoVm.todos else update the toDo that was passed in from the List
        if toDo.id == nil {
            var newToDo = toDo
            newToDo.id = UUID().uuidString
            toDos.append(newToDo)
        } else {
            if let index = toDos.firstIndex(where: {$0.id == toDo.id}) {toDos[index] = toDo }
        }
        saveData()
    }

    func deleteToDo(indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
        saveData()
        
    }
    func moveToDo(fromOffsets: IndexSet,toOffset:Int) {
        toDos.move(fromOffsets: fromOffsets, toOffset: toOffset)
        saveData()
        
    }

    func saveData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        let data = try? JSONEncoder().encode(toDos)
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    func loadData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        guard let data = try? Data(contentsOf: path) else {return}
        do {
            toDos = try JSONDecoder().decode(Array<ToDo>.self, from: data)
        } catch {
            print ("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    
    // To purge data
    func purgeData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        let data = try? JSONEncoder().encode("")
        do {
            try data?.write(to: path)
        } catch {
            print ("😡 ERROR: Could not purge data \(error.localizedDescription)")
        }
    }
}
