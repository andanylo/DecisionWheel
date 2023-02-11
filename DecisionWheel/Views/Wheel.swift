//
//  Wheel.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 31.01.2023.
//

import Foundation
import SwiftUI

struct Pointer: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let startPoint = CGPoint(x: rect.midX-5, y: rect.minY+35)
        
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: startPoint.x+10, y: startPoint.y))
        path.addLine(to: CGPoint(x: startPoint.x+5, y: startPoint.y+15))
        path.addLine(to: startPoint)
        path.closeSubpath()
        return path
    }
    
    
}


struct Wheel: View{
    @ObservedObject var wheelViewModel: WheelViewModel

    var body: some View{
        ZStack{
            

                ForEach(wheelViewModel.sections, id: \.id){ item in
                    SectionWheel(sectionData: item)
                        .rotationEffect(Angle(degrees: item.angles.startAngle + item.angles.getSize() / 2))
                        //.scale(0.7)
                }
            
            
        }
        
        
    }
}
