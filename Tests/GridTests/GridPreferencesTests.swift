@testable import Grid
import XCTest

class GridPreferencesTests: XCTestCase {
    func testGridPreferencesMerge() {
        var preferences = GridPreferences(items: [
            GridPreferences.Item(id: 1, bounds: .zero),
            GridPreferences.Item(id: 2, bounds: .zero)
        ])
        
        let updatedPreferences = GridPreferences(items: [
            GridPreferences.Item(id: 1, bounds: .init(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100))),
            GridPreferences.Item(id: 2, bounds: .init(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 100, height: 100)))
        ])
        
        preferences.merge(with: updatedPreferences)
        
        XCTAssertEqual(preferences.size, CGSize(width: 150, height: 150))
    }
    
    func testGridPreferencesMergeWithZeroSizeAndItems() {
        var preferences = GridPreferences(items: [])
        XCTAssertEqual(preferences.size, .zero)
        XCTAssertEqual(preferences.items, [])
        
        preferences.merge(with: GridPreferences(items: []))
        XCTAssertEqual(preferences.size, .zero)
        XCTAssertEqual(preferences.items, [])
    }
}
