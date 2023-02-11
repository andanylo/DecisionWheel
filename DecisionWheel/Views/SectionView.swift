//
//  SectionView.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 08.02.2023.
//

import Foundation
import SwiftUI

struct SectionView: View{
    @StateObject var sectionCellViewModel: SectionCellViewModel
    
    

    @FocusState var isFocused: Bool
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 2)
            VStack{
                HStack{
                    Spacer()
                        .frame(width:10)
                    Button {
                        if let index = sectionCellViewModel.sectionEditViewModel?.sectionCellViewModels.firstIndex(where: {$0 === sectionCellViewModel}){
                            sectionCellViewModel.sectionEditViewModel?.sectionCellViewModels.remove(at: index)
                            sectionCellViewModel.sectionEditViewModel?.adjustCurrentPercentage(currentEditingViewModel: nil)
                        }
                    } label: {
                        Image(systemName: "x.circle")
                    }
                    .font(.system(size: 24))
                    .foregroundColor(Color.red)
                    
                    Spacer()
                    TextField("Name", text: $sectionCellViewModel.name)
                        .focused($isFocused)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    Button{
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.circle")
                    }
                    .font(.system(size: 24))
                    .hidden()
                    
                    Spacer()
                        .frame(width: 10)
                }
                HStack{
                    
                    Text(String(format: "%.2f", sectionCellViewModel.currentPercentage * 100) + "%")
                        .frame(width: 50)
                        .font(Font.system(size: 11))
                    Slider(value: $sectionCellViewModel.currentPercentage, in: 0.0...1.0, step: 0.01, onEditingChanged: { editing in
                        sectionCellViewModel.isEditing = editing
                    })
                    .onChange(of: sectionCellViewModel.currentPercentage, perform: { newValue in
                        
                        if sectionCellViewModel.isEditing{
                           
                            sectionCellViewModel.sectionEditViewModel?.adjustCurrentPercentage(currentEditingViewModel: sectionCellViewModel)
                        }
                    })
                       
                        .frame(width: 200)
                        
                    Text("100%")
                        .font(Font.system(size: 11))
                }
                
            }
            
            
            
            
        }
//        .onTapGesture {
//            isFocused = true
//        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .frame(height: 100)
        
    }
}
