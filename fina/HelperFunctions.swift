

import Foundation

/* Returns a string of the dogs breed given the dogapi's response message as a string.
 
 Ex: getDogName(imageURL: "https://images.dog.ceo/breeds/terrier-silky/n02097658_9136.jpg") -> "terrier"
 */
func getDogName(imageURL: String) -> String {
    let dogName = imageURL.split(separator: "/")[3]
    if (dogName.contains("-")) {
        let split = dogName.split(separator: "-")
        
        // If you want more specific dog breeds: return "\(split[1]) \(split[0])"
        return "\(split[0])"
    }
    return String(dogName)
}


/* Returns a string of space-separated underscores per character in the input string.
 The first and last characters of the input string are revealed.
 
 Ex: generateHint(input: "hello world!") -> "h _ _ _ _   _ _ _ _ _ !"
 */
func generateHint(input: String) -> String {
    var hintString = ""
    
    // Build hint
    var i = 0
    let len = input.count
    for char in input {
        // First and last characters are revealed.
        if (i == 0) {
            hintString.append("\(char) ")
        } else if (i == (len - 1)) {
            hintString.append(char)
        } else if (char == " ") {
            hintString.append("   ")
        } else {
            hintString.append("_ ")
        }
        i += 1
    }
    
    // Return the hint.
    return hintString
}
