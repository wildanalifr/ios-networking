import Foundation

class PokemonService {
    
    func fetchData(completion: @escaping ([PokemonModel]?, Error?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let results = jsonObject["results"] as? [[String: Any]] {
                    let pokemons = results.map { PokemonModel(id: UUID(), name: $0["name"] as? String ?? "", url: $0["url"] as! String) }
                    completion(pokemons, nil)
                    print(results)
                } else {
                    print("Invalid JSON format")
                    completion(nil, NSError(domain: "Invalid JSON format", code: 0, userInfo: nil))
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
}
