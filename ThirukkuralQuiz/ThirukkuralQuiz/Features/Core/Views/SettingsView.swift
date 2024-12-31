import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var settings = GameSettings()
    @StateObject private var progress = GameProgress()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("விளையாட்டு அமைப்புகள்")) {
                    Picker("கடினத்தன்மை", selection: $settings.difficulty) {
                        ForEach(GameSettings.Difficulty.allCases, id: \.self) { difficulty in
                            Text(difficulty.rawValue).tag(difficulty)
                        }
                    }
                    
                    Stepper(
                        "கேள்விகளின் எண்ணிக்கை: \(settings.questionCount)",
                        value: $settings.questionCount,
                        in: 5...20
                    )
                    
                    Toggle("பொருளைக் காட்டு", isOn: $settings.showTranslation)
                    Toggle("ஒலி", isOn: $settings.soundEnabled)
                    Toggle("அதிர்வு", isOn: $settings.hapticEnabled)
                }
                
                Section(header: Text("புள்ளிவிவரங்கள்")) {
                    HStack {
                        Text("மொத்த விளையாட்டுகள்")
                        Spacer()
                        Text("\(progress.totalGamesPlayed)")
                    }
                    
                    HStack {
                        Text("அதிக மதிப்பெண்")
                        Spacer()
                        Text("\(progress.highScore)")
                    }
                    
                    HStack {
                        Text("கற்ற குறள்கள்")
                        Spacer()
                        Text("\(progress.completedKurals.count)")
                    }
                }
                
                Section(header: Text("சாதனைகள்")) {
                    ForEach(Array(GameProgress.Achievement.allCases), id: \.self) { achievement in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(achievement.rawValue)
                                    .font(.headline)
                                Text(achievement.description)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if progress.achievements.contains(achievement) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                
                Section(header: Text("பற்றி")) {
                    HStack {
                        Text("பதிப்பு")
                        Spacer()
                        Text("1.0.0")
                    }
                    
                    Link("திருக்குறள் பற்றி", destination: URL(string: "https://ta.wikipedia.org/wiki/திருக்குறள்")!)
                }
                
                Button(action: shareApp) {
                    Label("செயலியை பகிர்", systemImage: "square.and.arrow.up")
                        .font(.custom("Tamil Sangam MN", size: 18))
                }
            }
            .navigationTitle("அமைப்புகள்")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("முடி") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func shareApp() {
        let text = """
        திருக்குறள் வினாடி வினா செயலியை பயன்படுத்தி பாருங்கள்!
        
        App Store: https://apps.apple.com/app/idYOUR_APP_ID
        """
        
        let activityVC = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
} 