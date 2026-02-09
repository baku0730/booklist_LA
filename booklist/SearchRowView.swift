//
//  SearchRowView.swift
//  booklist
//
//  Created by シング　シュバクシ on 2026/02/09.
//

import SwiftUI

struct SearchRowView: View {
    @State var isSaved: Bool = false
    let imageUrl: String?
    let title: String?
    let publisher: String?
    
    var body: some View {
        HStack{
            if let thumbnailUrl = imageUrl {
                //AsyncImageを使うとurl経由で画像を取得することができる
                AsyncImage(url: URL(string: thumbnailUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
            }
            
            VStack(alignment: .leading){
                Text(title ?? "")
                    .font(.headline)
                    .bold()
                Text(publisher ?? "")
                    .font(.caption)
            }
            
            Spacer()
            
            Button(action:{
                guard !isSaved else { return }
                let newBook = BookSammary(id: UUID().uuidString, title: title ?? "", thumbnail: imageUrl)
                SwiftDataManager().saveItem(data: newBook)
                isSaved = true
            }, label: {
                Image(systemName: isSaved ? "checkmark.circle.fill" : "plus.circle")
            })
            .buttonStyle(PlainButtonStyle())
        }
        .frame(minHeight: 100)
    }
}

#Preview {
    SearchRowView(
        imageUrl: sampleImageUrl,
        title: "本のタイトル",
        publisher: "出版社"
    )
}
