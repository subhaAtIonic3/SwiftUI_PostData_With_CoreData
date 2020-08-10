//
//  ContentView.swift
//  PostList
//
//  Created by Subhrajyoti Chakraborty on 10/08/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var postData = PostData()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Posts.entity(), sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)]) var posts: FetchedResults<Posts>
    
    func loadData() {
        if posts.count == 0 {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            var request = URLRequest(url: url)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    print("Unable to fetch data \(error?.localizedDescription ?? "due to some error")")
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode([Post].self, from: data) {
                    print("Successfully decode the posts data")
                    DispatchQueue.main.async {
                        self.postData.posts = decodedData
                        self.saveData(posts: self.postData.posts)
                    }
                } else {
                    print("Unable to decode data")
                }
            }.resume()
        } else {
            return
        }
    }
    
    func saveData(posts: [Post]) {
        for post in posts {
            let postObject = Posts(context: self.moc)
            postObject.id = Int16(post.id)
            postObject.userId = Int16(post.userId)
            postObject.title = post.title
            postObject.body = post.body
        }
        
        if self.moc.hasChanges {
            try? self.moc.save()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(posts, id: \.id) { post in
                    NavigationLink(destination: DetailView(postBody: post.body ?? "Unknown", totalData: self.posts.count, postId: Int(post.id) )) {
                        Text("\(post.title ?? "Unknown")")
                    }
                }
            }
            .navigationBarTitle("Posts")
        }
        .onAppear(perform: loadData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class PostData: ObservableObject {
    @Published var posts =  [Post]()
}
