//
//  MapController.swift
//  RiddleMe
//
//  Created by Neil Johnson on 2/18/18.
//  Copyright © 2018 Neil Johnson. All rights reserved.
//

import UIKit
import GoogleMaps

class MapController: UIViewController {

    var customRiddle: riddle!
    var userLat: Double!
    var userLon: Double!
    
    override func loadView() {
        //var locManager = CLLocationManager()
        //locManager.requestWhenInUseAuthorization()
       // var currentLocation: CLLocation!
        
        //if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
         //   CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
         //   currentLocation = locManager.location
            
        //}

        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6. //sike
        var centerLat = centerLatOf(r: customRiddle)
        var centerLon = centerLonOf(r: customRiddle)
        
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(centerLat), longitude: CLLocationDegrees(centerLon), zoom: 18.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.mapType = .normal
        
        view = mapView
        
        var myLabel = UILabel()
        myLabel.text = customRiddle.question
        myLabel.textAlignment = .center
        self.view.addSubview(myLabel)
        myLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(self.view.snp.height).dividedBy(4)
            make.width.equalTo(self.view.snp.width).inset(20)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.snp.top)
        }
        // Create a rectangular path
        let rect = GMSMutablePath()
        //rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        for item in customRiddle.geoLat {
            rect.add(CLLocationCoordinate2D(latitude: Double(item.lat)!, longitude: Double(item.lon)!))
        }
        
        // Create the polygon, and assign it to the map.
        let polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor(red: 0.4, green: 0, blue: 0, alpha: 0.3);
        polygon.strokeColor = .black
        polygon.strokeWidth = 2
        polygon.map = mapView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func centerLatOf(r: riddle) -> Double {
        var numLats = Double(0);
        var latTotal = Double(0);
        for item in r.geoLat {
            latTotal = Double(latTotal) + Double(item.lat)!
            numLats = numLats + 1
        }
        return latTotal/Double(numLats)
    }
    func centerLonOf(r: riddle) -> Double {
        var numLons = Double(0);
        var lonTotal = Double(0);
        for item in r.geoLat {
            lonTotal = Double(lonTotal) + Double(item.lon)!
            numLons = numLons + 1
        }
        return lonTotal/numLons
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
