
import Foundation

/* This is a model or "blueprint" for the JSON data that we will receive from the api! */
struct Dog: Codable {
    let message: String
    let status: String
}
