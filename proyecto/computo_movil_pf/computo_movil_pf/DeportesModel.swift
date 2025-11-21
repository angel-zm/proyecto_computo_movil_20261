import Foundation
import Combine

class DeportesModel: ObservableObject {
    @Published var partidos: [Partido] = []

    func fetchPartidos() {
        // Para prueba rápida, datos estáticos:
        let partidosPrueba = [
            Partido(equipoLocal: "México", equipoVisitante: "Estados Unidos", fecha: "2026-06-10", resultado: "2-1"),
            Partido(equipoLocal: "Canadá", equipoVisitante: "Brasil", fecha: "2026-06-12", resultado: "1-3")
        ]
        self.partidos = partidosPrueba

        // Si tuvieras API real:
        /*
        guard let url = URL(string: "https://mi-api-deportes.com/partidos") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode([Partido].self, from: data) {
                    DispatchQueue.main.async {
                        self.partidos = decoded
                    }
                }
            }
        }.resume()
        */
    }
}
