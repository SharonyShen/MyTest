//
//  ViewController.swift
//  MeowFest
//
//  Created by sharon shen on 3/21/18.
//  Copyright © 2018 Shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
        let textCellIdentifier = "MeowFestTableCell";
    @IBOutlet weak var tableView:UITableView!
    var cats:[[String:String]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! MeowFestTableCell
        let dictionary = cats[indexPath.row]
        let times:String = dictionary["timestamp"]!
        cell.timeLabel.text = UTCToLocal(date: times, fromFormat: "yyyy-MM-dd'T'HH:mm:ssZ", toFormat: "mm/dd/yy")
        //cell.timeLabel.text = times
        cell.titleLabel.text = dictionary["title"]
        cell.descriptionLabel.text = dictionary["description"]
        cell.meowImageView?.imageFromServerURL(urlString:dictionary["image_url"]!)
        
        return cell

    }
    func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
func downloadData()
{
    let url = URL(string:"https://chex-triplebyte.herokuapp.com/api/cats?page=0")
    
    let session = URLSession.shared
    let task = session.dataTask(with:url!) { (data, response, error) -> Void in
        print(">>>> \(String(describing: data))")
        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:String]]
            self.cats = ((jsonResult))!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
        catch let error as NSError{
            print(error)
        }
        
    }
    task.resume()
       
}
    
}
    
    


