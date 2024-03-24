import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthenticationService
    @State private var email = ""
    @State private var password = ""
    @State private var showErrorAlert = false
    @State private var errorString = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Login") {
                authService.signIn(email: email, password: password) { success, error in
                    if success {
                        // Handle success
                    } else if let error = error {
                        errorString = error.localizedDescription
                        showErrorAlert = true
                    }
                }
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Login Error"), message: Text(errorString), dismissButton: .default(Text("OK")))
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}
