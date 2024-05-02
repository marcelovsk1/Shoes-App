import SwiftUI

struct BagView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Spacer()
            Image(systemName: "bag")
                .font(.system(size: 80))
                .padding()
            Text("Your Bag is Empty.")
                .font(.title)
                .font(.system(size: 24))
                .padding()
                
            Spacer()
            
            NavigationLink(destination: HomePage()) {
                Text("Shop Now")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .navigationTitle("Bag")
    }
}

struct BagView_Previews: PreviewProvider {
    static var previews: some View {
        BagView()
    }
}
