//
//  PhotoViewController.swift
//  instagramfeed
//
//  Created by Zet on 8/27/15.
//  Copyright (c) 2015 platform5. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var photos: NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var clientID = "29db39df09954402a86d39b6d7f57669"
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientID)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            { (respondse: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.photos = responseDictionary["data"] as! NSArray
                self.tableView.reloadData()
                NSLog("respondse: \(self.photos)")
            }
        }

    
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
