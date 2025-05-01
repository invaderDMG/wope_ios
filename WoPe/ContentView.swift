import SwiftUI

struct ContentView: View {
    @State private var isPublishing = false
    @State private var publishedText: String? = nil
    @State private var postText: String = ""
    @State private var postToBluesky: Bool = false
    @State private var statusMessage: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Escribe tu publicación:")
                .font(.headline)

            TextEditor(text: $postText)
                .frame(height: 150)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))

            Toggle("Bluesky", isOn: $postToBluesky)

            Button("Enviar") {
                if isPublishing {
                    ProgressView("Publicando...").padding()
                }
                if postToBluesky {
                    isPublishing = true
                    statusMessage = ""
                    BlueskyService().post(text: postText) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let response):
                                statusMessage = "✅ Publicado con éxito"
                                publishedText = postText
                                postText = ""
                            case .failure(let error):
                                statusMessage = "❌ Error: \(error.localizedDescription)"
                            }
                        }
                    }
                } else {
                    statusMessage = "Debes seleccionar una plataforma."
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Text(statusMessage)
                .foregroundColor(.gray)
                .padding(.top)

            Spacer()
        }
        .padding()
        if let post = publishedText {
            Divider().padding(.top)

            VStack(alignment: .leading, spacing: 8) {
                Text("👤 Juan_Roboto")
                    .font(.headline)
                Text(post)
                    .font(.body)
                Text("🕒 Justo ahora")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
}
