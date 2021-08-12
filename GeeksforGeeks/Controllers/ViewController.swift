//
//  ViewController.swift
//  GeeksforGeeks
//
//  Created by MAC on 11/08/21.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    var itemData = [EOItemModal]()
    //Marks:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getNewsData()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    //Marks:- Pull to refresh variable
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    //Marks:- Pull to refresh action
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.getNewsData()
        refreshControl.endRefreshing()
    }
    
    //Marks:- API Call method
    func getNewsData(){
        WebServices.getInstance.requestWithGet(baseUrl: "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/", endUrl: "news/feed/51120/rss.xml") { (jsonData) in
            print(jsonData)
            if jsonData["status"] as? String == "ok"{
                do {
                    let decoder = JSONDecoder()
                    self.itemData = try decoder.decode([EOItemModal].self, from: JSONSerialization.data(withJSONObject: jsonData["items"] as? [[String:Any]] as Any, options: []))
                    
                } catch let err {
                    print(err)
                }
                self.tableView.reloadData()
            }
        } onError: { (error) in
            print(error ?? "")
        }
        
    }
    //Marks:- Date decode method
    func getDate(dateString:String)-> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let date: Date? = dateFormatterGet.date(from: dateString)
        let str =  "\(dateFormatter.string(from: date!))"
        return str
    }
    //Marks:- Time decode method
    func getTime(dateString:String)-> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let date: Date? = dateFormatterGet.date(from: dateString)
        let str =  "\(dateFormatter.string(from: date!))"
        return str
    }
   

}
//MARKS:- TableView Data soucre
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = itemData[indexPath.row]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderTableViewCell") as!  NewsHeaderTableViewCell
            let str = obj.enclosure?.link?.components(separatedBy: "?")[0] ?? ""
                cell.headerImg.sd_setImage(with: URL(string: (str)), placeholderImage: UIImage(named: "placeholder"))
            cell.titleLbl.text = obj.title
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell") as!  NewsListTableViewCell
            let str = obj.thumbnail?.components(separatedBy: "?")[0] ?? ""
         print("str:\(str)")
                cell.listImg.sd_setImage(with: URL(string: (str)), placeholderImage: UIImage(named: "placeholder"))
            
            cell.titleLbl.text = obj.title
            cell.dateLbl.text = "\(getDate(dateString: obj.pubDate ?? ""))"
            cell.timeLbl.text = "\(getTime(dateString: obj.pubDate ?? ""))"
            return cell
        }
        
    }
}

