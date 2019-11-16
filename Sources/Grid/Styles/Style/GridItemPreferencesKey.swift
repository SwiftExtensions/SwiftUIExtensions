import SwiftUI

public struct GridItemPreferencesKey: PreferenceKey {
    public static var defaultValue: [GridItemPreferences] = []
    
    public static func reduce(value: inout [GridItemPreferences], nextValue: () -> [GridItemPreferences]) {
        value.append(contentsOf: nextValue())
    }
}

public struct GridItemBoundsPreferencesKey: PreferenceKey {
    public static var defaultValue: [CGRect] = []
    
    public static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}
