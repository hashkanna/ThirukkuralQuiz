import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image("AppIcon")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(30)
                
                Text("திருக்குறள்")
                    .font(.custom("Tamil Sangam MN", size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("வினாடி வினா")
                    .font(.custom("Tamil Sangam MN", size: 24))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
} 