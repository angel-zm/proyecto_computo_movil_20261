import SwiftUI

struct MexicoView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let alturaTotal = proxy.size.height

                VStack (spacing: 0){
                    // Estadio Azteca con navegación
                    NavigationLink(destination: AztecaView(imageName: "azteca")) {
                        estadioRow(color: .green, name: "Estadio Azteca", height: alturaTotal / 3)
                    }

                    estadioRow(color: .blue, name: "Estadio BBVA", height: alturaTotal / 3)
                    estadioRow(color: .red, name: "Estadio Akron", height: alturaTotal / 3)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                // Botón de regreso superpuesto
            }
        }
    }

    @ViewBuilder
    private func estadioRow(color: Color, name: String, height: CGFloat) -> some View {
        ZStack {
            color.opacity(0.9)
            Text(name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        //.frame(maxWidth: .infinity)
        //.frame(height: height)
    }
}
#Preview {
    NavigationStack {
        MexicoView()
    }
}
