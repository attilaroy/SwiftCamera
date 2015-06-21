//
//  ViewController.swift
//  SwiftCameraApp
//
//  Created by Attila Roy on 21/06/15.
//  Copyright (c) 2015 Attila Roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonActionTakePicture(sender: AnyObject) {
        
        // fetch image from image picker
        ImagePickerManager.sharedManager.presentImagePicker(self) { (image, source) -> () in
            self.imageView.image = image
        }
        
    }
}

