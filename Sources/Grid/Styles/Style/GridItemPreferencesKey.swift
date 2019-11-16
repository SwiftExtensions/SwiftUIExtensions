import SwiftUI

public struct GridItemPreferencesKey: PreferenceKey {
    public static var defaultValue: [GridItemPreferences] = []
    
    public static func reduce(value: inout [GridItemPreferences], nextValue: () -> [GridItemPreferences]) {
        value.append(contentsOf: nextValue())
    }
}

public struct GridItemBoundsKey: PreferenceKey {
    public static var defaultValue: [Anchor<CGRect>] = []
    
    public static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> [Anchor<CGRect>]) {
        value.append(contentsOf: nextValue())
    }
}
