//
//  ContentView.swift
//  ThirukkuralQuiz
//
//  Created by Kannappan Sirchabesan on 03/10/2024.
//

import SwiftUI

struct Question {
    let kural: Thirukkural
    let missingWord: String
    let options: [String]
    var showExplanation: Bool = false
}

struct ContentView: View {
    @StateObject private var settings = GameSettings()
    @StateObject private var progress = GameProgress()
    @StateObject private var database = ThirukkuralDatabase.shared
    private let ratingManager = RatingManager.shared
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showingScore = false
    @State private var selectedAnswer = ""
    @State private var showHelp = false
    @State private var showSettings = false
    @State private var isAnswerRevealed = false
    @State private var cardRotation = 0.0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var showingOnboarding = false
    @State private var showingShare = false
    @State private var showLearningMode = false
    
    init() {
        _questions = State(initialValue: [])
    }
    
    func generateQuestions(count: Int) -> [Question] {
        guard database.error == nil else { return [] }
        let randomKurals = database.getRandomKurals(count)
        
        return randomKurals.map { kural in
            // Combine both lines and split into words
            let line1Words = kural.Line1.components(separatedBy: " ")
            let line2Words = kural.Line2.components(separatedBy: " ")
            let allWords = line1Words + line2Words
            
            // Pick a random word to remove from either line
            let randomIndex = Int.random(in: 0..<allWords.count)
            let missingWord = allWords[randomIndex]
            
            // Create wrong options
            var options = [missingWord]
            while options.count < 3 {
                if let randomKural = database.kurals.randomElement() {
                    let randomWords = (randomKural.Line1 + " " + randomKural.Line2)
                        .components(separatedBy: " ")
                    if let randomWord = randomWords.randomElement(),
                       !options.contains(randomWord) && randomWord != missingWord {
                        options.append(randomWord)
                    }
                }
            }
            
            return Question(
                kural: kural,
                missingWord: missingWord,
                options: options.shuffled()
            )
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), 
                          startPoint: .topLeading, 
                          endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            if let error = database.error {
                VStack(spacing: 20) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.yellow)
                    
                    Text(error.message)
                        .font(.custom("Tamil Sangam MN", size: 18))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .foregroundColor(.white)
            } else {
                VStack(spacing: 20) {
                    Text("திருக்குறள் வினாடி வினா")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                    
                    HStack {
                        Button(action: { showHelp = true }) {
                            Image(systemName: "questionmark.circle")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Button(action: { showLearningMode = true }) {
                            Image(systemName: "book.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Button(action: { showSettings = true }) {
                            Image(systemName: "gear")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    if !questions.isEmpty {
                        let currentQuestion = questions[currentQuestionIndex]
                        
                        VStack(alignment: .center, spacing: 8) {
                            Text(currentQuestion.kural.Line1.replacingOccurrences(
                                of: currentQuestion.missingWord, 
                                with: "_____"
                            ))
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                            .fixedSize(horizontal: false, vertical: true)
                            
                            Text(currentQuestion.kural.Line2.replacingOccurrences(
                                of: currentQuestion.missingWord, 
                                with: "_____"
                            ))
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .font(.custom("Tamil Sangam MN", size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.6))
                        .cornerRadius(15)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .opacity
                        ))
                        
                        ForEach(currentQuestion.options, id: \.self) { option in
                            Button(action: {
                                self.checkAnswer(option)
                            }) {
                                Text(option)
                                    .font(.custom("Tamil Sangam MN", size: 20))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        selectedAnswer == option ?
                                            (option == currentQuestion.missingWord ? Color.green : Color.red) :
                                            Color.purple
                                    )
                                    .cornerRadius(10)
                            }
                            .disabled(selectedAnswer != "")
                        }
                        
                        if selectedAnswer != "" {
                            VStack(spacing: 12) {
                                Button("அடுத்த கேள்வி") {
                                    withAnimation {
                                        nextQuestion()
                                    }
                                }
                                .font(.custom("Tamil Sangam MN", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                
                                VStack(spacing: 10) {
                                    Text("குறள் எண்: \(currentQuestion.kural.Number)")
                                        .font(.custom("Tamil Sangam MN", size: 16))
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("பொருள்:")
                                            .font(.custom("Tamil Sangam MN", size: 16))
                                            .fontWeight(.bold)
                                        Text(currentQuestion.kural.mk)
                                            .font(.custom("Tamil Sangam MN", size: 16))
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .padding(.horizontal)
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(10)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                            .transition(.opacity)
                        }
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            }
        }
        .onAppear {
            // Force reset onboarding for testing
            UserDefaults.standard.set(false, forKey: "hasSeenOnboarding")
            hasSeenOnboarding = false
            
            if database.error == nil && questions.isEmpty {
                questions = generateQuestions(count: settings.questionCount)
            }
            
            // Show onboarding if it hasn't been seen
            if !hasSeenOnboarding {
                showingOnboarding = true
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text("வினாடி வினா முடிந்தது!"),
                message: Text("உங்கள் மதிப்பெண்: \(score)/\(questions.count)"),
                primaryButton: .default(Text("பகிர்")) {
                    showingShare = true
                },
                secondaryButton: .default(Text("மீண்டும் தொடங்கு")) {
                    self.restartQuiz()
                }
            )
        }
        .sheet(isPresented: $showHelp) {
            HelpView()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showingOnboarding) {
            OnboardingView(isShowingOnboarding: $showingOnboarding)
        }
        .sheet(isPresented: $showingShare) {
            ShareView(
                score: score,
                total: questions.count,
                kural: questions[currentQuestionIndex].kural
            )
        }
        .sheet(isPresented: $showLearningMode) {
            LearningModeView()
        }
    }
    
    func checkAnswer(_ answer: String) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedAnswer = answer
            if answer == questions[currentQuestionIndex].missingWord {
                score += 1
                if settings.soundEnabled {
                    FeedbackManager.shared.playCorrectAnswerSound()
                }
                if settings.hapticEnabled {
                    FeedbackManager.shared.triggerHaptic(for: true)
                }
            } else {
                if settings.hapticEnabled {
                    FeedbackManager.shared.triggerHaptic(for: false)
                }
            }
            isAnswerRevealed = true
        }
    }
    
    func nextQuestion() {
        withAnimation(.easeInOut(duration: 0.3)) {
            if currentQuestionIndex + 1 < questions.count {
                currentQuestionIndex += 1
                selectedAnswer = ""
                isAnswerRevealed = false
            } else {
                showingScore = true
            }
        }
    }
    
    func restartQuiz() {
        questions = generateQuestions(count: settings.questionCount)
        currentQuestionIndex = 0
        score = 0
        selectedAnswer = ""
        progress.checkAndUpdateAchievements(score: score, totalQuestions: questions.count, difficulty: settings.difficulty)
        ratingManager.incrementQuizCount()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}