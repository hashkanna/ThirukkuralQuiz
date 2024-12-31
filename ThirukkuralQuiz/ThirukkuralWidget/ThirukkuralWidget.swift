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

    var body: some View {
        VStack(spacing: 8) {
            Text("இன்றைய குறள்")
                .font(.custom("Tamil Sangam MN", size: 14))
                .foregroundColor(.secondary)
            
            Text(entry.kural.Line1)
                .font(.custom("Tamil Sangam MN", size: 16))
            Text(entry.kural.Line2)
                .font(.custom("Tamil Sangam MN", size: 16))
        }
        .padding()
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