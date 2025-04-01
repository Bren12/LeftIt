//
//  GoalSheetView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 16/12/24.
//

import SwiftUI

struct GoalSheetView: View {
    
    @Binding var showSheet: Bool
    
    @State private var periodSelected: Period = .month
    
    var body: some View {
        
        ZStack {
            
            Color.primaryWhite
            
            VStack {
                
                Spacer()
                    .frame(height: 30)
                
                // MARK: TITLE
                
                Text("📚 Goal Progress 📚")
                    .foregroundStyle(.primaryBlack)
                    .font(.system(size: 25, weight: .bold))
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                // MARK: TIME LAPSE
                
                HStack {
                    
                    Text("Time lapse")
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 15, weight: .bold))
                    
                    Spacer()
                    
                } // -> HStack
                
                HStack {
                    
                    ForEach(Period.allCases, id: \.self) { period in
                        
                        Button {
                            periodSelected = period
                        } label: {
                            
                            ZStack {
                                
                                if periodSelected == period {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.accent)
                                        .frame(width: 100, height: 27)
                                } else {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.accent, lineWidth: 1)
                                        .frame(width: 100, height: 27)
                                }
                                
                                Text("\(period.rawValue)")
                                    .foregroundStyle(periodSelected == period ? .primaryWhite : .accent)
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
                
                // MARK: BOOKS READ
                
                HStack {
                    
                    Text("Books read this \(periodSelected.rawValue.lowercased())")
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
                        
//                        ZStack(alignment: .leading) {
//                            
//                            if viewModel.readBook.isEmpty {
//                                Text("Ex. 2")
//                                    .foregroundStyle(.primaryGray)
//                            } // -> if
//                            
//                            TextField("", text: $viewModel.readBook)
//                                .foregroundStyle(.primaryBlack)
//                                .keyboardType(.numberPad)
//                                .onChange(of: viewModel.readBook) { newValue in
//                                    viewModel.readBook = newValue.filter { $0.isNumber }
//                                } // -> onChange
//                            
//                        } // -> ZStack
                        
                    } // -> HStack
                    
                } // -> ZStack
                
                Spacer()
                    .frame(height: 20)
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                // MARK: BOOKS GOAL
                
                HStack {
                    
                    Text("\(periodSelected.rawValue) goal of books to read")
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
                        
//                        ZStack(alignment: .leading) {
//                            
//                            if viewModel.goalBook.isEmpty {
//                                Text("Ex. 9")
//                                    .foregroundStyle(.primaryGray)
//                            } // -> if
//                            
//                            TextField("", text: $viewModel.goalBook)
//                                .foregroundStyle(.primaryBlack)
//                                .keyboardType(.numberPad)
//                                .onChange(of: viewModel.goalBook) { newValue in
//                                    viewModel.goalBook = newValue.filter { $0.isNumber }
//                                } // -> onChange
//                            
//                        } // -> ZStack
                        
                    } // -> HStack
                    
                } // -> ZStack
                
                Spacer()
                    .frame(height: 20)
                
                Divider()
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
//                    if viewModel.readGoal != nil {
//
//                        Button {
//                            viewModel.deleteGoal()
//                            showSheet.toggle()
//                            resetValues()
//                        } label: {
//                            
//                            ZStack {
//                                
//                                RoundedRectangle(cornerRadius: 10)
//                                    .foregroundStyle(.primaryRed)
//                                    .frame(height: 40)
//                                
//                                Text("Delete Goal")
//                                    .foregroundStyle(.primaryWhite)
//                                    .font(.system(size: 15, weight: .semibold))
//                                
//                            } // -> ZStack
//                            
//                        } // -> Button
//                        
//                    } // -> if
                
//                    Button {
//                        
//                        if let readInt = Int(viewModel.readBook), let goalInt = Int(viewModel.goalBook), let periodEnum = Period(rawValue: viewModel.periodSelected), goalInt != 0, readInt <= goalInt {
//                            
//                            if viewModel.readGoal == nil {
//                                viewModel.createGoal()
//                            } else {
//                                viewModel.updateGoal()
//                            } // -> if-else
//                            
//                            showSheet.toggle()
//                            resetValues()
//                        } // -> if
//                        
//                    } label: {
//                        
//                        ZStack {
//                            
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundStyle(.accent)
//                                .frame(height: 40)
//                            
//                            Text(viewModel.readGoal == nil ? "Set Goal" : "Update Goal")
//                                .foregroundStyle(.primaryWhite)
//                                .font(.system(size: 15, weight: .semibold))
//                            
//                        } // -> ZStack
//                        
//                    } // -> Button
                    
                } // -> HStack
                
                Spacer()
                
            } // -> VStack
            .frame(width: 350)
            
        } // -> ZStack
        
    } // -> body
    
//    func resetValues() {
//        viewModel.goalBook = ""
//        viewModel.readBook = ""
//        viewModel.periodSelected = Period.month.rawValue
//    }
    
} // -> GoalSheetView

#Preview {
    GoalSheetView(showSheet: .constant(true))
} // -> Preview
