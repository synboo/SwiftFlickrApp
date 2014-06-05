//
//  ViewController.swift
//  SwiftFlickrApp
//
//  Created by synboo on 6/5/14.
//  Copyright (c) 2014 synboo. All rights reserved.
//

import UIKit

enum LayoutType: Int {
    case Grid = 0
    case List = 1
}

class ViewController: UICollectionViewController {
    
    var photos:Dictionary<String, String>[] = []
    var layoutType = LayoutType.Grid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFlickrPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getFlickrPhotos() {
        let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let url :String = "https://api.flickr.com/services/rest/"
        let parameters :Dictionary = [
            "method"         : "flickr.interestingness.getList",
            "api_key"        : "86997f23273f5a518b027e2c8c019b0f",
            "per_page"       : "300",
            "format"         : "json",
            "nojsoncallback" : "1",
            "extras"         : "url_q,url_z",
        ]
        SVProgressHUD.show()
        manager.GET(url, parameters: parameters, success: requestSuccess, failure: requestFailure)
    }

    func requestSuccess (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void {
        SVProgressHUD.dismiss()
        self.photos = responseObject.objectForKey("photos").objectForKey("photo") as Array
        self.collectionView.reloadData()
        NSLog("requestSuccess \(responseObject)")
    }
    
    func requestFailure (operation :AFHTTPRequestOperation!, error :NSError!) -> Void {
        SVProgressHUD.dismiss()
        NSLog("requestFailure: \(error)")
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count;
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var photoCell: PhotoCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoCell
        var photoInfo = photos[indexPath.item] as Dictionary
        var photoUrl = (self.layoutType == LayoutType.Grid) ? photoInfo["url_q"] : photoInfo["url_z"]
        photoCell.photoImageView.setImageWithURL(NSURL.URLWithString(photoUrl))
        photoCell.photoInfo = photoInfo
        
        return photoCell;
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var itemSize :CGSize = (self.layoutType == LayoutType.Grid) ? CGSizeMake(80, 80) : CGSizeMake(320, 150)
        
        return itemSize
    }
    
    @IBAction func segmentedControlDidChanged(control : UISegmentedControl) {
        switch control.selectedSegmentIndex {
        case 0:
            self.layoutType = LayoutType.Grid
        case 1:
            self.layoutType = LayoutType.List
        default:
            self.layoutType = LayoutType.Grid
        }
        
        self.collectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "ShowPhoto" {
            var photoCell : PhotoCell = sender as PhotoCell
            var photoViewController = segue.destinationViewController as PhotoViewController
            photoViewController.photoInfo = photoCell.photoInfo
        }
    }
}

