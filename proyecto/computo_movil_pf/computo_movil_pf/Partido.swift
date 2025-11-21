import Foundation

struct Partido: Identifiable, Decodable {
    let id = UUID()
    let equipoLocal: String
    let equipoVisitante: String
    let fecha: String
    let resultado: String
}
