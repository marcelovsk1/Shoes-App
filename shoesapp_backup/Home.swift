import SwiftUI
import SceneKit
import PassKit

struct Home: View {
    @State var scene: SCNScene? = .init(named: "Pegasus_Trail.scn")
    @State var isVerticalLook: Bool = false
    @State var currentSize: String = "11"
    @State var currentShoes: String = ""
    @Namespace private var animation
    @GestureState var offset: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode // Adicionando o ambiente de apresentação para voltar à tela anterior

    var body: some View {
        NavigationView { // Envolve a VStack em uma NavigationView
            VStack {
                // Remova o HeaderView() que foi substituído pelo botão de navegação
                CustomSceneView(scene: $scene)
                    .frame(height: 350)
                    .padding(.top, -50)
                    .padding(.bottom, -15)
                    .zIndex(-10)
                CustomSeeker()
                ShoePropertiesViews()
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline) // Oculta o título da navegação
            .navigationBarBackButtonHidden(true) // Oculta o botão de navegação de volta padrão
            .navigationBarItems(leading: backButton) // Define o botão de volta personalizado
        }
    }
    
    // Define o botão de volta personalizado
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // Volta para a tela anterior quando o botão é pressionado
        }) {
            Image(systemName: "arrow.left") // Ícone de seta para a esquerda
                .foregroundColor(.black)
                .padding(.horizontal)
        }
    }

    func rotateObject(animate: Bool = false) {
        if animate {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.4
        }
        let newAngle = Float((offset * .pi) / 180)
        scene?.rootNode.eulerAngles.y = newAngle
        if animate {
            SCNTransaction.commit()
        }
    }

    @ViewBuilder
    func CustomSeeker() -> some View {
        GeometryReader {_ in
            Rectangle()
                .trim(from: 0, to: 0.474)
                .stroke(.linearGradient(colors: [
                    .clear,
                    .clear,
                    .black.opacity(0.2),
                    .black.opacity(0.6),
                    .white,
                    .black.opacity(0.6),
                    .black.opacity(0.2),
                    .clear,
                    .clear
                ], startPoint: .leading, endPoint: .trailing), style:
                    StrokeStyle(lineWidth: 2, lineCap: .round,
                    lineJoin: .round, miterLimit: 1, dash: [2], dashPhase: 1))
                .offset(x: offset)
                .overlay {
                    HStack(spacing: 3) {
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.caption)
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10,
                                         style: .continuous)
                        .fill(.orange)
                    }
                    .offset(y: -12)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .updating($offset, body: { value, out, _ in
                                out = value.location.x - 20 })
                    )
                }
        }
        .frame(height: 20)
        .onChange(of: offset, perform: { newValue in
            rotateObject(animate: offset == .zero)
        })
        .animation(.easeInOut(duration: 0.4), value: offset == .zero)
    }

    @ViewBuilder
    func ShoePropertiesViews() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Pegasus Trail")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Men's Shoes")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Label {
                    Text("4.9")
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                }
            }
            .padding(.top, 30)
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 12) {
                Text("Size")
                    .font(.title3.bold())
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        let sizes = ["9", "9.5", "10", "10.5", "11", "11.5", "12", "12.5"]
                        ForEach(sizes, id: \.self) { size in
                            Text(size)
                                .fontWeight(.semibold)
                                .foregroundColor(currentSize == size ? .orange : .black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .background {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(.black.opacity(0.2))
                                        if currentSize == size {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .fill(.black)
                                                .matchedGeometryEffect(id: size, in: animation)
                                        }
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        currentSize = size
                                    }
                                }
                        }
                    }
                }
            }
            .padding(.top, 20)

            HStack(alignment: .top) {
                Button(action: {
                    openApplePay()
                }) {
                    VStack(spacing: 12) {
                        Image(systemName: "bag")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                        Text("189.90")
                            .fontWeight(.semibold)
                            .padding(.top, 15)
                    }
                    .padding(18)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.white)
                    }
                }
                    VStack(alignment: .leading, spacing: 10) {
                    Text("The Nike Air Max is an icon of athletic fashion that transcends generations. Combining style and performance.")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    Button {

                    } label: {
                        Text("More Details")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            }
            .padding(.top, 30)
        }
    }

    // Abre o Apple Pay
    func openApplePay() {
        let request = PKPaymentRequest()
        // Configure sua solicitação de pagamento aqui
        
        guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else { return }
        paymentVC.delegate = PaymentDelegate()
        UIApplication.shared.windows.first?.rootViewController?.present(paymentVC, animated: true, completion: nil)
    }
}

// Implementação do PKPaymentAuthorizationViewControllerDelegate fora da definição da estrutura Home
class PaymentDelegate: NSObject, PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

#Preview { Home() }
