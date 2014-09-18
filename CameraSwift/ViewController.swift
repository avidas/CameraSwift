//
//  ViewController.swift
//  CameraSwift
//
//  Created by Das, Ananya on 9/17/14.
//  Copyright (c) 2014 Das, Ananya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIAlertViewDelegate {
    
    var imagePicker : UIImagePickerController? = nil
    var actionSheet : UIActionSheet? = nil
    @IBOutlet var captureImage: UIImageView!

    @IBAction func captureImage(sender: AnyObject) {
        actionSheet = UIActionSheet(title: "UploadImage", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Library Image","Camera Image")
        actionSheet?.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        //why 1 and not 0 as in objective C
        if (buttonIndex==1) {
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)) {
                imagePicker = UIImagePickerController()
                imagePicker?.delegate = self
                imagePicker?.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                // need to guarantee that never nil
                self.presentViewController(imagePicker!, animated:true, completion: nil)
            }
        }
        else if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
            imagePicker?.sourceType = UIImagePickerControllerSourceType.Camera
            // need to guarantee that never nil
            self.presentViewController(imagePicker!, animated:true, completion: nil)
        }
        else {
            println("\(buttonIndex)")
            var alert : UIAlertView = UIAlertView(title: "Error accessing Camera", message: "Device does not support camera", delegate: self, cancelButtonTitle: "Dismiss")
            alert.show()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image : UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        captureImage.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

