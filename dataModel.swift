//
//  dataModel.swift
//  RiddleMe
//
//  Created by Neil Johnson on 2/18/18.
//  Copyright © 2018 Neil Johnson. All rights reserved.
//

import Foundation
struct latLong {
    var lat: String
    var lon: String
}
struct riddle {
    var title: String
    var id: String
    var length: String
    var geoLat: Array<latLong>
    var question: String
}
