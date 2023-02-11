//
//  WheelViewModel.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 31.01.2023.
//

import Foundation
import SwiftUI
class WheelViewModel: ObservableObject{
    
    
    @Published var sections: [SectionData] = [SectionData(name: "Hello", percentage: 1 / 2), SectionData(name: "World", percentage: 1 / 2)]
    @Published var randomSection: SectionData?
    
    let rotationsPerSecond = 2
    let rotationDuration = 10
    let pointerLocation = PointerLocation.top
    
    func getEndWheelAngle(randomSection: SectionData) -> Double{
        
        return Double(360 * self.rotationsPerSecond * self.rotationDuration) + 360 - randomSection.angles.getRandomBetweenAngle() + pointerLocation.rawValue
    }
    
    ///Calculates start and end angles for a section
    private func calculateAnglesForSection(section: SectionData, sections: [SectionData]) -> Angles{
        if let index = sections.firstIndex(where: {$0 === section}){
            let startAngle = index > 0 ? sections[index - 1].angles.endAngle : 0
            let endAngle = startAngle + (360 * Double(section.percentage))
            
            return Angles(startAngle: startAngle, endAngle: endAngle)
        }
        return Angles()
    }
    

    
    ///Picks random section
    func pickRandomSection() -> SectionData?{
        var limit = 0
        for i in sections{
            limit += Int(i.percentage * 1000)
        }
        
        let randomNumber = Int.random(in: 0...limit)
        
        var currentEdge = 0
        for section in sections{
            let sectionEdge = min(1000, Int(section.percentage * 1000))
            let newEdge = currentEdge + sectionEdge

            ///Random number lies between the edges
            if randomNumber >= currentEdge && randomNumber <= newEdge{
                return section
            }

            currentEdge = newEdge
            
        }
        return sections.first
    }
    
    
    
    ///Create sections data from cell view models data
    func createSectionsData(sectionCellViewModels: [SectionCellViewModel]) -> [SectionData]{
        var sections: [SectionData] = []
        for i in sectionCellViewModels{
            var newSection = SectionData(name: i.name, percentage: i.currentPercentage)
            sections.append(newSection)
        }
        
        ///Assign angles
        for i in sections{
            i.angles = calculateAnglesForSection(section: i, sections: sections)
        }
        return sections
    }
    
    init(){
        for i in sections{
            i.angles = calculateAnglesForSection(section: i, sections: sections)
        }
    }

}
