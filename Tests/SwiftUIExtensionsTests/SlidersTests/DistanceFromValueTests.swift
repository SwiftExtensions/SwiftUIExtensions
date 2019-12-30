@testable import Sliders
import XCTest

class DistanceFromValueTests: XCTestCase {
    
    func testDistanceFromValue() {
        
        /// Zero value distance without offsets should be 0
        let zeroDistance = distanceFrom(value: 0.0, availableDistance: 100)
        XCTAssert(zeroDistance == 0)
        
        /// Middle value distance without offsets should be half of overall length
        let middleDistance = distanceFrom(value: 0.5, availableDistance: 100)
        XCTAssert(middleDistance == 50)
        
        /// Largest value distance without offsets should be full overall length
        let fullDistance = distanceFrom(value: 1.0, availableDistance: 100)
        XCTAssert(fullDistance == 100)
    }
    
    func testDistanceFromValueWithNonUnitIntervalBounds() {
        
        /// Smallest value point distance without offsets should be 0
        let zeroDistance = distanceFrom(value: 0.25, availableDistance: 100, bounds: 0.25...1.25)
        XCTAssert(zeroDistance == 0)
        
        /// Middle value distance without offsets should be half of overall length
        let middleDistance = distanceFrom(value: 3.0, availableDistance: 100, bounds: 2.0...4.0)
        XCTAssert(middleDistance == 50)
        
        /// Largest value distance without offsets should be full overall length
        let fullDistance = distanceFrom(value: 1.0, availableDistance: 100, bounds: -1.0...1.0)
        XCTAssert(fullDistance == 100)
    }
    
    func testDistanceFromValueWithOffsets() {
        
        /// Zero value distance with start offset 5 should be 5
        let zeroDistance = distanceFrom(value: 0.0, availableDistance: 100, leadingOffset: 5, trailingOffset: 0)
        XCTAssert(zeroDistance == 5)
        
        /// Middle value distance with start and end offset of 10 should be half of overall length
        let middleDistance = distanceFrom(value: 0.5, availableDistance: 100, leadingOffset: 10, trailingOffset: 10)
        XCTAssert(middleDistance == 50)
        
        /// Largest value distance with end offset of 5 should be full overall length minus end offset
        let fullDistance = distanceFrom(value: 1.0, availableDistance: 100, leadingOffset: 0, trailingOffset: 5)
        XCTAssert(fullDistance == 95)
    }
    
    func testDistanceFromValueWithNonUnitIntervalBoundsWithOffsets() {
        
        /// Smallest value point distance with start offset 5 should be 5
        let zeroDistance1 = distanceFrom(value: 0.25, availableDistance: 100, bounds: 0.25...1.25, leadingOffset: 5, trailingOffset: 0)
        XCTAssert(zeroDistance1 == 5)
        
        /// Smallest value point distance with start offset 5 and end offset of 5 should be 5
        let zeroDistance2 = distanceFrom(value: 0.25, availableDistance: 100, bounds: 0.25...1.25, leadingOffset: 5, trailingOffset: 5)
        XCTAssert(zeroDistance2 == 5)
        
        /// Middle value distance with equal offsets should be half of overall length
        let middleDistance1 = distanceFrom(value: 3.0, availableDistance: 100, bounds: 2.0...4.0, leadingOffset: 10, trailingOffset: 10)
        XCTAssert(middleDistance1 == 50)
        
        /// Middle value distance with different offsets should be half of overall length minus center point of these offsets
        let middleDistance2 = distanceFrom(value: 3.0, availableDistance: 100, bounds: 2.0...4.0, leadingOffset: 13, trailingOffset: 7)
        XCTAssert(middleDistance2 == 53)
        
        /// Middle value distance with different offsets should be half of overall length minus center point of these offsets
        let middleDistance3 = distanceFrom(value: 3.0, availableDistance: 100, bounds: 2.0...4.0, leadingOffset: 2, trailingOffset: 18)
        XCTAssert(middleDistance3 == 42)
        
        /// Largest value distance with end offset of 5 should be full overall length minus end offset
        let fullDistance1 = distanceFrom(value: 1.0, availableDistance: 100, bounds: -1.0...1.0, leadingOffset: 0, trailingOffset: 5)
        XCTAssert(fullDistance1 == 95)
        
        /// Largest value distance with both offsets of 5 should be full overall length minus end offset
        let fullDistance2 = distanceFrom(value: 1.0, availableDistance: 100, bounds: -1.0...1.0, leadingOffset: 5, trailingOffset: 5)
        XCTAssert(fullDistance2 == 95)
    }
    
}

