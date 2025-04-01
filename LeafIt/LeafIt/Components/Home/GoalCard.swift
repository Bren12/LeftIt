//
//  GoalCard.swift
//  LeftIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct GoalCard: View {
    
    @Binding var showSheet: Bool
    @State var setGoal: Bool = false // HardCode
    
    var body: some View {
            
        HStack {
            
            Spacer()
                .frame(width: 10)
            
            BookIcon()
            
            VStack(alignment: .leading) {
                
                Text("Goal Progress")
                    .foregroundStyle(.primaryBlack)
                    .font(.system(size: 15, weight: .medium))
                
                // MARK: CONDITION - IS GOAL SET?
                if setGoal {
                    Text("\(1) / \(10) books")
                        .foregroundStyle(.primaryGray)
                        .font(.system(size: 10, weight: .regular))
                } else {
                    Text("Let’s set a new goal!")
                        .foregroundStyle(.primaryGray)
                        .font(.system(size: 10, weight: .regular))
                } // -> if-else
                
            } // -> VStack
            
            Spacer()
            
            // MARK: SET/EDIT GOAL
            Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "square.and.pencil")
                    .foregroundStyle(.accent)
                    .padding(.horizontal, 17.5)
                    .padding(.vertical, 7.5)
                    .background(.secondaryPurple)
                    .cornerRadius(5)
            } // -> Button
            
            Spacer()
                .frame(width: 10)
            
        } // -> HStack
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(
            radius: 4,
            y: 4
        ) // -> HStack.shadow
        
    } // -> body
    
} // -> GoalCard

#Preview {
    GoalCard(showSheet: .constant(false))
} // -> Preview
