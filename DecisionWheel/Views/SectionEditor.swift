//
//  SectionEditor.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 04.02.2023.
//

import Foundation
import SwiftUI


struct SectionEditor: View{
    @StateObject var sectionEditViewModel: SectionEditViewModel
    @ObservedObject var wheelViewModel: WheelViewModel
    
    @Environment(\.dismiss) var dismiss
    var body: some View{
        VStack{
            HStack{
                Button("Done") {
                    dismiss()
                }
                .padding(20)
                .buttonStyle(.bordered)
                Spacer()
            }
            Text("Edit wheel")
                .font(.title)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            HStack{
                Button {
                    _ = withAnimation {
                        sectionEditViewModel.addCellViewModel()
                    }
                } label: {
                    Image(systemName: "plus.circle")
                }

            }
            .frame(height:20)
            List{
                ForEach(sectionEditViewModel.sectionCellViewModels, id: \.id){ section in
                    SectionView(sectionCellViewModel: section)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        
                }
               
            }
            .listStyle(.plain)
            Button("Save") {
                wheelViewModel.sections = wheelViewModel.createSectionsData(sectionCellViewModels: sectionEditViewModel.sectionCellViewModels)
                dismiss()
            }
            .buttonStyle(.bordered)
        }

        

    }
}


