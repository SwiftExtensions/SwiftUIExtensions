@testable import Sliders
import XCTest

class ValueFromDistanceTests: XCTestCase {
    
    func testValueFromDistance() {
        let zeroValue = valueFrom(distance: 0.0, availableDistance: 100)
        XCTAssert(zeroValue == 0.0)
        
        /// Unit interval value should be itself
        let middleValue = valueFrom(distance: 50, availableDistance: 100)
        XCTAssert(middleValue == 0.5)
        
        /// Unit interval value should be itself
        let fullValue = valueFrom(distance: 100, availableDistance: 100)
        XCTAssert(fullValue == 1.0)
    }
    
    func testValueFromDistanceWithBounds() {
        let zeroValue = valueFrom(distance: 0.0, availableDistance: 100, bounds: 0.25...1.25)
        XCTAssert(zeroValue == 0.25)
        
        let middleValue = valueFrom(distance: 50, availableDistance: 100, bounds: -1.0...1.0)
        XCTAssert(middleValue == 0.0)
        
        let fullValue = valueFrom(distance: 100, availableDistance: 100, bounds: -3.0...3.0)
        XCTAssert(fullValue == 3.0)
    }
    
    func ttestValueFromDistanceWithBoundsAndStep() {
        let zeroValue = valueFrom(distance: 0.0, availableDistance: 100, bounds: 25...125, step: 10)
        XCTAssert(zeroValue == 30)
        
        let middleValue = valueFrom(distance: 50, availableDistance: 100, bounds: -1.0...1.0, step: 1)
        XCTAssert(middleValue == 0.0)
        
        let fullValue = valueFrom(distance: 100, availableDistance: 100, bounds: -3.0...3.0, step: 0.5)
        XCTAssert(fullValue == 3.0)
    }
    
    func testValueFromDistanceWithOffsets() {
        let zeroValue = valueFrom(distance: 0.0, availableDistance: 100, leadingOffset: 0, trailingOffset: 0)
        XCTAssert(zeroValue == 0.0)
        
        let zeroValueWithLeadingOffset = valueFrom(distance: 10, availableDistance: 100, leadingOffset: 10, trailingOffset: 0)
        XCTAssert(zeroValueWithLeadingOffset == 0.0)
        
        let fullValueWithTrailingOffset = valueFrom(distance: 90, availableDistance: 100, leadingOffset: 0, trailingOffset: 10)
        XCTAssert(fullValueWithTrailingOffset == 1.0)
        
        let halfValueWithOffsets = valueFrom(distance: 50, availableDistance: 100, leadingOffset: 10, trailingOffset: 10)
        XCTAssert(halfValueWithOffsets == 0.5)
        
        let zeroValueLowerThanLeadingOffset = valueFrom(distance: 0, availableDistance: 100, leadingOffset: 10, trailingOffset: 10)
        XCTAssert(zeroValueLowerThanLeadingOffset == 0.0)
        
        let fullValueHigherThanLeadingOffset = valueFrom(distance: 100, availableDistance: 100, leadingOffset: 10, trailingOffset: 10)
        XCTAssert(fullValueHigherThanLeadingOffset == 1.0)
    }
}
