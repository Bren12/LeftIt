//
//  GoalSheetView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 16/12/24.
//

import SwiftUI

struct GoalSheetView: View {
    
    @ObservedObject var viewModel: GoalModel
    
    @Binding var showSheet: Bool
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                    .frame(height: 30)
                
                Text("📚 Goal Progress 📚")
                    .foregroundStyle(.primaryBlack)
                    .font(.system(size: 25, weight: .bold))
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    Text("Time lapse")
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 15, weight: .bold))
                    
                    Spacer()
                    
                } // -> HStack
                
                HStack {
                    
                    ForEach(Period.allCases, id: \.self) { period in
                        
                        Button {
                            viewModel.periodSelected = period.rawValue
                        } label: {
                            
                            ZStack {
                                
                                if viewModel.periodSelected == period.rawValue {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.accent)
                                        .frame(width: 100, height: 27)
                                } else {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.accent, lineWidth: 1)
                                        .frame(width: 100, height: 27)
                                }
                                
                                Text("\(period.rawValue)")
                                    .foregroundStyle(viewModel.periodSelected == period.rawValue ? .primaryWhite : .accent)
                                    .font(.system(size: 12, weight: .regular))
                                
                            } // -> ZStack
                            
                        } // -> Button
                        
                    } // -> ForEach
                    
                    Spacer()
                    
                } // -> HStack
                
                Spacer()
                    .frame(height: 20)
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    Text("Books read this year")
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
                        
                        TextField("Ex. 2", text: $viewModel.readBook)
                            .foregroundStyle(.primaryBlack)
                            .keyboardType(.numberPad)
                            .onChange(of: viewModel.readBook) { newValue in
                                viewModel.readBook = newValue.filter { $0.isNumber }
                            } // -> onChange
                        
                    } // -> HStack
                    
                } // -> ZStack
                
                Spacer()
                    .frame(height: 20)
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    Text("Year goal of books to read")
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
                        
                        TextField("Ex. 9", text: $viewModel.goalBook)
                            .foregroundStyle(.primaryBlack)
                            .keyboardType(.numberPad)
                            .onChange(of: viewModel.goalBook) { newValue in
                                viewModel.goalBook = newValue.filter { $0.isNumber }
                            } // -> onChange
                        
                    } // -> HStack
                    
                } // -> ZStack
                
                Spacer()
                    .frame(height: 20)
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    if viewModel.readGoal != nil {

                        Button {
                            viewModel.deleteGoal()
                            showSheet.toggle()
                            resetValues()
                        } label: {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.primaryRed)
                                    .frame(height: 40)
                                
                                Text("Delete Goal")
                                    .foregroundStyle(.primaryWhite)
                                    .font(.system(size: 15, weight: .semibold))
                                
                            } // -> ZStack
                            
                        } // -> Button
                        
                    } // -> if
                
                    Button {
                        
                        if let readInt = Int(viewModel.readBook), let goalInt = Int(viewModel.goalBook), let periodEnum = Period(rawValue: viewModel.periodSelected), goalInt != 0, readInt <= goalInt {
                            
                            if viewModel.readGoal == nil {
                                print("CREATE")
                                viewModel.createGoal()
                            } else {
                                print("UPDATE")
                                viewModel.updateGoal()
                            } // -> if-else
                            
                            showSheet.toggle()
                            resetValues()
                        } // -> if
                        
                    } label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.accent)
                                .frame(height: 40)
                            
                            Text(viewModel.readGoal == nil ? "Set Goal" : "Update Goal")
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
    
    func resetValues() {
        viewModel.goalBook = ""
        viewModel.readBook = ""
        viewModel.periodSelected = Period.month.rawValue
    }
    
} // -> GoalSheetView

#Preview {
    GoalSheetView(viewModel: GoalModel(), showSheet: .constant(true))
} // -> Preview
