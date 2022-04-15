//
//  ViewController.swift
//  ProtoMeme
//
//  Created by Carlos Wilson on 12/12/20.
//  Copyright © 2020 Carlos Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Properties
    // Declaring outlets for the UI views
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topMemeText: UITextField!
    @IBOutlet weak var bottomMemeText: UITextField!
    @IBOutlet weak var appBar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var SentMemesTableVC: SentMemesTableViewController!
    var SentMemesCollectionVC: SentMemesCollectionViewController!
    
    var appDelegateInstance: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        // When working with simulator or old devices, check for the presence of camera
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Disable the Share button on Toolbar
        shareButton.isEnabled = false
        
        // Subscribe to keyboard notifications
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the initial text and properties for textFields
        setTextFieldProperties()
        setDefaultValues()
    }
    
    // MARK: Utility methods
    
    /**
    Method to configure text field properties and text

    - Parameter textField: A text field instance
    */
    func configureMemeTextField(textField: UITextField) {
        // Dictionary for text atributes
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
           NSAttributedString.Key.strokeColor: UIColor.black,
           NSAttributedString.Key.foregroundColor: UIColor.white,
           NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
           NSAttributedString.Key.strokeWidth:  -3.5
        ]
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.autocapitalizationType = .allCharacters
        textField.borderStyle = UITextField.BorderStyle.none
        textField.textAlignment = .center
    }
    
    /**
    Method to ocnfigure initial values for both text fields in the Meme editor
    */
    func setTextFieldProperties() {
        configureMemeTextField(textField: topMemeText)
        configureMemeTextField(textField: bottomMemeText)
    }
    
    /**
    Method to set text fields and UIImage default values
    */
    func setDefaultValues() {
       imagePickerView.image = nil
       topMemeText.text = "TOP"
       bottomMemeText.text = "BOTTOM"
    }
    
    /**
    Method to subscribe to keyboard notifications
    */
    func subscribeToKeyboardNotifications() {
        // keyboardWillShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       
        // keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    /**
    Method to unsubscribe to keyboard notifications
    */
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /**
    Method to get the keyboard size
    */
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    /**
    Method to shift the view's frame up
    */
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomMemeText.isFirstResponder && view.frame.origin.y == 0.0 {
            // Move the view up, above the keyboard by subtracting the height of the keyboard
            view.frame.origin.y -= getKeyboardHeight(notification)
       }
    }
    
    /**
    Method to shift the view's frame down
    */
    @objc func keyboardWillHide(notification: NSNotification) {
       if bottomMemeText.isFirstResponder {
           view.frame.origin.y = 0
       }
    }
    
    /**
     Method of the UIImagePickerControllerDelegate - Runs after finished picking the image
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.contentMode = UIView.ContentMode.scaleAspectFit
            imagePickerView.image = image
        }
        
        // Enable the Share button on Toolbar
        shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    /**
     Method of the UIImagePickerControllerDelegate - Runs after tapping on ´Cancel´
    */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    /**
    Method for picking an image from a generic source

    - Parameter sourceType: Either the camera or the photo library
    */
    func pickAnImage(sourceType: UIImagePickerController.SourceType) {
       let imagePickerController = UIImagePickerController()
       imagePickerController.delegate = self
       imagePickerController.sourceType = sourceType
       present(imagePickerController, animated: true, completion: nil)
   }

    /**
    Action for picking an image from the camera

    - Parameter sender: The view being tapped.
    */
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(sourceType: UIImagePickerController.SourceType.camera)
    }
    
    /**
    Action for picking an image from the photo album

    - Parameter sender: The view being tapped.
    */
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(sourceType: UIImagePickerController.SourceType.photoLibrary)
    }
    
    /**
     Method of the UITextFieldDelegate for hiding keyboard after pressing ´Return´
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    /**
     Method of the UITextFieldDelegate for the behavior when tapping on the textField
    */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if topMemeText.text == "TOP" && topMemeText.isFirstResponder {
            textField.text = ""
            return
         }
        if bottomMemeText.text == "BOTTOM" && bottomMemeText.isFirstResponder {
            textField.text = ""
            return
        }
    }
    
    /**
     Method of the UITextFieldDelegate for the behavior when leaving an empty text field

    - Parameter textField: The text field just edited.
    */
    func textFieldDidEndEditing(_ textField: UITextField) {
        if topMemeText.text == "" {
            textField.text = "TOP"
        }
        if bottomMemeText.text == "" {
           textField.text = "BOTTOM"
       }
    }
        
    /**
    Method to unsubscribe from getting keyboard notifications
    */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    /**
    Method to toggle visibility satus for both Toolbar and Appbar
     
    - Parameter visible: Boolean to indicate visibility state
    */
    func toolBarVisible(visible: Bool){
        bottomToolbar.isHidden = !visible
        appBar.isHidden = !visible
    }
    
    /**
    Generates a memed image from the current state of the UI

    - Returns: A memed image,
    */
    func generateMemedImage() -> UIImage {
        // Hide Toolbar and Navbar to prevent it from being added to the memed image
        toolBarVisible(visible: false)

        // Create the UIImage that combines the Image View and the Textfields
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show Toolbar and Navbar again
        toolBarVisible(visible: true)
        
        return memedImage
    }
    
    /**
    Saves a memed image.

    - Parameter memedImage: The memed image.
    */
    func saveMeme(memedImage: UIImage) {
        if imagePickerView.image != nil && topMemeText.text != nil && bottomMemeText.text != nil
        {
            // Create instance of Meme object
            let meme = Meme(topText: topMemeText.text!,
                            bottomText: bottomMemeText.text!,
                            originalImage: imagePickerView.image!,
                            memedImage: memedImage)
            
            // Add new meme instance to memes array
            self.appDelegateInstance.memes.append(meme)
            
            // Save memed image to the photo album
            UIImageWriteToSavedPhotosAlbum(memedImage, nil, nil, nil)
        }
    }
    
    /**
    Action for the share meme view

    - Parameter sender: The View being tapped
    */
    @IBAction func shareMeme(_ sender: Any) {
        // 1. Generate a memed image
        let memeToShare = generateMemedImage()
        
        // 2. Define an instance of the ActivityViewController and pass the ActivityViewController a memedImage as an activity item
        let activityViewController = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        
        // In the completion handler you can specify methods you would like to be called once an activity, like sharing a meme, has been completed
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.saveMeme(memedImage: memeToShare)
                self.setDefaultValues()
                self.navigationController?.popViewController(animated: true)

                self.dismiss(animated: true, completion: nil)
            }
        }
        
        // 3. Present the ActivityViewController
        present(activityViewController, animated: true, completion: nil)
    }
    
    /**
    Allows the user to cancel the creation of a meme

    - Parameter sender: the view being clicked
    */
    @IBAction func cancelMeme(_ sender: Any) {
        setDefaultValues()
        self.dismiss(animated: true, completion: nil)
    }
}

