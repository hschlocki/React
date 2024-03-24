import SwiftUI
import AVKit // Import AVKit für VideoPlayer
import Photos // Für den Zugriff auf die Fotobibliothek

struct CameraView: View {
    var mediaURL: URL?
    @State private var isRecording = false
    
    var body: some View {
        VStack {
            if let mediaURL = mediaURL {
                if isPhoto(mediaURL) {
                    Image(uiImage: loadImage(from: mediaURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding()
                } else {
                    // Verwendung von VideoPlayer aus AVKit
                    VideoPlayer(player: AVPlayer(url: mediaURL))
                        .frame(width: 200, height: 200)
                        .padding()
                }
                
                Button("Send") {
                    sendMedia(mediaURL)
                }
                .padding()
            } else {
                Text("No media selected.")
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    capturePhoto()
                }) {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                .padding()
                
                RecordButton(isRecording: $isRecording) {
                    if isRecording {
                        stopRecording()
                    } else {
                        startRecording()
                    }
                    isRecording.toggle()
                }
            }
        }
    }
    
    func isPhoto(_ url: URL) -> Bool {
        // Verwendung von PHAssetChangeRequest für die Überprüfung des Medientyps
        let asset = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject
        return asset?.mediaType == .image
    }
    
    func loadImage(from url: URL) -> UIImage {
        let asset = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        var image = UIImage()
        manager.requestImage(for: asset!, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options, resultHandler: {(result, info) -> Void in
            image = result!
        })
        return image
    }
    
    func capturePhoto() {
        // Hier kannst du die Logik für das Aufnehmen eines Fotos implementieren
        // Zum Beispiel: Verwendung der AVFoundation-Frameworks, um ein Foto aufzunehmen
        // Hier wird nur eine Ausgabe auf der Konsole simuliert
        print("Foto aufnehmen...")
    }
    
    func startRecording() {
        // Hier kannst du die Logik für den Start der Videoaufnahme implementieren
        // Zum Beispiel: Verwendung der AVFoundation-Frameworks, um die Videoaufnahme zu starten
        // Hier wird nur eine Ausgabe auf der Konsole simuliert
        print("Videoaufnahme starten...")
    }
    
    func stopRecording() {
        // Hier kannst du die Logik für das Stoppen der Videoaufnahme implementieren
        // Zum Beispiel: Verwendung der AVFoundation-Frameworks, um die Videoaufnahme zu stoppen
        // Hier wird nur eine Ausgabe auf der Konsole simuliert
        print("Videoaufnahme stoppen...")
    }
    
    func sendMedia(_ url: URL) {
        // Hier kannst du die Logik für das eigentliche Senden des Fotos oder Videos implementieren
        // Zum Beispiel: Verwendung einer API, um das Foto oder Video zu übertragen
        // Hier wird nur eine Ausgabe auf der Konsole simuliert
        
        if isPhoto(url) {
            print("Foto senden: \(url)")
        } else {
            print("Video senden: \(url)")
        }
    }
}

struct RecordButton: View {
    @Binding var isRecording: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: isRecording ? "stop.circle.fill" : "circle.fill")
                .foregroundColor(.red)
                .font(.system(size: 80))
                .padding()
        })
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.5, maximumDistance: .infinity)
                .onChanged { _ in
                    isRecording = true
                }
                .onEnded { _ in
                    isRecording = false
                }
        )
    }
}
