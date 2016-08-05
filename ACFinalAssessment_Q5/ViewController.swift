//
//  ViewController.swift
//  ACFinalAssessment_Q5
//
//  Created by 張智涵 on 2016/8/5.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyProtocol {

    @IBOutlet weak var tableView: UITableView!
    let customCellIdentifier = "cellIdentifier"
    var dataArr:[localData] = []
    var photoID:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "拍張照吧"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: customCellIdentifier)
        retrieveDatabase()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        retrieveDatabase()
 
    }
    func retrieveDatabase() {
        
        dataArr.removeAll()
        photoID = NSUserDefaults.standardUserDefaults().integerForKey("insertionID")
        if NSUserDefaults.standardUserDefaults().objectForKey("nameOfID0") != nil {
            for photoNum in 0..<photoID {
                let singleData = localData(Id: 0, Pic: "", Content: "")
                singleData.Id = photoNum
                singleData.Content = String(NSUserDefaults.standardUserDefaults().objectForKey("nameOfID\(photoNum)")!)
                singleData.Pic = NSHomeDirectory().stringByAppendingString("/Documents/\(photoNum).jpg")
                dataArr.append(singleData)
            }
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath) as! CustomCell
        cell.customLabel.text = dataArr[indexPath.row].Content
        cell.customImage.image = UIImage(data: NSData(contentsOfFile: dataArr[indexPath.row].Pic)!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.deleteData(dataArr[indexPath.row])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func deleteData(sender: AnyObject) {
//        dataArr.removeObject(sender)
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey("insertionID")
        userDefaults.removeObjectForKey("/Documents/\(photoID).jpg")
        userDefaults.removeObjectForKey("nameOfID\(photoID)")
    
        userDefaults.synchronize()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addPhotoSegue" {
            let vc = segue.destinationViewController as! AddingPhotoViewController
            vc.delegate = self
        }
    }
    
    
    func sendDataToPreviousView(Content: String, Pic: UIImage) {
        
        let image:NSData = UIImageJPEGRepresentation(Pic, 0.5)!
        let imagePath = NSHomeDirectory().stringByAppendingString("/Documents/\(photoID).jpg")
        image.writeToFile(imagePath, atomically: true)
        NSUserDefaults.standardUserDefaults().setObject(Content, forKey: "nameOfID\(photoID)")
        
        photoID += 1
        NSUserDefaults.standardUserDefaults().setInteger(photoID, forKey: "insertionID")
        NSUserDefaults.standardUserDefaults().synchronize()
        retrieveDatabase()
       
    }

    


}

