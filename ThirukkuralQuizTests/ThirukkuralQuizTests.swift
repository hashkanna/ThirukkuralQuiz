import XCTest
@testable import ThirukkuralQuiz

final class ThirukkuralQuizTests: XCTestCase {
    var database: ThirukkuralDatabase!
    
    override func setUp() {
        super.setUp()
        database = ThirukkuralDatabase.shared
    }
    
    func testDatabaseLoading() {
        XCTAssertFalse(database.kurals.isEmpty, "Database should not be empty")
        XCTAssertEqual(database.kurals.count, 1330, "Database should contain 1330 kurals")
    }
    
    func testRandomKuralSelection() {
        let count = 5
        let randomKurals = database.getRandomKurals(count)
        XCTAssertEqual(randomKurals.count, count, "Should return exactly \(count) kurals")
        
        // Test uniqueness
        let uniqueKurals = Set(randomKurals.map { $0.Number })
        XCTAssertEqual(uniqueKurals.count, count, "All kurals should be unique")
    }
    
    func testQuestionGeneration() {
        let contentView = ContentView()
        let questions = contentView.generateQuestions(count: 5)
        
        XCTAssertEqual(questions.count, 5, "Should generate 5 questions")
        
        for question in questions {
            XCTAssertEqual(question.options.count, 3, "Each question should have 3 options")
            XCTAssertTrue(question.options.contains(question.missingWord), "Options should contain the missing word")
            
            // Test uniqueness of options
            let uniqueOptions = Set(question.options)
            XCTAssertEqual(uniqueOptions.count, question.options.count, "All options should be unique")
        }
    }
} 