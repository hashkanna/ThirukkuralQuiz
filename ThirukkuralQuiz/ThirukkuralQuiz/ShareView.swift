import SwiftUI
import UIKit

struct ShareView: View {
    let score: Int
    let total: Int
    let kural: Thirukkural
    @Environment(\.dismiss) var dismiss
    @StateObject private var database = ThirukkuralDatabase.shared
    @State private var isShareSheetPresented = false
    
    var shareText: String {
        """
        திருக்குறள் வினாடி வினா 🎯
        மதிப்பெண்: \(score)/\(total) ✨
        
        இன்றைய குறள்:
        \(kural.Line1)
        \(kural.Line2)
        
        பொருள்: \(kural.mk)
        
        நீங்களும் விளையாட முயற்சி செய்யுங்கள்! 🎮
        https://apps.apple.com/app/id<YOUR_APP_ID>
        """
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("பாராட்டுக்கள்!")
                .font(.custom("Tamil Sangam MN", size: 28))
                .fontWeight(.bold)
            
            Text("\(total) கேள்விகளில் \(score) மதிப்பெண்கள்")
                .font(.custom("Tamil Sangam MN", size: 20))
            
            if database.error == nil {
                VStack(spacing: 8) {
                    Text("இன்றைய குறள்:")
                        .font(.custom("Tamil Sangam MN", size: 16))
                    Text(kural.Line1)
                        .font(.custom("Tamil Sangam MN", size: 18))
                    Text(kural.Line2)
                        .font(.custom("Tamil Sangam MN", size: 18))
                    Text(kural.mk)
                        .font(.custom("Tamil Sangam MN", size: 16))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 4)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
            }
            
            Button(action: {
                isShareSheetPresented = true
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("பகிர்")
                }
                .font(.custom("Tamil Sangam MN", size: 20))
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.horizontal, 50)
                .padding(.vertical, 16)
                .background(Color.white)
                .cornerRadius(30)
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
        .sheet(isPresented: $isShareSheetPresented) {
            ShareSheet(activityItems: [shareText])
        }
    }
}

// Add this helper view to handle UIActivityViewController
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        
        // Exclude some activity types that might not be relevant
        controller.excludedActivityTypes = [
            .addToReadingList,
            .assignToContact,
            .openInIBooks,
            .saveToCameraRoll,
            .markupAsPDF
        ]
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
} 