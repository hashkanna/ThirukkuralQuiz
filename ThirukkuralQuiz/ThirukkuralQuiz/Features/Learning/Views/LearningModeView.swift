import SwiftUI

struct LearningModeView: View {
    let books = KuralStructure.shared.books
    @State private var selectedBook: KuralBook?
    @State private var selectedSection: KuralSection?
    @State private var selectedChapter: KuralChapter?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        VStack(alignment: .leading) {
                            Text(book.name)
                                .font(.custom("Tamil Sangam MN", size: 20))
                                .fontWeight(.bold)
                            Text(book.description)
                                .font(.custom("Tamil Sangam MN", size: 16))
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("கற்றல் பகுதி")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct BookDetailView: View {
    let book: KuralBook
    
    var body: some View {
        List {
            ForEach(book.sections) { section in
                NavigationLink(destination: SectionDetailView(section: section)) {
                    VStack(alignment: .leading) {
                        Text(section.name)
                            .font(.custom("Tamil Sangam MN", size: 18))
                            .fontWeight(.semibold)
                        Text(section.description)
                            .font(.custom("Tamil Sangam MN", size: 14))
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle(book.name)
    }
}

struct SectionDetailView: View {
    let section: KuralSection
    
    var body: some View {
        List {
            ForEach(section.chapters) { chapter in
                NavigationLink(destination: ChapterDetailView(chapter: chapter)) {
                    VStack(alignment: .leading) {
                        Text(chapter.name)
                            .font(.custom("Tamil Sangam MN", size: 18))
                            .fontWeight(.semibold)
                        Text(chapter.description)
                            .font(.custom("Tamil Sangam MN", size: 14))
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle(section.name)
    }
}

struct ChapterDetailView: View {
    let chapter: KuralChapter
    @State private var selectedKural: Thirukkural?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(chapter.description)
                    .font(.custom("Tamil Sangam MN", size: 16))
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(10)
                
                ForEach(chapter.kurals, id: \.Number) { kural in
                    KuralCard(kural: kural, isExpanded: selectedKural?.Number == kural.Number)
                        .onTapGesture {
                            withAnimation {
                                if selectedKural?.Number == kural.Number {
                                    selectedKural = nil
                                } else {
                                    selectedKural = kural
                                }
                            }
                        }
                }
            }
            .padding()
        }
        .navigationTitle(chapter.name)
    }
}

struct KuralCard: View {
    let kural: Thirukkural
    let isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("\(kural.Number)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(kural.Line1)
                Text(kural.Line2)
            }
            .font(.custom("Tamil Sangam MN", size: 18))
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    Text("பொருள்:")
                        .font(.custom("Tamil Sangam MN", size: 16))
                        .fontWeight(.bold)
                    Text(kural.mk)
                        .font(.custom("Tamil Sangam MN", size: 16))
                }
                .padding(.top, 8)
                .transition(.opacity)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(15)
    }
} 