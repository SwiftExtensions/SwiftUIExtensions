@testable import Sliders
import XCTest

class RangeDistanceTests: XCTestCase {
    
    func testRangeDistance() {
        let zeroRangeDistance = rangeDistance(overallLength: 100, range: 0.5...0.5)
        XCTAssert(zeroRangeDistance == 0)
        
        let halfRangeDistance = rangeDistance(overallLength: 100, range: 0.25...0.75)
        XCTAssert(halfRangeDistance == 50)
        
        let fullRangeDistance = rangeDistance(overallLength: 100, range: 0.0...1.0)
        XCTAssert(fullRangeDistance == 100)
    }
    
    func testRangeDistanceWithBounds() {
        let zeroRangeDistance = rangeDistance(overallLength: 100, range: 0.5...0.5, bounds: 0.25...1.25)
        XCTAssert(zeroRangeDistance == 0)
        
        let halfRangeDistance = rangeDistance(overallLength: 100, range: -0.5...0.5, bounds: -1.0...1.0)
        XCTAssert(halfRangeDistance == 50)
        
        let fullRangeDistance = rangeDistance(overallLength: 100, range: -2.0...2.0, bounds: -2.0...2.0)
        XCTAssert(fullRangeDistance == 100)
    }
    
    func testRangeDistanceWithBoundsAndOffsets() {
        
        let zeroRangeDistance = rangeDistance(overallLength: 100, range: 0.5...0.5, bounds: 0.25...1.25, lowerStartOffset: 10, lowerEndOffset: 10, upperStartOffset: 10, upperEndOffset: 10)
        XCTAssert(zeroRangeDistance == 0)
        
        let halfRangeDistance = rangeDistance(overallLength: 100, range: -0.5...0.5, bounds: -1.0...1.0, lowerStartOffset: 15, lowerEndOffset: 5, upperStartOffset: 15, upperEndOffset: 5)
        XCTAssert(halfRangeDistance == 40)
        
        let fullRangeDistance = rangeDistance(overallLength: 100, range: -2.0...2.0, bounds: -2.0...2.0, lowerStartOffset: 5, lowerEndOffset: 15, upperStartOffset: 5, upperEndOffset: 15)
        XCTAssert(fullRangeDistance == 80)
    }
}
