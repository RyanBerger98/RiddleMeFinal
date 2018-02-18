//
//  TableViewController.swift
//  RiddleMe
//
//  Created by Neil Johnson on 2/18/18.
//  Copyright © 2018 Neil Johnson. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var myTableView = UITableView()
    var json : JSON = []
    var riddles = Array<riddle>()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riddles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toRiddle", sender: riddles[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getTableCell(cellTitle: riddles[indexPath.row].title)
    }
    
    func getTableCell(cellTitle: String) -> UITableViewCell {
        let myCell = UITableViewCell()
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        
        let multipleAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 18.0)!,
            NSAttributedStringKey.foregroundColor: UIColor(hexString: "#3058B2")]
        
        let agePlaceholder = NSAttributedString(string: cellTitle, attributes: multipleAttributes)
        myLabel.attributedText = agePlaceholder
        myLabel.numberOfLines = 0
        
        myCell.addSubview(myLabel)
        myLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(myCell.snp.height).dividedBy(2)
            make.width.equalToSuperview()
            make.center.equalTo(myCell.snp.center)
        }
        return myCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in json["results"].arrayValue {
            let title = item["title"].stringValue
            let id = item["riddleId"].stringValue
            let length = item["length"].stringValue
            let ques = item["question"].stringValue
            var geoFence = Array<latLong>()
            for coord in item["geofence"].arrayValue {
                let coords = latLong(lat: coord["lat"].stringValue, lon: coord["lon"].stringValue)
                geoFence.append(coords)
            }
            let newRiddle = riddle(title: title, id: id, length: length, geoLat: geoFence, question: ques)
            riddles.append(newRiddle)
        }
        for item in riddles {
            print(item)
        }
        createView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func createView() {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = UIColor.clear
        myTableView.separatorStyle = .singleLine
        myTableView.separatorColor = UIColor.black
        myTableView.separatorInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        self.view.addSubview(myTableView)
        myTableView.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().inset(50)
            make.bottom.equalTo(self.view.snp.bottom).inset(20)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueView = segue.destination as? MapController,
            let myRiddle = sender as? riddle {
            segueView.customRiddle = myRiddle
        }
     }
    
    
}

