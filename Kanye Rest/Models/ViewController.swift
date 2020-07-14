import UIKit
import UserNotifications

class ViewController: UIViewController {
    let url = "https://api.kanye.rest/"
    @IBOutlet weak var quetoLabel: UILabel!
    @IBOutlet weak var nextQuoteButton: UIButton!
    @IBOutlet weak var shareQuoteButton: UIButton!
    @IBOutlet weak var kanyeQuoteLabel: UILabel!
    
    let center = UNUserNotificationCenter.current()
    
    override func viewWillAppear(_ animated: Bool) {
        center.delegate = self
        frameAndLayer()
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
                guard let quote = kanyeQuote.last?.quote else{return}
                NotificationK().sendNatification(of: quote)
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
extension ViewController{
    func frameAndLayer(){
        nextQuoteButton.layer.cornerRadius = 10
        nextQuoteButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        nextQuoteButton.layer.shadowOpacity = 0.5
        shareQuoteButton.layer.cornerRadius = 10
        shareQuoteButton.layer.borderWidth = 0.5
        shareQuoteButton.layer.borderColor = UIColor.darkGray.cgColor
        shareQuoteButton.layer.shadowOpacity = 0.3
        shareQuoteButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        kanyeQuoteLabel.layer.shadowOpacity = 0.4
        kanyeQuoteLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
