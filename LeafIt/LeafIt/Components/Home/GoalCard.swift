//
//  GoalCard.swift
//  LeftIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct GoalCard: View {
    
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
                
                BookIcon()
                
                VStack(alignment: .leading) {
                    
                    Text("Year Goal Progress")
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 15, weight: .medium))
                    
                    Text("6/12 books")
                        .foregroundStyle(.primaryGray)
                        .font(.system(size: 10, weight: .regular))
                    
                } // -> VStack
                
                Spacer()
                    .frame(width: 50)
                
                Button {
                    
                    // ACTION
                    
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
    GoalCard()
} // -> Preview
