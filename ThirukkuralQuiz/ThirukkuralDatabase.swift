class ThirukkuralDatabase: ObservableObject {
    static let shared = ThirukkuralDatabase()
    @Published var kurals: [Thirukkural] = []
    @Published var error: DatabaseError?
    
    private init() {
        do {
            try loadThirukkurals()
        } catch let error as DatabaseError {
            self.error = error
            print("Database Error: \(error.message)")
        } catch {
            self.error = .decodingError
            print("Unexpected Error: \(error)")
        }
    }
    
    private func loadThirukkurals() throws {
        guard let path = Bundle.main.path(forResource: "thirukkural", ofType: "json") else {
            print("File not found: thirukkural.json")
            throw DatabaseError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let thirukkuralData = try JSONDecoder().decode(ThirukkuralData.self, from: data)
            self.kurals = thirukkuralData.kural
            
            if kurals.isEmpty {
                throw DatabaseError.emptyDatabase
            }
        } catch {
            print("Error decoding data: \(error)")
            throw DatabaseError.decodingError
        }
    }
} 