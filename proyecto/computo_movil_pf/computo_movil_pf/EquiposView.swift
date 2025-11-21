import SwiftUI

struct EquiposView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                NavigationLink(destination: MexicoteamView()) {
                    estadioRow(color: .green, name: "Mexico")
                }
                estadioRow(color: .red, name: "España")
                estadioRow(color: .yellow, name: "Alemania")
                estadioRow(color: .white, name: "Inglaterra", textColor: .black)
                estadioRow(color: .blue, name: "Francia")
                estadioRow(color: .red, name: "Croacia")
                estadioRow(color: .blue, name: "Italia")
                estadioRow(color: .yellow, name: "Brasil")
                estadioRow(color: .white, name: "Japon")
                estadioRow(color: .red, name: "Belgica")
                estadioRow(color: .red, name: "Marruecos")
            }
            
        }
        .ignoresSafeArea(edges: .top)     // cubre la Dynamic Island
    }

    @ViewBuilder
    private func estadioRow(color: Color, name: String, textColor: Color = .white) -> some View {
        ZStack {
            color.opacity(0.85)
            Text(name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 220)
    }
}

#Preview {
    NavigationStack {
        EquiposView()
    }
}

