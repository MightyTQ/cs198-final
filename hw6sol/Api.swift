
import Foundation

/* Returns a Dog optional type from calling the dogAPI and decoding the fetched JSON.
 
 Ex1 fetchDog() is able to get a valid response from API: fetchDog() -> Dog
 Ex2 fetchDog() is NOT able to get a valid response from API: fetchDog() -> nil
 */
func fetchDog() async -> Dog? {
    // Define url
    guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
        return nil
    }
    
    // Wrap api call inside a do/catch block in case an error is thrown.
    do {
        // Get data (the second item (URLResponse) we don't need so we'll just assign it to _).
        let (data, _) = try await URLSession.shared.data(from: url)
        // Decode JSON into a Dog struct.
        if let decodedResponse = try? JSONDecoder().decode(Dog.self, from: data) {
            return decodedResponse
        }
    } catch {
        // Handle api call error here.
        return nil
    }
    return nil
}


/* Continuously calls fetchDog() until a Dog is returned and returns that Dog. */
func fetchDoggy() async -> Dog {
    // Try to get a Dog
    var newDog = (await fetchDog()) ?? nil
    
    // Check if there is a Dog
    while (newDog == nil) {
        // Try again to get Dog
        newDog = (await fetchDog()) ?? nil
    }
    
    // Can force-unwrap because newDog is guaranteed a dog.
    return newDog!
}

func fetchGPT(input: String) async -> GPT? {
    // Define url
    guard let url = URL(string: "https://api.openai.com/v1/engines/davinci-codex/completions") else {
        return nil
    }
    
    var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.addValue("api key not shown for security reason", forHTTPHeaderField: "Authorization")
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let parameters = ["prompt": input, "max_tokens": "60", "n": "1", "stop": "\n"]
    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
       
    // Wrap api call inside a do/catch block in case an error is thrown.
    do {
        // Get data (the second item (URLResponse) we don't need so we'll just assign it to _).
        let (data, _) = try await URLSession.shared.data(for: request)
        // Decode JSON into a Dog struct.
        if let r = try? JSONDecoder().decode(GPT.self, from: data) {
            return r
        }
    } catch {
        // Handle api call error here.
        print(error)
        return nil
    }
    return nil
}

func fetchg(input: String) async -> GPT {
    // Try to get a Dog
    var newg = (await fetchGPT(input: input)) ?? nil
    
    // Check if there is a Dog
    while (newg == nil) {
        // Try again to get Dog
        newg = (await fetchGPT(input: input)) ?? nil
    }
    
    // Can force-unwrap because newDog is guaranteed a dog.
    return newg!
}
