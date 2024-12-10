//
//  Carousel.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct Carousel: View {
    
    @StateObject var storeCarImg = StoreCarImg()
    @State private var centerImg = 0.0
    @State private var draggingImg = 0.0
    
    var body: some View {
        
        ZStack {
            
            ForEach(storeCarImg.img) { img in
                
                ZStack {
                    
                    VStack {
                        
                        Image(img.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            ) // -> clipShape
                            .shadow(
                                radius: 4,
                                y: 4
                            )
                        
                        VStack {
                            
                            if xOffset(img.id) == 0 {
                                
                                HStack {
                                    
                                    Text("\(img.progress)%")
                                        .foregroundStyle(.accent)
                                        .font(.system(size: 10, weight: .semibold))
                                        .frame(width: 30, height: 7)
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 148, height: 7)
                                        .foregroundStyle(.secondaryGray)
                                        .overlay(
                                            
                                            HStack {
                                                
                                                Spacer()
                                                    .frame(width: Double(img.progress) * 1.48 > 141.0 ? 7 : 0)
                                                
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: Double(img.progress) * 1.48, height: 7)
                                                    .foregroundStyle(.accent)
                                                
                                                Spacer()
                                                
                                            } // -> HStack
                                            
                                        ) // -> overlay
                                    
                                }
                                
                                Spacer()
                                    .frame(height: 10)
                                
                                Button {
                                    
                                    // ACTION
                                    
                                } label: {
                                    
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundStyle(.accent)
                                            .frame(width: 75, height: 30)
                                        
                                        Text("Continue")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 10, weight: .semibold))
                                        
                                    } // -> ZStack
                                    
                                } // -> Button
                                
                            } // -> if
                            
                        } // -> HStack
                        .frame(width: 178, height: 50)
                        
                    } // -> VStack
                    
                } // -> ZStack
                .frame(width: 180, height: 350)
                .scaleEffect(max(0.25, 1.0 - abs(distance(img.id)) * 0.25 ))
                .offset(x: xOffset(img.id), y: 0)
                .zIndex(1.0 - abs(distance(img.id)) * 0.1)
                .onTapGesture {
                    withAnimation {
                        draggingImg = Double(img.id)
                    } // -> withAnimation
                } // -> onTapGesture
                
            } // -> ForEach
            
        } // -> ZStack
        .gesture(customDragGesture())
        
    } // -> body
    
    private func customDragGesture() -> some Gesture {
        
        DragGesture()
            .onChanged { value in
                draggingImg = centerImg + value.translation.width / 100
            } // -> onChanged
            .onEnded { value in
                
                withAnimation {
                    
                    draggingImg = centerImg + value.predictedEndTranslation.width / 100
                    draggingImg = round(draggingImg).remainder(dividingBy: Double(storeCarImg.img.count))
                    centerImg = draggingImg
                    
                } // -> withAnimation
                
            } // -> onEnded
        
    } // -> customDragGesture
    
    func distance(_ idImg: Int) -> Double {
        return (draggingImg - Double(idImg)).remainder(dividingBy: Double(storeCarImg.img.count))
    } // -> distance

    func xOffset(_ idImg: Int) -> Double {
        let angle = Double.pi * 1.5 / 8.5 * distance(idImg)
        return sin(angle) * 200
    } // -> distance
    
}

#Preview {
    Carousel()
} // -> Preview
