//
//  BookListView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import SwiftUI

//struct BookListView: View {
//    
//    @ObservedObject var viewModel: LibraryModel
//    
//    let rows = [
//        GridItem(.flexible(), spacing: 50),
//        GridItem(.flexible(), spacing: 50),
//        GridItem(.flexible(), spacing: 50)
//    ]
//    
//    var body: some View {
//        
//        ScrollView {
//                
//                LazyVGrid(columns: rows, spacing: 20) {
//                    
//                    ForEach(books, id: \.id) { book in
//                        
//                        NavigationLink {
//                            BookView(book: book)
//                        } label: {
//                            
//                            VStack {
//                                
//                                AsyncImage(url: URL(string: (book.volumeInfo?.imageLinks?.thumbnail ?? "").replacingOccurrences(of: "http://", with: "https://"))) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFit()
//                                        .clipShape(
//                                            RoundedRectangle(cornerRadius: 10)
//                                        ) // -> clipShape
//                                } placeholder: {
//                                    ProgressView()
//                                } // -> AsyncImage
//                                .frame(width: 100, height: 150)
//                                
//                                Text("\(book.volumeInfo?.title ?? "")")
//                                    .foregroundStyle(.primaryBlack)
//                                    .font(.system(size: 15, weight: .medium))
//                                    .frame(width: 100, height: 19)
//                                
//                                Spacer()
//                                    .frame(height: 0)
//                                
//                                Text("\((book.volumeInfo?.authors ?? []).joined(separator: ", "))")
//                                    .foregroundStyle(.primaryBlack)
//                                    .font(.system(size: 10, weight: .regular))
//                                    .frame(width: 100, height: 25)
//                                
//                            }  // -> VStack
//                            
//                        }  // -> NavigationLink
//                        
//                    } // -> ForEach
//                    
//                } // -> LazyVGrid
//                .padding(.horizontal)
//            
//            if viewModel.isLoading {
//                ProgressView()
//                    .padding(.vertical)
//            }
//            
//        } // -> ScrollView
//        .scrollIndicators(.hidden)
//        
//    } // -> body
//    
//} // -> BookListView

//#Preview {
//    BookListView(viewModel: LibraryModel())
//} // -> Preview
