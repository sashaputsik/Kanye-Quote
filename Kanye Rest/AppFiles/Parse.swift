import Foundation
import UserNotifications
var kanyeQuote = [KanyeQuote]()

class ParseJson{
    func parseQuote(of urlString: String, complitionHandler: (()->Void)?){
        guard let url = URL(string: urlString) else{return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else{return}
            print(json)
            if let quote = json["quote"] as? String{
                print(quote)
                let quoteK = KanyeQuote(quote: quote)
                kanyeQuote.append(quoteK)
                complitionHandler?()
            }
            print(kanyeQuote)
        }.resume()
    }
}

