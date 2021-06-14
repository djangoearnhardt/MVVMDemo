//
//  Course.swift
//  MVC Starter
//
//  Created by David on 2/10/21.
//

import Foundation

struct Course: Decodable {
    let id: Int
    let name: String
    let numberOfLessons: Int
}
