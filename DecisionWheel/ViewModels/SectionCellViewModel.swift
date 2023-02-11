//
//  SectionCellViewModel.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 09.02.2023.
//

import Foundation

//View model to display for each cell inside edit section view
class SectionCellViewModel: ObservableObject, Identifiable{
    let id = UUID()
    weak var sectionEditViewModel: SectionEditViewModel?
    @Published var currentPercentage: Float = 0.0
    @Published var name: String = ""
    var automaticallyAdjust: Bool = false
    var isEditing = false
}
