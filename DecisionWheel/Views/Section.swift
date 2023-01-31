//
//  Section.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 31.01.2023.
//

import Foundation
import SwiftUI

//Slice shape
struct Slice: Shape{
    var startAngle: Angle
    var endAngle: Angle
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: rect.midX, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        return path
    }
}
