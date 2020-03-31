import SwiftUI

struct ImageDetailView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .navigationBarTitle("Image \(imageName)")
    }
}
