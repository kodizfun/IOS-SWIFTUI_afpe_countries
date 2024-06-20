import Foundation

// DTO (Data Transport Object) : Modélisation des données retournées par l'API
struct CountriesResponse: Decodable {
    let records: [Country]
}

struct Country: Identifiable, Decodable {
    let id: String
    let fields: Fields
}

struct Fields: Decodable {
    let code: String
    let name: String
    let flag: [Flag]
}

struct Flag: Decodable {
    let url: String
}


