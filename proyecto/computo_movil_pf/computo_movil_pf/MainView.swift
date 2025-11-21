import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = DeportesModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Botón de sedes adornado
                NavigationLink {
                    SedesView() // tu vista con TabView México/USA/Canadá
                } label: {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.18))
                                .frame(width: 44, height: 44)
                            Image(systemName: "mappin.and.ellipse")
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.white)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Sedes")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                            Text("Explora México, Estados Unidos y Canadá")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.9))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.green.opacity(0.95),
                                Color.blue.opacity(0.95),
                                Color.red.opacity(0.95)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                    .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .animation(.easeOut(duration: 0.2), value: UUID()) // sutil; placeholder para interacción
                }
                .buttonStyle(.plain) // evita estilo por defecto y respeta el diseño

                // Botón de equipos (opcional: coherencia visual)
                NavigationLink {
                    EquiposView() // tu vista con TabView México/USA/Canadá
                } label: {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.18))
                                .frame(width: 44, height: 44)
                            Image(systemName: "soccerball")
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.white)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Equipos")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                            Text("Selecciona tu favorito")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.9))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.green.opacity(0.95),
                                Color.blue.opacity(0.95),
                                Color.red.opacity(0.95)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                    .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
                // Botón de ia
                NavigationLink {
                    IaView() // tu vista con TabView México/USA/Canadá
                } label: {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.18))
                                .frame(width: 44, height: 44)
                            Image(systemName: "soccerball")
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.white)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text("IA")
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                            Text("Predice el resultado")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.9))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .background(
                        LinearGradient(
                            colors: [
                                Color.green.opacity(0.95),
                                Color.blue.opacity(0.95),
                                Color.red.opacity(0.95)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                    .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
                .padding(.top, 10)
                // Lista de partidos
                List(viewModel.partidos) { partido in
                    VStack(alignment: .leading) {
                        Text("\(partido.equipoLocal) vs \(partido.equipoVisitante)")
                            .font(.headline)
                        Text("Fecha: \(partido.fecha)")
                            .font(.subheadline)
                        Text("Resultado: \(partido.resultado)")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            }
            .padding(.horizontal, 16)
            .navigationTitle("Partidos")
            .onAppear {
                viewModel.fetchPartidos()
            }
            .padding(.top, 15)
        }
    }
}

#Preview {
    MainView()
}
