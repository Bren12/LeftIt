//
//  Carousel.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 09/12/24.
//

import SwiftUI

struct Carousel: View {
    
    @ObservedObject var viewModel: CarouselStoreModel
    @ObservedObject var observedModel: GoalModel
    
    @Binding var showSheet: Bool
    @Binding var bookGB: String
    
    @State private var bookIndex: Int = 0
    @State private var centerImg = 0.0
    @State private var draggingImg = 0.0
    @State private var showView = false
    
    var body: some View {
        
        ZStack {
            
            ForEach(viewModel.books, id: \.id) { book in
                
                ZStack {
                    
                    VStack {
                        
                        // MARK: PICTURE
                        AsyncImage(url: URL(string: book.book.photoUrl!.replacingOccurrences(of: "http://", with: "https://"))) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                ) // -> clipShape
                                .shadow(
                                    radius: 4,
                                    y: 4
                                )
                        } placeholder: {
                            ProgressView()
                        } // -> AsyncImage
//                        .onTapGesture {
//                            if xOffset(book.id) == 0 {
//                                bookIndex = book.id
//                                showView.toggle()
//                            }
//                        }
                        
                        // MARK: PROGRESS
                        
                        VStack {
                            
                            if xOffset(book.id) == 0 {
    
                                HStack {
    
                                    Text("\(book.book.progress ?? 0)%")
                                        .foregroundStyle(.accent)
                                        .font(.system(size: 10, weight: .semibold))
                                        .frame(width: 30, height: 7)
    
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 148, height: 7)
                                        .foregroundStyle(.secondaryGray)
                                        .overlay(

                                            HStack {
    
                                                Spacer()
                                                    .frame(width: Double(book.book.progress ?? 0) * 1.48 > 141.0 ? 7 : 0)

                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: Double(book.book.progress ?? 0) * 1.48, height: 7)
                                                    .foregroundStyle(.accent)

                                                Spacer()

                                            } // -> HStack

                                        ) // -> overlay
    
                                    } // -> HStack
    
                                    Spacer()
                                        .frame(height: 10)
                                
                                    // MARK: BUTTON CONTINUE
    
                                    Button {
                                        bookGB = book.book.bookGb
                                        showSheet.toggle()
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
                            
                        } // -> VStack
                        .frame(width: 178, height: 50)
                        
                    } // -> VStack
                    
                } // -> ZStack
                .frame(width: 180, height: 350)
                .scaleEffect(
                    max(0.25, 1.0 - abs(distance(book.id)) * 0.25 )
                ) // -> scaleEffect
                .offset(
                    x: xOffset(book.id),
                    y: 0
                ) // -> offset
                .zIndex(
                    1.0 - abs(distance(book.id)) * 0.1
                ) // -> zIndex
                .onTapGesture {
                    withAnimation {
                        draggingImg = Double(book.id)
                    } // -> withAnimation
                } // -> onTapGesture
                
//                NavigationLink(destination: BookView(
//                    book: Book(id: observedModel.books![bookIndex].bookGb, volumeInfo: VolumeInfo(
//                        title: observedModel.books![bookIndex].title!,
//                        authors: observedModel.books![bookIndex].authors,
//                        description: observedModel.books![bookIndex].description,
//                        pageCount: observedModel.books![bookIndex].pages,
//                        imageLinks: ImageLinks(thumbnail: observedModel.books![bookIndex].photoUrl)
//                    ))),
//                               isActive: $showView
//                ) {
//                    EmptyView()
//                } // -> NavigationLink
                
            } // -> ForEach
            
        } // -> ZStack
        .gesture(customDragGesture(books: viewModel.books.count))
        
    } // -> body
    
    private func customDragGesture(books: Int) -> some Gesture {
        
        DragGesture()
            .onChanged { value in
                draggingImg = books <= 1 ? centerImg : centerImg + value.translation.width / 100
            } // -> onChanged
            .onEnded { value in
                
                withAnimation {
                    
                    draggingImg = centerImg + value.predictedEndTranslation.width / 100
                    draggingImg = round(draggingImg).remainder(dividingBy: Double(viewModel.books.count))
                    centerImg = draggingImg
                    
                } // -> withAnimation
                
            } // -> onEnded
        
    } // -> customDragGesture
    
    func distance(_ idBook: Int) -> Double {
        return (draggingImg - Double(idBook)).remainder(dividingBy: Double(viewModel.books.count))
    } // -> distance

    func xOffset(_ idBook: Int) -> Double {
        let angle = Double.pi * 1.5 / 8.5 * distance(idBook)
        return sin(angle) * 200
    } // -> distance
    
} // -> CarouselView

#Preview {
    Carousel(viewModel: CarouselStoreModel(), observedModel: GoalModel(), showSheet: .constant(false), bookGB: .constant(""))
} // -> Preview
