//
//  DetailView.swift
//  PostList
//
//  Created by Subhrajyoti Chakraborty on 10/08/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let postBody: String
    let totalData: Int
    let postId: Int
    
    var body: some View {
        VStack {
            Text("\(postBody)")
        }
        .navigationBarTitle("\(postId)/\(totalData)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(postBody: "Test Body", totalData: 10, postId: 1)
    }
}
