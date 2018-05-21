//
//  Endpoints.swift
//  WebServices
//
//  Created by Gabriel Jaramillo on 5/20/18.
//  Copyright © 2018 Gabriel Jaramillo. All rights reserved.
//

import Foundation

//This Struct is basically to call the urls that you may need to perform some actions.
//If you wanna do GET Request i recommend to use the concat of: url+allPosts
//which basically will be like this: Endpoints.url.rawValue+Endpoints.allPosts.rawValue

enum Endpoints:String {
    case allPosts = "/posts"
    case singlePost = "/posts/1"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
    case putDeleteRequest = "https://jsonplaceholder.typicode.com/posts/1"
    case url = "https://jsonplaceholder.typicode.com"
}
