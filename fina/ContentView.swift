
import SwiftUI

struct ContentView: View {
    // The dog's breed
    @State var dogBreed: String = ""
    // URL of image from API call
    @State var imageURL: String = ""
    // User's input
    @State var user_guess: String = "how are you?"
    // User's streak for the current run
    @State var streak: Int = 10
    // True when user has made an incorrect guess, false otherwise.
    @State var incorrectGuess: Bool = false
    
    @State var answer: String = ""
    
    // Colors!
    let lightBlue = Color(red: 135/255, green: 206/255, blue: 250/255)
    let lavender = Color(red: 220/255, green: 208/255, blue: 255/255)
    
    var body: some View {
        ZStack {
            // Gradient in background
            LinearGradient(gradient: Gradient(colors: [lightBlue, lavender]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // VStack in foreground
            VStack {
                Text("Chat with GPT")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Text("Available calls: \(streak)")
                        .foregroundColor(.white)
                    Spacer()
                }
                
                .padding(.horizontal, 110)
                .padding(.bottom, 60)
                
                // Load the image of the dog asyncronously.
                AsyncImage(url: URL(string: imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 256, height: 256)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 256, height: 256)
                
                // Textfield for user input.
                TextField("", text: $user_guess)
                    .disableAutocorrection(true)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 50)
                    .onSubmit {
                        // Increment score by 1 and update high score.
                        
                        if (user_guess.lowercased() == "saoowpasa") {
                            // Update streak
                            streak -= 1
                            
                            Task {
                                let g = await fetchg(input: user_guess)
                                answer = g.text
                            }
                            
                            // Get new dog
                            Task {
                                let newDog = await fetchDoggy()
                                imageURL = newDog.message
                                dogBreed = getDogName(imageURL: newDog.message)
                            }
                        } else {
                            incorrectGuess.toggle()
                        }
                        
                        // Clear guess
                        user_guess = ""
                    }
                
                // Submit Guess
                Button("Submit your question") {
                    // Increment score by 1 and update high score.
                    if (user_guess.lowercased() == dogBreed.lowercased()) {
                        // Update streak
                        streak -= 1
                        
                        // Get new dog here, so they can still see dog in background after losing.
                        Task {
                            let g = await fetchg(input: user_guess)
                            answer = g.text
                        }
                        
                        Task {
                            let newDog = await fetchDoggy()
                            dogBreed = getDogName(imageURL: newDog.message)
                            imageURL = newDog.message
                        }
                    } else {
                        incorrectGuess.toggle()
                    }
                    
                    // Clear guess
                    user_guess = ""
                }
                .padding()
                .alert("You just used one API call", isPresented: $incorrectGuess) {
                    Button("Ask again", role: .cancel) {
                        // Reset streak
                        streak -= 1
                        
                        Task {
                            let g = await fetchg(input: user_guess)
                            answer = g.text
                        }
                        
                        // Get a new dog
                        Task {
                            let newDog = await fetchDoggy()
                            imageURL = newDog.message
                            dogBreed = getDogName(imageURL: newDog.message)
                        }
                    }
                } message: {
                    Text("\(answer)\nYour have \(streak) more calls!")
                }
                
                Spacer()
                Spacer()
                
                // Answer for debugging/testing purposes.
                Text("\(answer)")
            }
            .task {
                // Get dog upon loading the app.
                let g = await fetchg(input: user_guess)
                answer = g.text
                
                let newDog = await fetchDoggy()
                dogBreed = getDogName(imageURL: newDog.message)
                imageURL = newDog.message
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


