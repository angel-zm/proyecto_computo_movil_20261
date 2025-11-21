import SwiftUI

struct SedesView: View {
    var body: some View {
        VStack(spacing: 0) {
            // 🇲🇽 Sección México
            NavigationLink(destination: MexicoView()) {
                ZStack {
                    Color.green.opacity(0.8)
                    Text("México")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height / 3)
            }

            // 🇺🇸 Sección Estados Unidos
            NavigationLink(destination: USAView()) {
                ZStack {
                    Color.blue.opacity(0.8)
                    Text("Estados Unidos")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height / 3)
            }

            // 🇨🇦 Sección Canadá
            NavigationLink(destination: CanadaView()) {
                ZStack {
                    Color.red.opacity(0.8)
                    Text("Canadá")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height / 3)
            }
        }
        .ignoresSafeArea()

    }
}

#Preview {
    NavigationStack {
        SedesView()
    }
}
