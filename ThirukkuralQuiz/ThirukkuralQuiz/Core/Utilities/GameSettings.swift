import Foundation

class GameSettings: ObservableObject {
    @Published var difficulty: Difficulty = .medium
    @Published var questionCount: Int = 5
    @Published var showTranslation: Bool = true
    @Published var soundEnabled: Bool = true
    @Published var hapticEnabled: Bool = true
    
    enum Difficulty: String, CaseIterable {
        case easy = "எளிது"
        case medium = "நடுத்தரம்"
        case hard = "கடினம்"
        
        var wrongOptionsCount: Int {
            switch self {
            case .easy: return 2
            case .medium: return 3
            case .hard: return 4
            }
        }
    }
} 