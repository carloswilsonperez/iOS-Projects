//
//  ViewController.swift
//  ProtoMeme
//
//  Created by Carlos Wilson on 16/09/20.
//  Copyright © 2020 Carlos Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // Declaring outlets for the UI views
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topMemeText: UITextField!
    @IBOutlet weak var bottomMemeText: UITextField!
    @IBOutlet weak var appBar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // In-memory array of meme instances
    var memes: [Meme] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        // When working with simulator or old devices, check for the presence of camera
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the initial text and properties for textFields
        setTextFieldProperties()
    }
    
    // Utilitary method to configure text field properties and text
    func configureMemeTextField(textField: UITextField, text: String) {
        // Dictionary for text atributes
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
           NSAttributedString.Key.strokeColor: UIColor.black,
           NSAttributedString.Key.foregroundColor: UIColor.white,
           NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
           NSAttributedString.Key.strokeWidth:  -3.5
        ]
        
        textField.text = text
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.autocapitalizationType = .allCharacters
        textField.borderStyle = UITextField.BorderStyle.none
        textField.textAlignment = .center
    }
    
    // Set text properties and text
    func setTextFieldProperties() {
        configureMemeTextField(textField: topMemeText, text: "TOP")
        configureMemeTextField(textField: bottomMemeText, text: "BOTTOM")
    }
    
    // Subscribe to keyboard notifications
    func subscribeToKeyboardNotifications() {
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // Unsubscribe to keyboard notifications
    func unsubscribeFromKeyboardNotifications() {
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Function to get the keyboard size
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    // When the keyboardWillShow notification is received, shift the view's frame up
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomMemeText.isFirstResponder && view.frame.origin.y == 0.0 {
           view.frame.origin.y -= getKeyboardHeight(notification)
       }
    }
    
    // When the keyboardWillHide notification is received, shift the view's frame down
    @objc func keyboardWillHide(notification: NSNotification) {
       if bottomMemeText.isFirstResponder {
           view.frame.origin.y = 0
       }
    }
    
    // Method of the UIImagePickerControllerDelegate - Runs after finished picking the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("You picked a pic!")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.contentMode = UIView.ContentMode.scaleAspectFit
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    // Method of the UIImagePickerControllerDelegate - Runs after tapping on ´Cancel´
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
    
    // Method of the UITextFieldDelegate for hiding keyboard after pressing ´Return´
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    // Method of the UITextFieldDelegate for the behavior when tapping on the textField
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
    Creates a personalized greeting for a recipient.

    - Parameter textField: The text field just edited.
    - Returns: A new string saying hello to `recipient`.
    */
    func textFieldDidEndEditing(_ textField: UITextField) {
        if topMemeText.text == "" {
            textField.text = "TOP"
        }
        if bottomMemeText.text == "" {
           textField.text = "BOTTOM"
       }
    }
        
    // Sign up to be notified when the keyboard appears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func toolBarVisible(visible: Bool){
        bottomToolbar.isHidden = !visible
        appBar.isHidden = !visible
    }
    
    /**
    Generates a memed image from the current state of the UI

    - Returns: A memed image,
    */
    func generateMemedImage() -> UIImage {
        toolBarVisible(visible: false)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
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
            
            // Create instance of meme and save it in the memes array
            let topText = topMemeText.text
            let bottomText = bottomMemeText.text
            let image = imagePickerView.image
            
            let meme = Meme(topText: topText, bottomText: bottomText, originalImage: image, memedImage: memedImage)
            memes.append(meme)
            
            // Save memed image to the photo album
            UIImageWriteToSavedPhotosAlbum(memedImage, nil, nil, nil)
        }
    }
    
    /**
    Function to restore the meme editor fields to its initial values
    */
    func cleanMeme() {
       imagePickerView.image = nil
       topMemeText.text = "TOP"
       bottomMemeText.text = "BOTTOM"
       dismiss(animated: true, completion: nil)
    }
    
    /**
    Action for the share meme view

    - Parameter sender: The View being tapped
    */
    @IBAction func shareMeme(_ sender: Any) {
        let memeToShare = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)

        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                print("Saving meme ...")
                self.saveMeme(memedImage: memeToShare)
                self.cleanMeme()
            }
        }
    }
    
    /**
    Allows the user to cancel the creation of a meme

    - Parameter sender: the view being clicked
    */
    @IBAction func cancelMeme(_ sender: Any) {
        cleanMeme()
    }
}

