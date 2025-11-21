import SwiftUI
import SceneKit

struct AztecaView: View {
    @Environment(\.dismiss) var dismiss
    var imageName: String
    var presentedFromNavigation: Bool = false

    var body: some View {
        ZStack {
            // Visor de panorama 3D
            PanoramaSCNView(imageName: imageName)
                .ignoresSafeArea()

            // Botón de regreso superpuesto (solo si NO viene de NavigationLink)
            if !presentedFromNavigation {
                VStack {
                    HStack {
                        Button(action: {
                            dismiss() // Acción para cerrar esta vista
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.leading, 10)
            }
        }
        // Si viene de NavigationLink, no ocultes el back del sistema.
        // Si NO viene de NavigationLink, ocúltalo para usar el botón custom.
        .navigationBarBackButtonHidden(!presentedFromNavigation ? true : false)
    }
}

struct PanoramaSCNView: UIViewRepresentable {
    let imageName: String

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        let scene = SCNScene()

        // 🌐 Esfera invertida (Skybox)
        let sphere = SCNSphere(radius: 50)
        sphere.firstMaterial?.diffuse.contents = UIImage(named: imageName)
        sphere.firstMaterial?.isDoubleSided = true
        sphere.firstMaterial?.cullMode = .front
        sphere.firstMaterial?.lightingModel = .constant

        // Nodo de la esfera que rotaremos con gestos
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.scale = SCNVector3(-1, 1, 1)
        scene.rootNode.addChildNode(sphereNode)

        // 🎥 Cámara en el centro
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()

        // FOV más natural para evitar efecto "balón"
        cameraNode.camera?.fieldOfView = 75.0

        cameraNode.position = SCNVector3(0, 0, 0)
        scene.rootNode.addChildNode(cameraNode)

        // SIN rotación automática

        // Configuración final de la vista
        scnView.scene = scene
        scnView.backgroundColor = .black

        // Desactivar controles automáticos para evitar zoom/traslación
        scnView.allowsCameraControl = false

        // Guardar referencias en el coordinador
        context.coordinator.sphereNode = sphereNode
        context.coordinator.scnView = scnView

        // Gestos: solo rotación con pan; sin pinch (zoom) y sin pan de traslación
        let pan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(_:)))
        pan.maximumNumberOfTouches = 1
        scnView.addGestureRecognizer(pan)

        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}

    // MARK: - Coordinator para manejar gestos
    class Coordinator: NSObject {
        weak var scnView: SCNView?
        weak var sphereNode: SCNNode?

        // Estado de rotación acumulada
        private var currentYaw: Float = 0      // rotación alrededor de Y (horizontal)
        private var currentPitch: Float = 0    // rotación alrededor de X (vertical)

        // Sensibilidad del gesto
        private let rotationSensitivity: Float = 0.005
        private let minPitch: Float = -.pi / 2 * 0.98  // Limitar para evitar “voltearse” completo
        private let maxPitch: Float =  .pi / 2 * 0.98

        private var lastTranslation: CGPoint = .zero

        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let sphereNode = sphereNode else { return }

            switch gesture.state {
            case .began:
                // No hay rotación automática que pausar
                lastTranslation = .zero
            case .changed:
                let translation = gesture.translation(in: gesture.view)
                let delta = CGPoint(x: translation.x - lastTranslation.x,
                                    y: translation.y - lastTranslation.y)
                lastTranslation = translation

                // Actualizar yaw y pitch en función del arrastre
                currentYaw   -= Float(delta.x) * rotationSensitivity
                currentPitch -= Float(delta.y) * rotationSensitivity
                currentPitch = max(minPitch, min(maxPitch, currentPitch))

                // Aplicar rotación: primero X (pitch), luego Y (yaw)
                var transform = SCNMatrix4Identity
                transform = SCNMatrix4Rotate(transform, currentYaw, 0, 1, 0)
                transform = SCNMatrix4Rotate(transform, currentPitch, 1, 0, 0)
                sphereNode.transform = transform
            case .ended, .cancelled, .failed:
                // No reanudar rotación automática
                lastTranslation = .zero
            default:
                break
            }
        }
    }
}

#Preview {
    NavigationStack {
        // Asegúrate de usar el nombre de archivo correcto de tu imagen.
        AztecaView(imageName: "azteca", presentedFromNavigation: true)
    }
}
