import SwiftUI

struct CanadaView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                estadioRow(color: .green, name: "Estadio toronto")
                estadioRow(color: .blue, name: "Estadio BC Place Vancouver")
                
            }
            
        }
        .ignoresSafeArea(edges: .top)
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
        .frame(height: 440)
        
    }
}
#Preview {
    NavigationStack {
        CanadaView()
    }
}


