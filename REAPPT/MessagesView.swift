import SwiftUI

struct Message: Identifiable {
    var id = UUID()
    var sender: String
    var content: String
    var senderImage: Image // Profilbild des Absenders
}

struct ChatView: View {
    var message: Message
    
    var body: some View {
        VStack {
            message.senderImage // Anzeige des Profilbilds
            Text("Chat with \(message.sender)")
                .font(.title)
            Text(message.content)
        }
    }
}

struct GroupChatView: View {
    var messages: [Message]
    
    var body: some View {
        VStack {
            Text("Group Chat")
                .font(.title)
            List(messages) { message in
                HStack {
                    message.senderImage // Anzeige des Profilbilds
                    Text(message.sender)
                    Spacer()
                    Text(message.content)
                }
            }
        }
    }
}

struct MessagesView: View {
    @State private var messages = [
        Message(sender: "Tim", content: "Hello!", senderImage: Image(systemName: "person.circle")),
        Message(sender: "Clari", content: "Hi there!", senderImage: Image(systemName: "person.circle")),
        Message(sender: "Jörg", content: "Hey!", senderImage: Image(systemName: "person.circle")),
        Message(sender: "Mil", content: "Hi!", senderImage: Image(systemName: "person.circle")),
    ]
    
    @State private var newMessage = ""
    @State private var isGroupChat = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isGroupChat {
                    GroupChatView(messages: messages)
                        .navigationBarTitle("Messages")
                } else {
                    List(messages) { message in
                        NavigationLink(destination: ChatView(message: message)) {
                            HStack {
                                message.senderImage // Anzeige des Profilbilds
                                Text(message.sender)
                            }
                        }
                    }
                    .navigationBarTitle("Messages")
                }
                
                Divider()
                
                HStack {
                    TextField("Enter message", text: $newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: sendMessage) {
                        Text("Send")
                    }
                }
                .padding()
                
                Toggle("Group Chat", isOn: $isGroupChat)
                    .padding()
            }
        }
    }
    
    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        messages.append(Message(sender: "You", content: newMessage, senderImage: Image(systemName: "person.circle")))
        newMessage = ""
    }
}
