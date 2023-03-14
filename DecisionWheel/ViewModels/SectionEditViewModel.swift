//
//  SectionEditViewModel.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 09.02.2023.
//

import Foundation

//View model for edit section
class SectionEditViewModel: ObservableObject{
    
    @Published var sectionCellViewModels: [SectionCellViewModel] = []
    
    
    
    init(sections: [SectionData]){
        self.sectionCellViewModels = createCellViewModels(sections: sections)
    }
    
    
    ///Create view models from sections data
    func createCellViewModels(sections: [SectionData]) -> [SectionCellViewModel]{
        var viewModels:[SectionCellViewModel] = []
        for i in sections{
            let sectionCellViewModel = SectionCellViewModel()
            sectionCellViewModel.name = i.name
            sectionCellViewModel.sectionEditViewModel = self
            sectionCellViewModel.currentPercentage = i.percentage
            viewModels.append(sectionCellViewModel)
        }
        
        return viewModels
    }
    
    ///Adds new cell view model
    func addCellViewModel(){
        let newSectionCellViewModel = SectionCellViewModel()
        newSectionCellViewModel.name = ""
        newSectionCellViewModel.sectionEditViewModel = self
        newSectionCellViewModel.currentPercentage = 1.0 / (Float(sectionCellViewModels.count) + 1)
        self.sectionCellViewModels.insert(newSectionCellViewModel, at: 0)
        
        adjustCurrentPercentage(currentEditingViewModel: newSectionCellViewModel)
    }
    
    
    ///Adjust current percentage for view models that are not currently editing
    func adjustCurrentPercentage(currentEditingViewModel: SectionCellViewModel?){
        let notEditedViewModels: [SectionCellViewModel] = sectionCellViewModels.filter({!($0 === currentEditingViewModel)})
        
        var currentEditingValue: Float = 0.0
        if let currentEditingViewModel = currentEditingViewModel{
            let rounded = (currentEditingViewModel.currentPercentage * 100).rounded() / 100
            currentEditingViewModel.currentPercentage = rounded
            currentEditingValue = rounded
        }
        
        
        let valueToDivideBetweenModels = ((1.0 - currentEditingValue) * 100).rounded() / 100
        var cumulativeOtherValues: Float = 0.0
        for i in notEditedViewModels{
            cumulativeOtherValues += i.currentPercentage
        }
        
        let difference = valueToDivideBetweenModels - cumulativeOtherValues
        

        ///Calculate new value based on proportion of sum of all non editing models
        for i in notEditedViewModels{
            let proportion = i.currentPercentage / (cumulativeOtherValues)
            if proportion != 0{
                i.currentPercentage += (difference * proportion * 1000).rounded() / 1000
            }


        }

    
        
    }
    
}
