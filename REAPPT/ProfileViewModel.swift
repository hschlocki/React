import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    
    func fetchUserProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { [weak self] (document, error) in
            if let document = document, document.exists, let data = document.data() {
                self?.userProfile = UserProfile(dictionary: data)
            } else {
                print("Document does not exist: \(error?.localizedDescription ?? "")")
            }
            // Implementation to fetch user profile from Firebase
        }
        
        // Add more methods as necessary for your ViewModel
    }
}
