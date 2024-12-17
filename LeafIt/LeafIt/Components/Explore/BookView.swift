//
//  BookView.swift
//  Biblio
//
//  Created by AKSHAY MAHAJAN on 2023-04-16.
//

import SwiftUI

struct BookView: View {
    
    var book: Book
    
    @State private var expanded: Bool = false
    @State var showSheet: Bool = false
    
    private var title: String { book.volumeInfo?.title ?? ""}
    private var authors: [String] { book.volumeInfo?.authors ?? []}
    private var description: String { book.volumeInfo?.description ?? ""}
    private var thumbnail: String { book.volumeInfo?.imageLinks?.thumbnail ?? "" }
    private var pageCount: Int { book.volumeInfo?.pageCount ?? 0 }
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 10) {
                
                AsyncImage(url: URL(string: thumbnail.replacingOccurrences(of: "http://", with: "https://"))) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                } // AsyncImage
                .frame(width: 175)
                .shadow(radius: 5)
                .padding()

                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Divider()
                
                HStack{
                    Text(authors.count > 1 ? "Authors:" : "Author:")
                        .fontWeight(.bold)
                    VStack(alignment: .leading) {
                        ForEach(authors, id: \.self) {author in
                            Text(author)
                        } // -> ForEach
                    } // -> Vstack
                } // -> HStack
                
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Description:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    Text(description)
                        .lineLimit(expanded ? nil : 5)
                    
                    Button(action: {
                        expanded.toggle()
                    }, label: {
                        Text(expanded ? "...read less" : "...read more")
                    }) // -> Button
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                } // VStack
                .padding()
                
                Divider()
                
                HStack {
                    Text("\(pageCount) pages")
                } // -> HStack
                
                Divider()
                
                Button("Add to list") {
                    showSheet.toggle()
                } // -> Button
                
            } // -> VStack
            
        } // -> ScrollView
        .font(.title3)
        .sheet(isPresented: $showSheet) {
            BookSheetView(showSheet: $showSheet, book: book)
                .presentationDetents([.medium,.large])
        }
        
    } // -> body
    
} // -> BookView

#Preview {
    BookView(book: SampleBook().sampleBook)
}
