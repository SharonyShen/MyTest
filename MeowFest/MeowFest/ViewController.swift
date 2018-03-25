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
        if let times:String = dictionary["timestamp"] {
            cell.timeLabel.text = UTCToLocal(date: times, fromFormat: "yyyy-MM-dd'T'HH:mm:ssZ", toFormat: "mm/dd/yy")
        }
        else{
            cell.timeLabel.text = ""
        }
        if let title_string = dictionary["title"]{
            cell.titleLabel.text = title_string
        }
        else
        {
            cell.timeLabel.text = ""
        }
        
        if let description_text = dictionary["description"]{
         cell.descriptionLabel.text = description_text
        }
        else{
            cell.timeLabel.text = ""
        }
        if let url = dictionary["image_url"]{
            cell.meowImageView?.imageFromServerURL(urlString:url)
        }
        else{
            cell.meowImageView.image = nil
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let detailViewController = DetailViewController();
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let cell:MeowFestTableCell = tableView.cellForRow(at: indexPath) as! MeowFestTableCell
        let theImage = cell.meowImageView?.image
        detailViewController.meowImage = theImage
        
        self.navigationController?.pushViewController(detailViewController, animated:true)
        
    }

    func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let dt = dateFormatter.date(from: date){
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: dt)
        }
        else{
            return date}
    }
    
    let refreshControl = UIRefreshControl();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        if #available(iOS 10.0, *){
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.tintColor = UIColor.blue
        refreshControl.addTarget(self, action: #selector(downloadData), for: .valueChanged)
        
        downloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @objc func downloadData()
{
    let url = URL(string:"https://chex-triplebyte.herokuapp.com/api/cats?page=0")
    let session = URLSession.shared
    let task = session.dataTask(with:url!) { (data, response, error) -> Void in
        print(">>>> \(String(describing: data))")
        if error != nil {
            print(error as Any)
        } else {
            
            if let usableData = data {
                print(usableData) //JSONSerialization
                do{
                        let jsonResult = try JSONSerialization.jsonObject(with: usableData, options: []) as? [[String:String]]
                        self.cats = ((jsonResult))!
                        DispatchQueue.main.async {
                            self.refreshControl.endRefreshing()
                            self.tableView.reloadData()
                        }
                    }
                catch let error as NSError{
                    print(error)
                }
            }
        }
    }
    task.resume()
       
}
    
}
    
    


