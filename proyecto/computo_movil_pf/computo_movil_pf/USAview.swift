import SwiftUI

struct USAView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                estadioRow(color: .green, name: "Estadio Atlanta")
                estadioRow(color: .blue, name: "Estadio Boston")
                estadioRow(color: .red, name: "Estadio Dallas")
                estadioRow(color: .orange, name: "Estadio Houston")
                estadioRow(color: .purple, name: "Estadio Kansas City")
                estadioRow(color: .cyan, name: "Estadio Los Angeles")
                estadioRow(color: .pink, name: "Estadio Miami")
                estadioRow(color: .indigo, name: "Estadio New York")
                estadioRow(color: .teal, name: "Estadio Philadelphia")
                estadioRow(color: .mint, name: "Estadio San Francisco")
                estadioRow(color: .gray, name: "Estadio Seattle")
            }
            
        }
        .ignoresSafeArea(edges: .top)     // cubre la Dynamic Island
    }

    @ViewBuilder
    private func estadioRow(color: Color, name: String) -> some View {
        ZStack {
            color.opacity(0.85)
            Text(name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 220)
    }
}

#Preview {
    NavigationStack {
        USAView()
    }
}
