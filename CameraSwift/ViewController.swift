//
//  ViewController.swift
//  CameraSwift
//
//  Created by Das, Ananya on 9/17/14.
//  Copyright (c) 2014 Das, Ananya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UITableViewDataSource {
    
    var imagePicker : UIImagePickerController? = nil
    var actionSheet : UIActionSheet? = nil
    var imagesList : [UIImage] = []
    
    @IBOutlet weak var tbView: UITableView!
    
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
        imagesList.append(image)
        tbView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "photocell"
        var cell: CustomPhotoTableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier) as CustomPhotoTableViewCell
        
        if (imagesList.count > 0) {
            cell.backgroundImageView.image = imagesList[indexPath.row]
        }
        
        return cell
        
    }


}

