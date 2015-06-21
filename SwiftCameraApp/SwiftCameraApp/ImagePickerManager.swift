//
//  ImagePickerManager.swift
//  ImagePicker
//
//  Created by Attila Roy on 10/03/15.

import Foundation
import UIKit

typealias ImagePickerManagerCallback = (image: UIImage, source: UIImagePickerControllerSourceType) -> ()

class ImagePickerManager: NSObject, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // singleton manager
    class var sharedManager :ImagePickerManager {
        struct Singleton {
            static let instance = ImagePickerManager()
        }
        return Singleton.instance
    }
    
    // the view controller that presents the Image picker
    private var parentViewController: UIViewController?
    
    // completion handler
    private var completionHandler: ImagePickerManagerCallback?
    
    // action sheet for Image Picker
    private let actionSheet = UIActionSheet(title: nil, delegate: nil, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Take Photo", "Choose Existing")
    
    func presentImagePicker(viewController: UIViewController, completionHandler: ImagePickerManagerCallback) -> () {
        
        // save the completion handler
        self.completionHandler = completionHandler
        
        // save the parent view controller
        parentViewController = viewController
        
        // present the action sheet
        actionSheet.delegate = self
        actionSheet.showInView(parentViewController?.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        // get the source type for image picker controller
        var sourceType: UIImagePickerControllerSourceType
        switch actionSheet.buttonTitleAtIndex(buttonIndex) {
        case "Choose Existing": sourceType = .PhotoLibrary
        case "Take Photo": sourceType = .Camera
        default: return
        }
        
        // configure image picker controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        
        // present the image picker controller
        parentViewController?.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        // fire completion handler
        completionHandler?(image: info[UIImagePickerControllerEditedImage] as! UIImage, source: picker.sourceType)
        
        // dismiss the image picker
        dismissImagePicker()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissImagePicker()
    }
    
    func dismissImagePicker() {
        parentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


