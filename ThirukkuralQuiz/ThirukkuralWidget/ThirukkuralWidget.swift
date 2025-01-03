import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DailyEntry {
        DailyEntry(date: Date(), kural: ThirukkuralDatabase.shared.kurals[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (DailyEntry) -> ()) {
        let entry = DailyEntry(date: Date(), kural: DailyChallengeManager.shared.dailyKural ?? ThirukkuralDatabase.shared.kurals[0])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let midnight = Calendar.current.startOfDay(for: currentDate)
        let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
        
        let entry = DailyEntry(date: currentDate, kural: DailyChallengeManager.shared.dailyKural ?? ThirukkuralDatabase.shared.kurals[0])
        let timeline = Timeline(entries: [entry], policy: .after(nextMidnight))
        
        completion(timeline)
    }
}

struct DailyEntry: TimelineEntry {
    let date: Date
    let kural: Thirukkural
}

struct ThirukkuralWidgetEntryView : View {
    var entry: Provider.Entry
    
    private func calculateFontSize() -> CGFloat {
        let line1Length = entry.kural.Line1.count
        let line2Length = entry.kural.Line2.count
        let maxLength = max(line1Length, line2Length)
        
        if maxLength > 80 {
            return 3
        } else if maxLength > 70 {
            return 4
        } else if maxLength > 60 {
            return 5
        } else if maxLength > 50 {
            return 6
        } else if maxLength > 40 {
            return 7
        } else if maxLength > 30 {
            return 8
        } else {
            return 9
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let fontSize = calculateFontSize()
            
            VStack(spacing: 6) {
                Text("இன்றைய குறள்")
                    .font(.custom("Tamil Sangam MN", size: 11))
                    .foregroundColor(.secondary)
                
                VStack(spacing: 0) {
                    Text(entry.kural.Line1)
                        .font(.custom("Tamil Sangam MN", size: fontSize))
                        .minimumScaleFactor(0.2)
                        .lineLimit(1)
                        .frame(maxWidth: geometry.size.width - 4)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(entry.kural.Line2)
                        .font(.custom("Tamil Sangam MN", size: fontSize))
                        .minimumScaleFactor(0.2)
                        .lineLimit(1)
                        .frame(maxWidth: geometry.size.width - 4)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

@main
struct ThirukkuralWidget: Widget {
    let kind: String = "ThirukkuralWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ThirukkuralWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("தன்றைய திருக்குறள்")
        .description("தினமும் ஒரு திருக்குறள்")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
} 