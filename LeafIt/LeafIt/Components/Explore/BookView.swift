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
        
        ZStack {
            
            Color.primaryWhite
            
            ScrollView {
                
                VStack {
                    
                    Spacer()
                        .frame(height: 125)
                    
                    AsyncImage(url: URL(string: thumbnail.replacingOccurrences(of: "http://", with: "https://"))) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            ) // -> clipShape
                    } placeholder: {
                        ProgressView()
                    } // AsyncImage
                    .frame(width: 175)
                    .shadow(radius: 5)
                    
                    Divider()
                    
                    Text(title)
                        .foregroundStyle(.primaryBlack)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    Divider()
                    
                    HStack{
                        VStack {
                            Text(authors.count > 1 ? "Authors:" : "Author:")
                                .foregroundStyle(.primaryBlack)
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                        } // -> VStack
                        VStack(alignment: .leading) {
                            ForEach(authors, id: \.self) {author in
                                Text(author)
                                    .foregroundStyle(.primaryBlack)
                                    .font(.system(size: 20, weight: .regular))
                            } // -> ForEach
                        } // -> Vstack
                        Spacer()
                    } // -> HStack
                    
                    Divider()
                    
                    VStack(spacing: 3) {
                        
                        HStack {
                            Text("Description:")
                                .foregroundStyle(.primaryBlack)
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                        } // -> HStack
                        
                        Text(description)
                            .foregroundStyle(.primaryBlack)
                            .font(.system(size: 18, weight: .regular))
                            .lineLimit(expanded ? nil : 5)
                        
                        if description.count > 200 {
                            HStack {
                                Spacer()
                                Button(action: {
                                    expanded.toggle()
                                }, label: {
                                    Text(expanded ? "...read less" : "...read more")
                                }) // -> Button
                            } // -> HStack
                        } // -> if
                        
                    } // VStack
                    
                    Divider()
                    
                    HStack {
                        Text("Pages:")
                            .foregroundStyle(.primaryBlack)
                            .font(.system(size: 20, weight: .bold))
                        + Text(" \(pageCount)")
                            .foregroundStyle(.primaryBlack)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                    } // -> HStack
                    
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        showSheet.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.accent)
                                .frame(height: 40)
                            Text("Add Book")
                                .foregroundStyle(.primaryWhite)
                                .font(.system(size: 15, weight: .semibold))
                        } // -> ZStack
                    }// -> Button
                    
                } // -> VStack
                .frame(width: 350)
                
                Spacer()
                    .frame(height: 100)
                
            } // -> ScrollView
            
        } // -> ZSStack
        .ignoresSafeArea()
        .sheet(isPresented: $showSheet) {
            BookSheetView(showSheet: $showSheet, book: book)
                .presentationDetents([.large])
        }
        
    } // -> body
    
} // -> BookView

#Preview {
    BookView(book: SampleBook().sampleBook)
}
