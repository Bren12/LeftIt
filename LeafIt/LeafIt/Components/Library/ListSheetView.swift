//
//  ListSheetView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 18/12/24.
//

import SwiftUI

struct ListSheetView: View {
    
    @ObservedObject var observedModel: LibraryModel

    @Binding var showSheet: Bool
    
    @State private var listName: String = ""

    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                    .frame(height: 30)
                
                // MARK: TITLE
                
                Text("📚 Create new list 📚")
                    .foregroundStyle(.primaryBlack)
                    .font(.system(size: 25, weight: .bold))
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                // MARK: PAGES
                
                HStack {
                    
                    Text("List name")
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 15, weight: .bold))
                    
                    Spacer()
                    
                } // -> HStack
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.secondaryGray, lineWidth: 1)
                        .frame(height: 27)
                    
                    HStack {
                        
                        Spacer()
                            .frame(width: 10)
                        
                        TextField("Ex. Now Reading", text: $listName)
                            .foregroundStyle(.primaryBlack)
                        
                    } // -> HStack
                    
                } // -> ZStack
                
                Spacer()
                    .frame(height: 20)
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                // MARK: BUTTON
                
                HStack {
                
                    Button {
                        
                        if listName != "" {
                            Task {
                                observedModel.createList(name: listName)
                            } // --> Task
                            showSheet.toggle()
                        } // -> if
                        
                    } label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.accent)
                                .frame(height: 40)
                            
                            Text("Create")
                                .foregroundStyle(.primaryWhite)
                                .font(.system(size: 15, weight: .semibold))
                            
                        } // -> ZStack
                        
                    } // -> Button
                    
                } // -> HStack
                
                Spacer()
                
            } // -> VStack
            .frame(width: 350)
            
        } // -> ZStack
        
    } // -> body
    
} // -> GoalSheetView

#Preview {
    ListSheetView(observedModel: LibraryModel(), showSheet: .constant(true))
} // -> Preview
