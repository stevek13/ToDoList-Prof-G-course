//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Steve on 11/2/22.
// https://www.youtube.com/watch?v=3KXE9tbd7ZU&list=PL9VJ9OpT-IPSM6dFSwQCIl409gNBsqKTe&index=64
import SwiftUI

@main
struct ToDoListApp: App {
    
    @StateObject var toDosVM = ToDosViewModel()
    
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .environmentObject(toDosVM)
        }
    }
}
