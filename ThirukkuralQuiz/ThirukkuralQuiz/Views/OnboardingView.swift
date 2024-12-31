import SwiftUI

struct OnboardingView: View {
    @Binding var isShowingOnboarding: Bool
    
    var body: some View {
        TabView {
            // Welcome Page
            OnboardingPage(
                title: "வணக்கம்!",
                description: "திருக்குறள் வினாடி வினா மூலம் திருக்குறள் கற்க வரவேற்கிறோம்",
                imageName: "hand.wave.fill"
            )
            
            // Quiz Page
            OnboardingPage(
                title: "வினாடி வினா",
                description: "குறளில் விடுபட்ட வார்த்தையை கண்டுபிடித்து மதிப்பெண்கள் பெறுங்கள்",
                imageName: "questionmark.circle.fill"
            )
            
            // Learning Page
            OnboardingPage(
                title: "கற்றல் பகுதி",
                description: "அத்தியாயம் வாரியாக திருக்குறள்களை கற்றுக்கொள்ளுங்கள்",
                imageName: "book.fill"
            )
            
            // Game Rules Page
            GameRulesPage()
            
            // Achievements Page
            OnboardingPage(
                title: "சாதனைகள்",
                description: "விளையாடி சாதனைகளை நிறைவேற்றுங்கள்",
                imageName: "star.fill"
            )
            
            // Share Page
            OnboardingPage(
                title: "பகிர்வு",
                description: "உங்கள் சாதனைகளை நண்பர்களுடன் பகிருங்கள்",
                imageName: "square.and.arrow.up.fill"
            )
            
            // Final Page
            FinalOnboardingPage(isShowingOnboarding: $isShowingOnboarding)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .background(
            LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let imageName: String
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: imageName)
                .font(.system(size: 100))
                .foregroundColor(.white)
                .padding()
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 180, height: 180)
                )
                .shadow(radius: 10)
            
            Text(verbatim: title)
                .font(.custom("Tamil Sangam MN", size: 32))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(verbatim: description)
                .font(.custom("Tamil Sangam MN", size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
    }
}

struct FinalOnboardingPage: View {
    @Binding var isShowingOnboarding: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 180, height: 180)
                )
                .shadow(radius: 10)
            
            Text("தயார்!")
                .font(.custom("Tamil Sangam MN", size: 32))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("இப்போது நீங்கள் விளையாட தயார்")
                .font(.custom("Tamil Sangam MN", size: 20))
                .foregroundColor(.white.opacity(0.9))
            
            Button(action: {
                withAnimation {
                    isShowingOnboarding = false
                }
            }) {
                Text("தொடங்கு")
                    .font(.custom("Tamil Sangam MN", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 20)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

struct GameRulesPage: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("விளையாட்டு விதிமுறைகள்")
                .font(.custom("Tamil Sangam MN", size: 32))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 20) {
                TutorialStep(
                    number: "1",
                    title: "குறளைப் படியுங்கள்",
                    description: "விடுபட்ட வார்த்தை ' _____ ' என்று காட்டப்படும்"
                )
                
                TutorialStep(
                    number: "2",
                    title: "சரியான வார்த்தையைத் தேர்வு செய்யுங்கள்",
                    description: "மூன்று விருப்பங்களில் இருந்து சரியான வார்த்தையைத் தேர்ந்தெடுக்கவும்"
                )
                
                TutorialStep(
                    number: "3",
                    title: "குறளின் பொருளைக் கற்றுக்கொள்ளுங்கள்",
                    description: "உங்கள் பதிலுக்குப் பிறகு குறளின் விளக்கம் காட்டப்படும்"
                )
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(15)
        }
        .padding()
    }
}

struct TutorialStep: View {
    let number: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text(number)
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 30, height: 30)
                .background(Circle().fill(Color.white.opacity(0.2)))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.custom("Tamil Sangam MN", size: 18))
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.custom("Tamil Sangam MN", size: 16))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
} 