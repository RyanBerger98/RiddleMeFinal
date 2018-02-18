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

class TableViewController: UITableViewController {

    var json : JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()
        var riddles = Array<riddle>()
        for item in json["results"].arrayValue {
            let title = item["title"].stringValue
            let id = item["riddleId"].stringValue
            let length = item["length"].stringValue
            var geoFence = Array<latLong>()
            for coord in item["geofence"].arrayValue {
                let coords = latLong(lat: coord["latitude"].stringValue, lon: coord["longitude"].stringValue)
                geoFence.append(coords)
            }
            let newRiddle = riddle(title: title, id: id, length: length, geoLat: geoFence)
            riddles.append(newRiddle)
        }
        for item in riddles {
            print(item)
        }
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func URLRequest(with URL:String, query:String, completion: @escaping (JSON?) -> Void) {
        
        
        Alamofire.request("https://x45bz1gn.apps.lair.io/search", method: .get, parameters: ["":""], headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                    completion(JSON(response.result.value!))
                }
                break
                
            case .failure(_):
                print(response.result.error!)
                break
                
            }
        }
        
        /*
         Alamofire.request("https://x45bz1gn.apps.lair.io/search").responseJSON { snapshot in
         
         guard let value = snapshot.result.value else { completion(nil); return }
         
         let json = JSON(value)
         
         completion(json)
         
         }
         */
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
