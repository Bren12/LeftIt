//
//  GoalCard.swift
//  LeftIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct GoalCard: View {
    
    @ObservedObject var viewModel: GoalModel
    
    @Binding var showSheet: Bool
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 350, height: 80)
                .foregroundStyle(.white)
                .shadow(
                    radius: 4,
                    y: 4
                )
            
            HStack {
                
                BookIcon(viewModel: viewModel)
                
                VStack(alignment: .leading) {
                    
                    Text("\( (viewModel.readGoal?.period?.rawValue ?? "") + (viewModel.readGoal?.period?.rawValue != nil ? " " : "") )Goal Progress")
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 15, weight: .medium))
                        .frame(width: 148)
                    
                    if let readGoal = viewModel.readGoal, let goal = readGoal.bookGoal, let read = readGoal.bookRead {
                        Text("\(read) / \(goal) books")
                            .foregroundStyle(.primaryGray)
                            .font(.system(size: 10, weight: .regular))
                    } else {
                        Text("Let’s set a new goal!")
                            .foregroundStyle(.primaryGray)
                            .font(.system(size: 10, weight: .regular))
                    }
                    
                } // -> VStack
                
                Spacer()
                    .frame(width: 50)
                
                Button {
                    
                    showSheet.toggle()
                    
                } label: {
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.secondaryPurple)
                            .frame(width: 55, height: 30)
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.accent)
                        
                    } // -> ZStack
                    
                } // -> Button
                
            } // -> HStack
            
        } // -> ZStack
        
    } // -> body
    
} // -> GoalCard

#Preview {
    GoalCard(viewModel: GoalModel(), showSheet: .constant(false))
} // -> Preview
