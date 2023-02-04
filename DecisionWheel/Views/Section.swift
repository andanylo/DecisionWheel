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


struct Section: View{
    var sectionData: SectionData
    
    
    var body: some View{
        ZStack{

                Text(sectionData.name + "     ")
                        .foregroundColor(Color.white)
                        .font(Font.system(size: 20, weight: .bold))
                        .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.width, alignment: .trailing)
                        .background{
                            Slice(startAngle: .degrees(-1.0 * sectionData.angles.getSize() / 2.0), endAngle: .degrees(sectionData.angles.getSize() / 2.0))
                                .foregroundColor(Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)))
                        }
            
        }
        
   
        
    }
}
