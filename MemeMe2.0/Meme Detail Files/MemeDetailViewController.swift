//
//  MemeDetailViewController.swift
//  ProtoMeme
//
//  Created by Carlos Wilson on 12/12/20.
//  Copyright © 2020 Carlos Wilson. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: Properties

    var meme: Meme!

    // Declaring outlets for the UI views
    @IBOutlet weak var memeImageView: UIImageView!
    
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // According to the MemeMe demo, only memed image is shown.
        memeImageView.image = meme.memedImage
    }
}
