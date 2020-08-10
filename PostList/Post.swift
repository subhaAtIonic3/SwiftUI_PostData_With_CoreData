//
//  Post.swift
//  PostList
//
//  Created by Subhrajyoti Chakraborty on 10/08/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
