import SwiftUI
import Firebase
import SDWebImageSwiftUI  // Assuming you're using this to handle image URLs

struct ProfileView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var selectedImage: UIImage?
    @State private var isEditingProfile = false
    @State private var userProfile: UserProfile
    @State private var imagePickerPresented = false

    init(userProfile: UserProfile) {
        _userProfile = State(initialValue: userProfile)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                profileHeader
                if isEditingProfile {
                    editProfileSection
                } else {
                    profileContentSection
                }
                signOutButton
            }
        }
        .navigationBarItems(trailing: editButton)
        .sheet(isPresented: $imagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
        .onAppear {
            fetchUserProfile()
        }
    }

    var profileHeader: some View {
        VStack {
            // Profile picture
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .onTapGesture {
                        imagePickerPresented = true
                    }
            } else if let imageUrl = userProfile.profileImageURL {
                WebImage(url: imageUrl) // This line requires SDWebImageSwiftUI
                    .resizable()
                    .placeholder(Image(systemName: "person.circle.fill"))
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        imagePickerPresented = true
                    }
            }

            Text(userProfile.username)
                .font(.title)
                .padding(.top)
        }
        .padding()
    }
    
    var editProfileSection: some View {
        Group {
            TextField("Bio", text: $userProfile.bio)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Website", text: Binding(
                get: { userProfile.website?.absoluteString ?? "" },
                set: { userProfile.website = URL(string: $0) }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        }
    }
    
    var profileContentSection: some View {
        VStack {
            Text(userProfile.bio)
            if let website = userProfile.website {
                Link("Website", destination: website)
            }
        }
        .padding()
    }

    var signOutButton: some View {
        Button(action: {
            authService.signOut()
        }) {
            Text("Sign Out")
                .foregroundColor(.red)
        }
        .padding()
    }

    var editButton: some View {
        Button(action: {
            isEditingProfile.toggle()
        }) {
            Text(isEditingProfile ? "Done" : "Edit")
        }
    }
    
    private func fetchUserProfile() {
        // Fetch the user profile from Firebase
        // This would involve calling Firebase Firestore and getting the user document
        // userProfile = ...
    }
    
    private func saveUserProfile() {
        // Save the edited user profile to Firebase
        // Update Firebase Firestore with the new userProfile data
        // Don't forget to handle image upload if selectedImage has been updated
    }
}
