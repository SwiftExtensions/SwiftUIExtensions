@testable import Grid
import XCTest

class StaggeredGridStyleTests: XCTestCase {
    func testStaggeredGridStyleWithOneRow() {
        let style = StaggeredGridStyle(.horizontal, tracks: 2, spacing: 0)
        
        var preferences = GridPreferences(items: [
            GridPreferences.Item(id: 1, bounds: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 50))),
            GridPreferences.Item(id: 2, bounds: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 50))),
            GridPreferences.Item(id: 3, bounds: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 50))),
            GridPreferences.Item(id: 4, bounds: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 50)))
        ])
        
        style.transform(preferences: &preferences, in: CGSize(width: 200, height: 100))
        
        XCTAssertEqual(preferences, GridPreferences(
            size: CGSize(width: 200, height: 100),
            items: [
                GridPreferences.Item(id: 1, bounds: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 50))),
                GridPreferences.Item(id: 2, bounds: CGRect(origin: CGPoint(x: 0, y: 50), size: CGSize(width: 100, height: 50))),
                GridPreferences.Item(id: 3, bounds: CGRect(origin: CGPoint(x: 100, y: 0), size: CGSize(width: 100, height: 50))),
                GridPreferences.Item(id: 4, bounds: CGRect(origin: CGPoint(x: 100, y: 50), size: CGSize(width: 100, height: 50)))
            ])
        )
    }
}
