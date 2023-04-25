//
//  File.swift
//  hw6sol
//
//  Created by 屈宸毅 on 4/24/23.
//

import Foundation

/* This is a model or "blueprint" for the JSON data that we will receive from the api! */
struct GPT: Codable {
    let text: String
}
