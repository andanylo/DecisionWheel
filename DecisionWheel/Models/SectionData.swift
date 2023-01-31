//
//  WheelData.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 31.01.2023.
//

import Foundation
class SectionData {
    let id = UUID()
    var name: String
    var percentage: Float
    
    var angles: Angles = Angles()
    
    init(name: String, percentage: Float) {
        self.name = name
        self.percentage = percentage
    }
}

///Angles in degrees
struct Angles{
    var startAngle: Double = 0
    var endAngle: Double = 0
}
