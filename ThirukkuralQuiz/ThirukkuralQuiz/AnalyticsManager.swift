import Foundation

enum AnalyticsEvent {
    case gameStarted(difficulty: GameSettings.Difficulty)
    case gameCompleted(score: Int, total: Int)
    case achievementUnlocked(achievement: GameProgress.Achievement)
    case settingsChanged
    case helpViewed
    
    var name: String {
        switch self {
        case .gameStarted: return "game_started"
        case .gameCompleted: return "game_completed"
        case .achievementUnlocked: return "achievement_unlocked"
        case .settingsChanged: return "settings_changed"
        case .helpViewed: return "help_viewed"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .gameStarted(let difficulty):
            return ["difficulty": difficulty.rawValue]
        case .gameCompleted(let score, let total):
            return ["score": score, "total": total, "percentage": Double(score)/Double(total)]
        case .achievementUnlocked(let achievement):
            return ["achievement": achievement.rawValue]
        case .settingsChanged, .helpViewed:
            return [:]
        }
    }
}

class AnalyticsManager {
    static let shared = AnalyticsManager()
    
    func logEvent(_ event: AnalyticsEvent) {
        // Implement Firebase or other analytics here
        print("Analytics Event: \(event.name), Parameters: \(event.parameters)")
    }
} 