//
//  Wheel.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 31.01.2023.
//

import Foundation
import SwiftUI

struct Wheel: View{
    @ObservedObject var wheelViewModel: WheelViewModel
    
    var body: some View{
        ZStack{
            Circle()
                .scale(0.7)
                .shadow(radius: 5)
            ForEach(wheelViewModel.sections, id: \.id){ item in
                Slice(startAngle: .degrees(item.angles.startAngle), endAngle: .degrees(item.angles.endAngle))
                    .scale(0.7)
                    .foregroundColor(Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)))
            }
        }
        
    }
}
