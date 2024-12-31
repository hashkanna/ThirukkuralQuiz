#!/bin/bash

# Update Core/Utilities with all managers
mv ThirukkuralQuiz/ThirukkuralQuiz/{RatingManager,ShareManager,ThemeManager,TimerManager,StreakManager,NotificationManager,FeedbackManager,GameProgress,GameSettings}.swift ThirukkuralQuiz/ThirukkuralQuiz/Core/Utilities/

# Move views to proper feature folders
mkdir -p ThirukkuralQuiz/ThirukkuralQuiz/Features/Core/Views
mv ThirukkuralQuiz/ThirukkuralQuiz/{ContentView,HelpView,LaunchScreen,SettingsView}.swift ThirukkuralQuiz/ThirukkuralQuiz/Features/Core/Views/

# Create Localization folder
mkdir -p ThirukkuralQuiz/ThirukkuralQuiz/Core/Localization
mv ThirukkuralQuiz/ThirukkuralQuiz/Localizable.swift ThirukkuralQuiz/ThirukkuralQuiz/Core/Localization/

# Move resources
mv ThirukkuralQuiz/ThirukkuralQuiz/thirukkural*.json ThirukkuralQuiz/ThirukkuralQuiz/Resources/
mv ThirukkuralQuiz/ThirukkuralQuiz/LaunchScreen.storyboard ThirukkuralQuiz/ThirukkuralQuiz/Resources/ 