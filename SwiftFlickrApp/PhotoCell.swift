//
//  PhotoCell.swift
//  SwiftFlickrApp
//
//  Created by synboo on 6/5/14.
//  Copyright (c) 2014 synboo. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell
{
    @IBOutlet var photoImageView : UIImageView
    var photoInfo : Dictionary<String, String>?
    
//    init(coder aDecoder: NSCoder!)
//    {
//        super.init(coder: aDecoder)
//    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
}
