//
//  ViewController.swift
//  GCDDemo
//
//  Created by Carlos Wilson on 31/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sum = 0
        var counter = 0
        DispatchQueue.global(qos: .utility).async {
            for i in 1...10000000 {
                sum = sum + i
            }
            print("Huge sum: \(sum)");
            
            DispatchQueue.main.async {
                self.messageLabel.text = "COMPLETED! + \(sum)"
            }
        }
        
        let group = DispatchGroup()
        let globalQueue = DispatchQueue.global(qos: .userInteractive)
        
        globalQueue.async {
            DispatchQueue.global(qos: .userInteractive).async(group: group) {
                counter = counter + 1
                let randomPrepTime = UInt32.random(in: 1...5)
                sleep(randomPrepTime)
                print("Task #1")
            }
            DispatchQueue.global(qos: .userInteractive).async(group: group) {
                counter = counter + 1
                print("Task #2")
            }
            DispatchQueue.global(qos: .userInteractive).async(group: group) {
                counter = counter + 1
                print("Task #3")
            }
            DispatchQueue.global(qos: .userInteractive).async(group: group) {
                counter = counter + 1
                print("Task #4")
            }
            
            group.notify(queue: DispatchQueue.global()) {
                print("--------> \(counter)")
            }
        }
        
        
        messageLabel.text = "COMPLETED! + \(sum)"
    }
}

