import Foundation

struct Thirukkural: Codable {
    let Number: Int
    let Line1: String
    let Line2: String
    let Translation: String
    let explanation: String
    let transliteration1: String
    let transliteration2: String
    let mk: String  // Tamil explanation
}

struct ThirukkuralData: Codable {
    let kural: [Thirukkural]
}

enum DatabaseError: Error {
    case fileNotFound
    case decodingError
    case emptyDatabase
    
    var message: String {
        switch self {
        case .fileNotFound:
            return "திருக்குறள் தரவுத்தளம் காணப்படவில்லை"
        case .decodingError:
            return "தரவுத்தளத்தை படிப்பதில் பிழை"
        case .emptyDatabase:
            return "தரவுத்தளம் காலியாக உள்ளது"
        }
    }
}

class ThirukkuralDatabase: ObservableObject {
    static let shared = ThirukkuralDatabase()
    @Published var kurals: [Thirukkural] = []
    @Published var error: DatabaseError?
    
    private init() {
        do {
            try loadThirukkurals()
        } catch let error as DatabaseError {
            self.error = error
        } catch {
            self.error = .decodingError
        }
    }
    
    private func loadThirukkurals() throws {
        guard let path = Bundle.main.path(forResource: "thirukkural", ofType: "json") else {
            throw DatabaseError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let thirukkuralData = try JSONDecoder().decode(ThirukkuralData.self, from: data)
            kurals = thirukkuralData.kural
            
            if kurals.isEmpty {
                throw DatabaseError.emptyDatabase
            }
        } catch DecodingError.dataCorrupted(_) {
            throw DatabaseError.decodingError
        } catch {
            throw DatabaseError.decodingError
        }
    }
    
    func getRandomKurals(_ count: Int) -> [Thirukkural] {
        return Array(kurals.shuffled().prefix(count))
    }
}