import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var authService: AuthenticationService
    @ObservedObject var profileViewModel = ProfileViewModel() // Initializes ProfileViewModel

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            CameraView()
                .tabItem {
                    Label("Camera", systemImage: "camera.fill")
                }
            MessagesView()
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            // Pass the profile data from the ViewModel to ProfileView
            if let userProfile = profileViewModel.userProfile {
                ProfileView(userProfile: userProfile)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        }
        .onAppear {
            profileViewModel.fetchUserProfile()
        }
    }
}
