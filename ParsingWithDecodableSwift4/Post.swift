//
//  Post.swift
//  WebServices
//
//  Created by Gabriel Jaramillo on 5/21/18.
//  Copyright © 2018 Gabriel Jaramillo. All rights reserved.
//
import Foundation

struct Post: Decodable {

    //Your Struct should Implement Decodable, and have the same keys than your JSONResponse
    //usually the Optional Question Mark, is to prevent if some of the keys do not exists
    //then Decodable avoids the parsing and prevent the Crash.
    
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    
}
