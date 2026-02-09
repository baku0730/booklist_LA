import SwiftUI

class BooksAPIClient: ObservableObject{
    @Published var books: BookResPonse?
    private let apiClient = APIClient()
    
    func fetchBooks(queryString: String){
        //APIのインターネット上の場所をURLで指定してその結果が受け取れるようになる
        Task{ @MainActor in
            self.books = await apiClient.fetchData(
                from: "https://www.googleapis.com/books/v1/volumes?q=\(queryString)",
                responseType: BookResPonse.self
            )
        }
    }
}
