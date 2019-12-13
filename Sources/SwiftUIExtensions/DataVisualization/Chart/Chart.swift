import SwiftUI

public struct Chart: View {
    @Environment(\.chartStyle) private var style
    
    private var configuration: ChartStyleConfiguration
    
    public var body: some View {
        self.style.makeBody(configuration: self.configuration)
    }
}

extension Chart {
    init(_ configuration: ChartStyleConfiguration) {
        self.configuration = configuration
    }
}

extension Chart {
    public init<Data: RandomAccessCollection>(data: Data) where Data.Element : BinaryFloatingPoint {
        self.init(ChartStyleConfiguration(dataMatrix: data.map { [CGFloat($0)] }))
    }
    
    public init<Data: RandomAccessCollection>(data: [Data]) where Data.Element : BinaryFloatingPoint {
        self.init(ChartStyleConfiguration(dataMatrix: data.map({ $0.map { CGFloat($0) } })))
    }
}
