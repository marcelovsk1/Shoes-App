import SwiftUI
import SceneKit

struct Lifestyle: View {
    let shoesModel = ShoesModel() // Criar uma instância do modelo fora da visualização de visualização rápida
    @State private var searchText = ""
    @State private var isImageTapped = "" // Variável para controlar qual imagem foi tocada

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Banner
                    ZStack {
                        Image("drake")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 20)
                    }
                    
                    Button(action: {
                        // Ação do botão
                    }) {
                        Text("LIFESTYLE")
                            .font(Font.custom("Futura-CondensedExtraBold", size: 34))
                            .italic()
                            .foregroundColor(.black)
                            .padding(.bottom, -20)
                    }
                    .padding(.horizontal)
                    
                    // Referência para a view Products com todos os sapatos do tipo Lifestyle
                    ProductsLifestyle(shoesModel: shoesModel, searchText: $searchText, isImageTapped: $isImageTapped)
                }
            }
            .navigationBarTitle("", displayMode: .inline) // Para ajustar a posição da barra de navegação
        }
    }
}

struct Lifestyle_Previews: PreviewProvider {
    static var previews: some View {
        Lifestyle()
    }
}

struct ProductsLifestyle: View {
    let shoesModel: ShoesModel // Receber o modelo como argumento
    @Binding var searchText: String
    @Binding var isImageTapped: String // Adicionar binding para controlar a navegação

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(shoesModel.shoes.filter {
                    ($0.shoesType == "Lifestyle") && (searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText))
                }) { shoe in
                    ProductCellLifestyle(shoe: shoe)
                }
            }
            .padding()
        }
    }
}

struct ProductCellLifestyle: View {
    let shoe: Shoe
    @State private var scene: SCNScene?

    private func loadScene() {
        scene = SCNScene(named: shoe.sceneName)
    }

    var body: some View {
        VStack {
            if let scene = scene {
                SceneView(scene: scene, options: [.autoenablesDefaultLighting, .allowsCameraControl])
                    .frame(width: 150, height: 150)
            } else {
                Image(shoe.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }

            Text(shoe.name)
                .font(.headline)
                .multilineTextAlignment(.center)

            if shoe.price > 0 {
                Text("$\(shoe.price)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .onAppear {
            loadScene()
        }
    }
}
