//
//  PhotoDetailsViewController.swift
//  InstagramFeed
//
//  Created by P5mini 2 on 9/1/15.
//  Copyright (c) 2015 Hien VH. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    var photo: NSArray = []
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DetailPhotoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: photo.valueForKeyPath("images.standard_resolution.url") as! String)!
        
        DetailPhotoImageView.setImageWithURL(url)
        // Do any additional setup after loading the view.
    }

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
