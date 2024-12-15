//
//  SearchResult.swift
//  LeafIt
//
//  Created by Brenda Elena Saucedo Gonzalez on 15/12/24.
//

import SwiftUI

struct SearchResult: View {
    
    @Binding var books: [Book]
    
    @ObservedObject var viewModel: BookSearchModel
    
    let rows = [
        GridItem(.flexible(), spacing: 50),
        GridItem(.flexible(), spacing: 50),
        GridItem(.flexible(), spacing: 50)
    ]
    
    
    @State private var contentOffset: CGFloat = 0
    @State private var auxContentOffset: CGFloat = -800
    @State private var incrementAuxContentOffset: CGFloat = 1
    
    var body: some View {
        
        ObservableScrollView(contentOffset: $contentOffset) {
                
                LazyVGrid(columns: rows, spacing: 20) {
                    
                    ForEach(books, id: \.id) { book in
                        
                        NavigationLink {
                            BookView(book: book)
                        } label: {
                            
                            VStack {
                                
                                AsyncImage(url: URL(string: (book.volumeInfo?.imageLinks?.thumbnail ?? "").replacingOccurrences(of: "http://", with: "https://"))) { image in
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
                                
                                Text("\(book.volumeInfo?.title ?? "")")
                                    .foregroundStyle(.primaryBlack)
                                    .font(.system(size: 15, weight: .medium))
                                    .frame(width: 100, height: 19)
                                
                                Spacer()
                                    .frame(height: 0)
                                
                                Text("\((book.volumeInfo?.authors ?? []).joined(separator: ", "))")
                                    .foregroundStyle(.primaryBlack)
                                    .font(.system(size: 10, weight: .regular))
                                    .frame(width: 100, height: 25)
                                
                            }  // -> VStack
                            
                        }  // -> NavigationLink
                        
                    } // -> ForEach
                    
                } // -> LazyVGrid
                .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.vertical)
            }
            
        } // -> ScrollView
        .scrollIndicators(.hidden)
        .onChange(of: contentOffset) {
            print(contentOffset)
            if contentOffset < auxContentOffset {
                auxContentOffset -= 1300 // 2100
                viewModel.loadMoreBooks()
                print(contentOffset)
            }
        }
        
    } // -> body
    
} // -> SearchResult

#Preview {
    SearchResult(books: .constant([SampleBook().sampleBook, SampleBook().sampleBook]), viewModel: BookSearchModel())
}


struct ContentOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ObservableScrollView<Content: View>: View {
    let content: Content
    @Binding var contentOffset: CGFloat

    init(contentOffset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self._contentOffset = contentOffset
        self.content = content()
    }

    var body: some View {
        ScrollView {
            content
                .background {
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ContentOffsetKey.self, value: geometry.frame(in: .named("scrollView")).minY)
                    }
                }
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ContentOffsetKey.self) { value in
            self.contentOffset = value
        }
    }
}
