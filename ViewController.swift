//
//  ViewController.swift
//  RiddleMe
//
//  Created by Neil Johnson on 2/17/18.
//  Copyright © 2018 Neil Johnson. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    
    var jsonResponse = JSON()
    
    

    
    @IBAction func search(button: UIButton) {
        print("segue & search now")
        URLRequest(with: "", query: "", completion: { json in
            guard json != nil else { return }
            print(json)
            self.performSegue(withIdentifier: "toResults", sender: json!)
        })
    }

    override func loadView() {
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6. //sike
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.mapType = .normal

        view = mapView

        // Creates a marker in the center of the map.
        //let marker = GMSMarker()
        //marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        //marker.title = "Sydney"
        //marker.snippet = "Australia"
        //marker.map = mapView
        let myView = UIView()
        myView.backgroundColor = UIColor(hexString: "#CB5B43")
        myView.alpha = 0.8
        view.addSubview(myView)
        myView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(view.snp.size)
            make.center.equalTo(view.snp.center)
        }
        let welcome = UILabel()
        welcome.attributedText = NSAttributedString(string: "Welcome to RiddleMe")
        welcome.textAlignment = .center
        myView.addSubview(welcome)
        welcome.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(self.view.snp.height).dividedBy(4)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.snp.top).inset(15)
        }
        
        let findButton = UIButton()
        findButton.layer.cornerRadius = 10
        findButton.layer.borderWidth = 1

        findButton.backgroundColor = UIColor.white
        findButton.alpha = 1
        findButton.setAttributedTitle(NSAttributedString(string: "Find My Adventure"), for: .normal)
        findButton.titleLabel?.textAlignment = .center
        findButton.titleLabel?.textColor = UIColor.black
        findButton.addTarget(self, action: #selector(self.search(button:)), for: .touchUpInside)

        myView.addSubview(findButton)
        findButton.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview().inset(45)
            make.height.equalToSuperview().dividedBy(6)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.snp.bottom).inset(80)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.backgroundColor = UIColor(hexString: "#CB5B43")
        
        //TODO POST
        /*
        let parameters: [String : String] = [
            "riddle_id" : "HopHacks",
            "latitude" : "39.32768",
            "longitude" : "-76.62210",
            "answer" : "" ,
        ]
        */

        /*
 */
        /*
        Alamofire.request("https://x45bz1gn.apps.lair.io/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
        }
 */
        
        /*
        Alamofire.request(.POST, "https://x45bz1gn.apps.lair.io/", parameters: parameters, encoding: .JSON)
            .responseJSON { request, response, JSON, error in
                print(response)
                print(JSON)
                print(error)
        }
 */
        // Do any additional setup after loading the view, typically from a nib.
    }
    func URLRequest(with URL:String, query:String, completion: @escaping (JSON?) -> Void) {
        
       /*
        Alamofire.request("https://x45bz1gn.apps.lair.io/search", method: .get, parameters: ["":""], headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    //print(response.result.value!)
                    completion(JSON(response.result.value!))
                }
                break
                
            case .failure(_):
                print(response.result.error!)
                break
                
            }
        }
        */
        Alamofire.request("https://x45bz1gn.apps.lair.io/search").responseJSON { snapshot in
            
            guard let value = snapshot.result.value else { completion(nil); return }
            
            let json = JSON(value)
            
            completion(json)
            
        }
        /*
        Alamofire.request("https://x45bz1gn.apps.lair.io/search").responseJSON { snapshot in
            
            guard let value = snapshot.result.value else { completion(nil); return }
            
            let json = JSON(value)
            
            completion(json)
            
        }
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueView = segue.destination as? ResultsVC,
            let json = sender as? JSON {
            print(json)
            segueView.json = json
        }
    }


}

