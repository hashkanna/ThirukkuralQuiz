import SwiftUI

struct DailyQuizView: View {
    let kural: Thirukkural
    @Environment(\.dismiss) var dismiss
    @StateObject private var manager = DailyChallengeManager.shared
    @State private var selectedAnswer = ""
    @State private var isAnswerRevealed = false
    @State private var options: [String] = []
    @State private var missingWord = ""
    
    init(kural: Thirukkural) {
        self.kural = kural
        _options = State(initialValue: generateOptions(for: kural))
        _missingWord = State(initialValue: selectMissingWord(from: kural))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("தினசரி சவால்")
                .font(.custom("Tamil Sangam MN", size: 28))
                .fontWeight(.bold)
            
            VStack(alignment: .center, spacing: 8) {
                Text(kural.Line1.replacingOccurrences(
                    of: missingWord,
                    with: "_____"
                ))
                Text(kural.Line2.replacingOccurrences(
                    of: missingWord,
                    with: "_____"
                ))
            }
            .font(.custom("Tamil Sangam MN", size: 18))
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    checkAnswer(option)
                }) {
                    Text(option)
                        .font(.custom("Tamil Sangam MN", size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedAnswer == option ?
                                (option == missingWord ? Color.green : Color.red) :
                                Color.blue
                        )
                        .cornerRadius(10)
                }
                .disabled(selectedAnswer != "")
            }
            
            if isAnswerRevealed {
                VStack(spacing: 12) {
                    Text("பொருள்:")
                        .font(.custom("Tamil Sangam MN", size: 18))
                        .fontWeight(.bold)
                    Text(kural.mk)
                        .font(.custom("Tamil Sangam MN", size: 16))
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(10)
                
                Button("முடி") {
                    manager.completeDailyChallenge(score: selectedAnswer == missingWord ? 1 : 0)
                    dismiss()
                }
                .font(.custom("Tamil Sangam MN", size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .foregroundColor(.white)
    }
    
    private func checkAnswer(_ answer: String) {
        withAnimation {
            selectedAnswer = answer
            isAnswerRevealed = true
        }
    }
}

// Helper functions
private func generateOptions(for kural: Thirukkural) -> [String] {
    let missingWord = selectMissingWord(from: kural)
    var options = [missingWord]
    
    while options.count < 3 {
        if let randomKural = ThirukkuralDatabase.shared.getRandomKurals(1).first {
            let words = (randomKural.Line1 + " " + randomKural.Line2)
                .components(separatedBy: " ")
            if let word = words.randomElement(),
               !options.contains(word) {
                options.append(word)
            }
        }
    }
    
    return options.shuffled()
}

private func selectMissingWord(from kural: Thirukkural) -> String {
    let words = (kural.Line1 + " " + kural.Line2)
        .components(separatedBy: " ")
    let randomIndex = Int.random(in: 0..<words.count)
    return words[randomIndex]
} 