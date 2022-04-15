//
//  SentMemesCollectionTableViewController.swift
//  ProtoMeme
//
//  Created by Carlos Wilson on 12/12/20.
//  Copyright © 2020 Carlos Wilson. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties

    private var itemsPerRow: Int!
    
    // Default insets for Portrait mode
    private var sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title for ViewController
        title = "Sent Memes"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        // This one is important, to allow updating the grid
        myCollectionView.collectionViewLayout.invalidateLayout()
        
        collectionView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
    }
    
    // MARK: FlowLayout delegate methods
    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Defining grid properties & size for meme items
        let viewWidth = view.frame.size.width
        var widthPerItem = 100
        
        if viewWidth >= 500 {
            widthPerItem = 150
        }
        
        self.itemsPerRow = Int(view.frame.size.width / CGFloat(widthPerItem))
        
        let availableMargin = viewWidth - CGFloat((itemsPerRow * widthPerItem))
        
        let marginPerItem = availableMargin / CGFloat((2 * self.itemsPerRow))
        
        sectionInsets = UIEdgeInsets(top: 20.0, left: marginPerItem, bottom: 50.0, right: marginPerItem)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
      }
      
      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
      }
      
      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
      }
    
    // MARK: Collection View Data Source methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the cell image scaling mode
        // cell.memeImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        // Set the cell's image source
        cell.memeImageView?.image = meme.memedImage
        
        // Return our custom cell instance
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}

