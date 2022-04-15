//
//  TaskService.swift
//  CustomCellExperiment
//
//  Created by Carlos Wilson on 23/09/21.
//

import Foundation

class TaskService {
    static let shared = TaskService()
    private var tasks: [Task] = [
        Task(title: "Sacar la basura", date: "date"),
        Task(title: "Pagar el recibo de luz", date: "date")
    ]
    
    private init() {}
    
    // Create task
    func create(task: Task) {
        tasks.append(task)
    }
    
    // Get number of tasks
    func getCount() -> Int {
        return tasks.count
    }
    
    // Get a specific task
    func getTask(index: Int) -> Task {
        return tasks[index]
    }
    
    // Get the list of tasks
    func getTasks() -> [Task] {
        return tasks
    }
    
    // Delete a task
    func delete(index: Int) {
        tasks.remove(at: index)
    }
}
