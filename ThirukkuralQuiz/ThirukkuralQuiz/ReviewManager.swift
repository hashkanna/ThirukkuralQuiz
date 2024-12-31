import StoreKit

class ReviewManager {
    static let shared = ReviewManager()
    private let defaults = UserDefaults.standard
    
    private let minimumGamesKey = "gamesPlayedSinceLastRequest"
    private let lastReviewRequestKey = "lastReviewRequest"
    
    func incrementGameCount() {
        let count = defaults.integer(forKey: minimumGamesKey) + 1
        defaults.set(count, forKey: minimumGamesKey)
        
        checkAndRequestReview()
    }
    
    private func checkAndRequestReview() {
        let gamesPlayed = defaults.integer(forKey: minimumGamesKey)
        let lastRequest = defaults.object(forKey: lastReviewRequestKey) as? Date ?? Date.distantPast
        
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date()
        
        if gamesPlayed >= 5 && lastRequest < threeMonthsAgo {
            requestReview()
        }
    }
    
    private func requestReview() {
        guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        
        Task {
            // Use the new API
            await AppStore.requestReview(in: scene)
        }
        
        defaults.set(Date(), forKey: lastReviewRequestKey)
        defaults.set(0, forKey: minimumGamesKey)
    }
} 