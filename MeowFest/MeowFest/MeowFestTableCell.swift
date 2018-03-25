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
    
    @IBOutlet weak var meowImageView: MeowImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

}

class MeowImageView: UIImageView {
    var activityIndicator: UIActivityIndicatorView!
    public func imageFromServerURL(urlString: String) {
        let activityIndicator = UIActivityIndicatorView()
        self .addSubview(activityIndicator);
        activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async(execute: {
                activityIndicator.stopAnimating()
                activityIndicator .removeFromSuperview()
                if error != nil {
                    print(error)
                    return
                }
                if let image_data = data{
                    let image = UIImage(data: image_data)
                    self.image = image
                }
            })

        }).resume()
    }
}
