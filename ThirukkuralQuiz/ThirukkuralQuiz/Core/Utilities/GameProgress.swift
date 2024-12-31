import Foundation

class GameProgress: ObservableObject {
    @Published var totalGamesPlayed: Int = 0
    @Published var highScore: Int = 0
    @Published var achievements: Set<Achievement> = []
    @Published var completedKurals: Set<Int> = []
    
    enum Achievement: String, CaseIterable {
        case firstPerfectScore = "முதல் முழு மதிப்பெண்"
        case tenGamesPlayed = "10 விளையாட்டுகள்"
        case hundredKurals = "100 குறள்கள்"
        case hardModeMaster = "கடின நிலை வெற்றி"
        
        var description: String {
            switch self {
            case .firstPerfectScore: return "ஒரு விளையாட்டில் அனைத்து கேள்விகளுக்கும் சரியான விடை"
            case .tenGamesPlayed: return "10 விளையாட்டுகளை முடித்தல்"
            case .hundredKurals: return "100 வெவ்வேறு குறள்களை கற்றல்"
            case .hardModeMaster: return "கடின நிலையில் முழு மதிப்பெண் பெறுதல்"
            }
        }
    }
    
    func checkAndUpdateAchievements(score: Int, totalQuestions: Int, difficulty: GameSettings.Difficulty) {
        if score == totalQuestions {
            achievements.insert(.firstPerfectScore)
            if difficulty == .hard {
                achievements.insert(.hardModeMaster)
            }
        }
        
        totalGamesPlayed += 1
        if totalGamesPlayed >= 10 {
            achievements.insert(.tenGamesPlayed)
        }
        
        if completedKurals.count >= 100 {
            achievements.insert(.hundredKurals)
        }
        
        if score > highScore {
            highScore = score
        }
    }
} 