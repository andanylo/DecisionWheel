//
//  WheelViewModel.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 31.01.2023.
//

import Foundation
import SwiftUI
class WheelViewModel: ObservableObject{
    
    
    @Published var sections: [SectionData] = [SectionData(name: "Hello", percentage: 1 / 4), SectionData(name: "World", percentage: 1 / 8), SectionData(name: "!", percentage: 1 / 4), SectionData(name: "Hello 2", percentage: 1 / 8), SectionData(name: "Hello 3", percentage: 1 / 8), SectionData(name: "Hello 4", percentage: 1 / 8)]
    @Published var randomSection: SectionData?
    
    let rotationsPerSecond = 2
    let rotationDuration = 10
    let pointerLocation = PointerLocation.top
    
    func getEndWheelAngle(randomSection: SectionData) -> Double{
        
        return Double(360 * self.rotationsPerSecond * self.rotationDuration) + 360 - randomSection.angles.getRandomBetweenAngle() + pointerLocation.rawValue
    }
    
    ///Calculates start and end angles for a section
    private func calculateAnglesForSection(section: SectionData) -> Angles{
        if let index = sections.firstIndex(where: {$0 === section}){
            let startAngle = index > 0 ? sections[index - 1].angles.endAngle : 0
            let endAngle = startAngle + (360 * Double(section.percentage))
            
            return Angles(startAngle: startAngle, endAngle: endAngle)
        }
        return Angles()
    }
    
    ///Picks random section
    func pickRandomSection() -> SectionData?{
        let randomNumber = Int.random(in: 0...100)
        
        var currentEdge = 0
        for section in sections{
            let sectionEdge = min(100, Int(section.percentage * 100))
            let newEdge = currentEdge + sectionEdge
            
            print(currentEdge, newEdge, randomNumber)
            ///Random number lies between the edges
            if randomNumber >= currentEdge && randomNumber <= newEdge{
                return section
            }
            currentEdge = newEdge
            
        }
        return sections.first
    }
    
    
    init(){
        for i in sections{
            i.angles = calculateAnglesForSection(section: i)
        }
    }

}
