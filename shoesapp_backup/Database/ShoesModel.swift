import Foundation

class ShoesModel: ObservableObject {
    @Published var shoes: [Shoe] // Definir a lista de sapatos
    
    init() {
        self.shoes = [
            Shoe(name: "Pegasus Trail", imageName: "Pegasus_Trail", sceneName: "Pegasus_Trail.scn", price: 189, shoesType: "Running"),
            Shoe(name: "Zoom X", imageName: "zoom_x", sceneName: "zoom_x.scn", price: 199, shoesType: "Running"),
            Shoe(name: "Nike React", imageName: "nike_react", sceneName: "nike_react.scn", price: 149, shoesType: "Running"),
            Shoe(name: "Pegasus One", imageName: "pegasus_one", sceneName: "pegasus_one.scn", price: 119, shoesType: "Running"),
            Shoe(name: "Nike SB", imageName: "nike_dunk", sceneName: "nike_dunk.scn", price: 89, shoesType: "Lifestyle"),
            Shoe(name: "Nike Off White", imageName: "NikeOff-White", sceneName: "NikeOff-White.scn", price: 129, shoesType: "Lifestyle"),
            Shoe(name: "Nike AirMax", imageName: "nike_airmax", sceneName: "nike_airmax.scn", price: 110, shoesType: "Lifestyle"),
            Shoe(name: "Nike 60", imageName: "nike_60", sceneName: "nike_60.scn", price: 129, shoesType: "Lifestyle"),
            Shoe(name: "Nike Jordan", imageName: "nike_jordan", sceneName: "nike_jordan.scn", price: 199, shoesType: "Lifestyle")
        ]
    }
}

struct Shoe: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let sceneName: String
    let shoesType: String
    let price: Int
    
    // Inicializador personalizado para permitir a inicialização de objetos Shoe com ou sem preço
    init(name: String, imageName: String, sceneName: String, price: Int = 00, shoesType: String) {
        self.name = name
        self.imageName = imageName
        self.sceneName = sceneName
        self.price = price
        self.shoesType = shoesType
    }
}
