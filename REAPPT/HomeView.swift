import SwiftUI

struct Video {
    var id: Int
    var title: String
    var url: URL
}

let exampleVideo = Video(id: 1, title: "Example Video", url: URL(string: "https://example.com/video.mp4")!)

struct VideoListView: View {
    var videos: [Video]

    var body: some View {
        List(videos, id: \.id) { video in
            Text(video.title)
        }
    }
}

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, isSearching: $isSearching)
                    .padding(.top)
                
                if isSearching {
                    // Hier kannst du die Suchergebnisse anzeigen
                    Text("Suchergebnisse für: \(searchText)")
                        .padding()
                } else {
                    VStack {
                        Text("Feed")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        // Hier kannst du den Feed mit den Videos anzeigen
                        VideoListView(videos: [exampleVideo])
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Suche", text: $text)
                .padding(.leading, 24)
            
            Button(action: {
                withAnimation {
                    isSearching.toggle()
                    if !isSearching {
                        text = ""
                    }
                }
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.primary)
            }
            .padding(.trailing, 8)
        }
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding()
    }
}
