//
//  Dog.swift
//  hw6sol
//
//  Created by Andy Huang on 3/8/23.
//

import Foundation

/* This is a model or "blueprint" for the JSON data that we will receive from the api! */
struct Dog: Codable {
    let message: String
    let status: String
}
