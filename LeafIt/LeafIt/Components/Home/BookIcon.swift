//
//  BookIcon.swift
//  LeftIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct BookIcon: View {
    
    @ObservedObject var viewModel: GoalModel
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .foregroundStyle(.secondaryPurple)
            
            VStack {
                
                ZStack {
                    
                    Image(.openBook)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        
                        HStack(spacing: 5) {
                            
                            Image(.fire)
                                .resizable()
                                .scaledToFit()
                            
                            Divider()
                            
                            Text("\(viewModel.user?.streak ?? 0)")
                                .foregroundStyle(.primaryBlack)
                            
                        } // -> HStack
                        .frame(height: 17)
                        
                        Spacer()
                            .frame(height: 4)
                        
                    } // -> VStack
                    
                } // -> ZStack
                
            } // -> VStack
            
        } // -> ZStack
        .frame(width: 50, height: 50)
        
    } // -> body
    
} // -> BookIcon

#Preview {
    BookIcon(viewModel: GoalModel())
} // -> Preview
