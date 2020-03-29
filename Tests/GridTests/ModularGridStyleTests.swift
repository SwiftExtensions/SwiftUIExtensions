@testable import Grid
import XCTest

class ModularGridStyleTests: XCTestCase {
    func testModularGridStyleWithOneRow() {
        let style = ModularGridStyle(.vertical, columns: 4, rows: 1, spacing: 0)
        
        var preferences = GridPreferences(items: [
            GridPreferences.Item(id: 1, bounds: .zero),
            GridPreferences.Item(id: 2, bounds: .zero),
            GridPreferences.Item(id: 3, bounds: .zero),
            GridPreferences.Item(id: 4, bounds: .zero)
        ])
        
        style.transform(preferences: &preferences, in: CGSize(width: 100, height: 50))
        
        XCTAssertEqual(preferences, GridPreferences(
            size: CGSize(width: 100, height: 50),
            items: [
                GridPreferences.Item(id: 1, bounds: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 25, height: 50))),
                GridPreferences.Item(id: 2, bounds: CGRect(origin: CGPoint(x: 25, y: 0), size: CGSize(width: 25, height: 50))),
                GridPreferences.Item(id: 3, bounds: CGRect(origin: CGPoint(x: 50, y: 0), size: CGSize(width: 25, height: 50))),
                GridPreferences.Item(id: 4, bounds: CGRect(origin: CGPoint(x: 75, y: 0), size: CGSize(width: 25, height: 50)))
            ])
        )
    }
    
    func testModularGridStyleWithTwoRows() {
        let style = ModularGridStyle(.vertical, columns: 2, rows: .fixed(50), spacing: 0)
        
        var preferences = GridPreferences(items: [
            GridPreferences.Item(id: 1, bounds: .zero),
            GridPreferences.Item(id: 2, bounds: .zero),
            GridPreferences.Item(id: 3, bounds: .zero),
            GridPreferences.Item(id: 4, bounds: .zero)
        ])
        
        style.transform(preferences: &preferences, in: CGSize(width: 100, height: 100))
        
        XCTAssertEqual(preferences, GridPreferences(
            size: CGSize(width: 100, height: 100),
            items: [
                GridPreferences.Item(id: 1, bounds: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50, height: 50))),
                GridPreferences.Item(id: 2, bounds: CGRect(origin: CGPoint(x: 50, y: 0), size: CGSize(width: 50, height: 50))),
                GridPreferences.Item(id: 3, bounds: CGRect(origin: CGPoint(x: 0, y: 50), size: CGSize(width: 50, height: 50))),
                GridPreferences.Item(id: 4, bounds: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 50, height: 50)))
            ])
        )
    }
    
    func testModularGridStyleWithZeroSizeAndNoItems() {
        let style = ModularGridStyle(.vertical, columns: 5, rows: 5, spacing: 0)
        
        var preferences = GridPreferences(items: [])
        XCTAssertEqual(preferences.size, .zero)
        
        style.transform(preferences: &preferences, in: .zero)
        XCTAssertEqual(preferences.size, .zero)
        XCTAssertEqual(preferences.items, [])
        XCTAssertEqual(preferences.items, [])
    }
}
