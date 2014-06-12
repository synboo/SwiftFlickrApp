//
//  PhotoViewController.swift
//  SwiftFlickrApp
//
//  Created by synboo on 6/5/14.
//  Copyright (c) 2014 synboo. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photoInfo : Dictionary<String, String>!
    @IBOutlet var photoImageView : UIImageView
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
        self.photoInfo = ["title" : ""]
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = self.photoInfo["title"]
        self.photoImageView.setImageWithURL(NSURL.URLWithString(self.photoInfo["url_z"]))
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
