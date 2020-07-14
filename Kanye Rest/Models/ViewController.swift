import UIKit
import UserNotifications

class ViewController: UIViewController {
    let url = "https://api.kanye.rest/"
    @IBOutlet weak var quetoLabel: UILabel!
    @IBOutlet weak var nextQuoteButton: UIButton!
    let center = UNUserNotificationCenter.current()
    
    override func viewWillAppear(_ animated: Bool) {
       center.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ParseJson().parseQuote(of: url, complitionHandler: {
            DispatchQueue.main.async {
                self.quetoLabel.text = kanyeQuote.last?.quote
            }
        })
        
    }
    
    
    @IBAction func nextQuote(_ sender: UIButton) {
        kanyeQuote.removeAll()
        ParseJson().parseQuote(of: url) {
            DispatchQueue.main.async {
                self.quetoLabel.text = kanyeQuote.last?.quote
            }
        }
    }
    @IBAction func sharedQuote(_ sender: UIButton) {
        guard let quote = kanyeQuote.last?.quote else{return}
        let activityController = UIActivityViewController(activityItems: [quote], applicationActivities: [])
        present(activityController, animated: true, completion: nil)
    }
    

}

extension ViewController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let id = Optional(response.actionIdentifier){
            switch id {
                case "shared.quote":
                    guard let quote = kanyeQuote.last?.quote else{return}
                    let activityController = UIActivityViewController(activityItems: [quote], applicationActivities: [])
                    present(activityController, animated: true, completion: nil)
                default:
                    break
                }
        }
    }
}
