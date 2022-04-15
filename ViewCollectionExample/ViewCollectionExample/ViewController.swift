//
//  ViewController.swift
//  ViewCollectionExample
//
//  Created by Carlos Wilson on 17/10/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var photos = [1, 2, 3, 4,]
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionView2: UIButton!

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.labelPath.text = "\(indexPath.row)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("------------------------")
        print(indexPath.row)
        cell.backgroundColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self
    }
}

