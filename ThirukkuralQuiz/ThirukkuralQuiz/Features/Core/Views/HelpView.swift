import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingTutorial = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("விளையாட்டு விதிகள்")
                    .font(.custom("Tamil Sangam MN", size: 24))
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 15) {
                    HelpItem(
                        icon: "1.circle.fill",
                        text: "ஒவ்வொரு கேள்வியிலும் ஒரு குறளில் இருந்து ஒரு வார்த்தை விடுபட்டிருக்கும்"
                    )
                    
                    HelpItem(
                        icon: "2.circle.fill",
                        text: "சரியான வார்த்தையை தேர்ந்தெடுக்கவும்"
                    )
                    
                    HelpItem(
                        icon: "3.circle.fill",
                        text: "விடை தெரிந்த பிறகு குறளின் பொருளும் காட்டப்படும்"
                    )
                    
                    HelpItem(
                        icon: "4.circle.fill",
                        text: "ஐந்து கேள்விகளுக்கு பதிலளித்த பிறகு உங்கள் மதிப்பெண் காட்டப்படும்"
                    )
                }
                .padding()
                
                Button("விளையாட்டு விதிமுறைகள்") {
                    showingTutorial = true
                }
                .font(.custom("Tamil Sangam MN", size: 18))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("முடி") {
                        dismiss()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showingTutorial) {
            OnboardingView(isShowingOnboarding: $showingTutorial)
        }
    }
}

struct HelpItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            
            Text(text)
                .font(.custom("Tamil Sangam MN", size: 16))
        }
    }
} 