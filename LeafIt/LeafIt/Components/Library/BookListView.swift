//
//  BookListView.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import SwiftUI

@MainActor
final class BookLoadModel: ObservableObject {
    
    @Published private(set) var books: [DBBook]? = nil
    
    func getBooks(listID: String) {
        Task {
            self.books = try await BookManager.shared.getBooksList(forListId: listID)
        }
    } // -> getBooks
    
} // -> LibraryModel

struct BookListView: View {
    
    @StateObject private var viewModel = BookLoadModel()
    
    var list: String
    
    let rows = [
        GridItem(.flexible(), spacing: 50),
        GridItem(.flexible(), spacing: 50),
        GridItem(.flexible(), spacing: 50)
    ]
    
    var body: some View {
        
        ScrollView {
                
                LazyVGrid(columns: rows, spacing: 20) {
                    
                    if let books = viewModel.books {
                    
                    ForEach(books, id: \.bookId) { book in
                            
                            NavigationLink {
                                BookView(book: Book(id: book.bookId!, volumeInfo: VolumeInfo(title: book.title!, authors: book.authors, description: book.description, pageCount: book.pages, imageLinks: ImageLinks(thumbnail: book.photoUrl))))
                            } label: {
                                
                                VStack {
                                    
                                    AsyncImage(url: URL(string: (book.photoUrl ?? "").replacingOccurrences(of: "http://", with: "https://"))) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                            ) // -> clipShape
                                    } placeholder: {
                                        ProgressView()
                                    } // -> AsyncImage
                                    .frame(width: 100, height: 150)
                                    
                                    Text("\(book.title ?? "")")
                                        .foregroundStyle(.primaryBlack)
                                        .font(.system(size: 15, weight: .medium))
                                        .frame(width: 100, height: 19)
                                    
                                    Spacer()
                                        .frame(height: 0)
                                    
                                    Text("\((book.authors ?? []).joined(separator: ", "))")
                                        .foregroundStyle(.primaryBlack)
                                        .font(.system(size: 10, weight: .regular))
                                        .frame(width: 100, height: 25)
                                    
                                }  // -> VStack
                                
                            }  // -> NavigationLink
                            
                        } // -> ForEach
                        
                    } // -> if
                    
                } // -> LazyVGrid
                .padding(.horizontal)
            
        } // -> ScrollView
        .scrollIndicators(.hidden)
        .task {
            viewModel.getBooks(listID: list)
        }
        
    } // -> body
    
} // -> BookListView

#Preview {
    BookListView(list: "")
} // -> Preview
