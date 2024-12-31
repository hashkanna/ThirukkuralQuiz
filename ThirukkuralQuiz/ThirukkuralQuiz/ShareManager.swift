import SwiftUI

struct ShareManager {
    static func shareScore(score: Int, total: Int) {
        let text = "திருக்குறள் வினாடி வினாவில் \(total) கேள்விகளில் \(score) மதிப்பெண்கள் பெற்றேன்! நீங்களும் முயற்சி செய்யுங்கள்!"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
} 