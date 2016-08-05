//
//  shareViewController.swift
//  ACFinalAssessment_Q5
//
//  Created by 張智涵 on 2016/8/5.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit

class shareViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailScroll: UIScrollView!
    @IBOutlet weak var detailLabel: UILabel!
    
    var delegate:MyProtocol?
    var detailArr:localData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailScroll.delegate = self
        self.detailScroll.maximumZoomScale = 2.0
        self.detailScroll.minimumZoomScale = 0.5
        self.detailLabel.text = detailArr.Content
        self.detailImageView.image = UIImage(data: NSData(contentsOfFile: detailArr.Pic)!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.detailImageView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func shareAction(sender: AnyObject) {
        let sharedText = detailLabel.text
        let sharedImage: UIImage = detailImageView.image!
        
        let shareItems:[AnyObject] = [sharedImage, sharedText!]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
        self.presentViewController(activityViewController, animated: true, completion: nil)


    }

}
