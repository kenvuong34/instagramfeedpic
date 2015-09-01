//
//  PhotosViewController.swift
//  InstagramFeed
//
//  Created by P5mini 2 on 9/1/15.
//  Copyright (c) 2015 Hien VH. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refreshControl: UIRefreshControl!
    var photos: NSArray = []
    @IBOutlet weak var PhotosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(checkNetwork()){
            refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
//            tableView.insertSubview(refreshControl, atIndex: 0)
            JTProgressHUD .show();

            PhotosTableView.rowHeight = 320
            var clientId = "29db39df09954402a86d39b6d7f57669"
        
            var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
            var request = NSURLRequest(URL: url)
        
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var responseDitionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.photos = responseDitionary["data"] as! NSArray
                self.PhotosTableView.reloadData()
                JTProgressHUD .hide();
            }
            PhotosTableView.dataSource = self
            PhotosTableView.delegate = self
        } else{
            let alertController = UIAlertController(title: "Network Error", message: "No internet network", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)        }

        
    }
        
        
        
        // Do any additional setup after loading the view.
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count;
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoTableViewCell
        
        let photo = photos[indexPath.row]
        var id = photo["id"]

        let url = NSURL(string: photo.valueForKeyPath("images.standard_resolution.url") as! String)!
        NSLog("\(url)")
        cell.photoImageView.setImageWithURL(url)
        cell.UserLabel.text = photo.valueForKeyPath("user.full_name") as! String
        return cell
    }
    func delay(delay:Double, closure:()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)) ),dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {self.refreshControl.endRefreshing()})
        println("on refresh")
    }
    func checkNetwork()->Bool{
        var Status:Bool = false
        let url = NSURL(string: "http://google.com/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: NSURLResponse?
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
        
        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        
        return Status
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true )
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPathForCell(cell)!
//        let movie = movies![indexPath.row]
//        let movieDetailViewController = segue.destinationViewController as! MovieDetailViewController
//        
//        movieDetailViewController.movie = movie
        
        var vc = segue.destinationViewController as! PhotoDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as UITableViewCell)!
        var photo = photos[indexPath.row]
        
        vc.photo = photo
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
