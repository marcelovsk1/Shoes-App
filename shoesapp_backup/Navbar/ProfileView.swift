import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .foregroundColor(.black)
                .padding(.top, 50)
            
            Text("Welcome to Your Profile")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Manage your account settings and preferences here.")
                .font(.body)
                .multilineTextAlignment(.center)
            
//            Spacer()
            
            Button(action: {
                // Implement your action here
            }) {
                Text("Create Your Account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

