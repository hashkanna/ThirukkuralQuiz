import SwiftUI

struct DailyChallengeView: View {
    @StateObject private var manager = DailyChallengeManager.shared
    @State private var showingQuiz = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("இன்றைய சவால்")
                .font(.custom("Tamil Sangam MN", size: 28))
                .fontWeight(.bold)
            
            if manager.hasCompletedToday {
                VStack(spacing: 15) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.green)
                    
                    Text("இன்றைய சவால் முடிந்தது!")
                        .font(.custom("Tamil Sangam MN", size: 20))
                    
                    Text("தொடர்ச்சி: \(manager.currentStreak) நாட்கள்")
                        .font(.custom("Tamil Sangam MN", size: 18))
                        .foregroundColor(.white.opacity(0.8))
                }
            } else {
                VStack(spacing: 15) {
                    Image(systemName: "star.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.yellow)
                    
                    Text("புதிய சவால் காத்திருக்கிறது!")
                        .font(.custom("Tamil Sangam MN", size: 20))
                    
                    Button("தொடங்கு") {
                        showingQuiz = true
                    }
                    .font(.custom("Tamil Sangam MN", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(30)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .foregroundColor(.white)
        .sheet(isPresented: $showingQuiz) {
            if let kural = manager.dailyKural {
                DailyQuizView(kural: kural)
            }
        }
    }
} 