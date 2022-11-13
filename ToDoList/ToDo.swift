//
//  ToDo.swift
//  ToDoList
//
//  Created by Steve on 11/5/22.
//

import Foundation

struct ToDo: Identifiable, Codable {
    var id: String?
    var item = ""
    var reminderIsOn = false
    var dueDate = Date.now + (60*60*24)  // set due date to the next day
    var Notes = ""
    var isCompleted = false
    var newToDo = ""
}
