//
//  SentMemesTableViewController.swift
//  ProtoMeme
//
//  Created by Carlos Wilson on 12/09/20.
//  Copyright © 2020 Carlos Wilson. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    @IBOutlet weak var createMeme: UIBarButtonItem!
    
    // MARK: Properties

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    // MARK: Lifecycle methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // reload table view
        tableView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: TableView delegate methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meme = self.memes[indexPath.row]
        
        // Dequeuing a cell instance
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        // Assigning values to cell properties
        cell.topMemeText.text = "\(meme.topText)"
        cell.bottomMemeText.text = "\(meme.bottomText)"
        cell.memeImage.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

            //Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]

        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
}
