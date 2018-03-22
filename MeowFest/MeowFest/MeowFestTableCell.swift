//
//  MeowFestTableCell.swift
//  MeowFest
//
//  Created by sharon shen on 3/21/18.
//  Copyright © 2018 Shen. All rights reserved.
//

import Foundation
import UIKit

class MeowFestTableCell :UITableViewCell{
    
    @IBOutlet weak var meowImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!

    

}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
