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
    @IBOutlet weak var scrollView: UIScrollView!
    public var meowImage:UIImage?

    override func viewDidLoad() {
        if let msize = (meowImage?.size){
                scrollView.contentSize = msize
            
            let iView:UIImageView = UIImageView.init(image: meowImage)

            var x = 0.0
            var y = 0.0

            if((msize.width) > scrollView.frame.size.width){
                x = Double((msize.width - scrollView.frame.size.width)/2)
            }
            if((msize.height > scrollView.frame.size.height)){
                y = Double((meowImage!.size.height - scrollView.frame.size.height)/2)
            }
            
            scrollView.addSubview(iView)
            scrollView.setContentOffset(CGPoint(x:x,y:y), animated: false)
        }
    }
}
