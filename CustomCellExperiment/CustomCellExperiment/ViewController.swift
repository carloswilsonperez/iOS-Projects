//
//  ViewController.swift
//  CustomCellExperiment
//
//  Created by Carlos Wilson on 23/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskService.shared.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the cell from reuse pool
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTaskCell
        
        // Get the task for the given index path
        let currentTask = TaskService.shared.getTask(index: indexPath.row)
        
        // Update the custom cell based on the task
        cell.update(task: currentTask)
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

