//
//  DetailViewController.swift
//  MeowFest
//
//  Created by sharon shen on 3/22/18.
//  Copyright © 2018 Shen. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : UIViewController
{
    @IBOutlet weak var imageView:UIImageView!;
    @IBOutlet weak var scrollView: UIScrollView!
    public var meowImage:UIImage?
    public var title:UILabel?
    
    override func viewDidLoad() {
        scrollView.contentSize = (meowImage?.size)!
        imageView.image = meowImage
    }
}
