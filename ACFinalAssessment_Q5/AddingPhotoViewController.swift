//
//  AddingPhotoViewController.swift
//  ACFinalAssessment_Q5
//
//  Created by 張智涵 on 2016/8/5.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit

protocol MyProtocol {
    func sendDataToPreviousView(Content: String, Pic: UIImage)
}

class AddingPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var mediumPhotoImageView: UIImageView!
    @IBOutlet weak var contentTextField: UITextField!
    
    var delegate:MyProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTextField.delegate = self
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataPassForward() {
        delegate?.sendDataToPreviousView(contentTextField.text!, Pic: mediumPhotoImageView.image!)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func nilInputWarning() {
        let alertController = UIAlertController(title: "Warning", message: "You haven't typed anything yet or taked any photo！", preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Destructive, handler: nil)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        contentTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        contentTextField.resignFirstResponder()
        return true
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("info \(info)")
        let image = info["UIImagePickerControllerOriginalImage"]
        self.mediumPhotoImageView.image = image as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func takePicAction(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBAction func confirmButton(sender: AnyObject) {
        mediumPhotoImageView.image != nil && contentTextField.text != nil ? dataPassForward() : nilInputWarning()
    }

}
