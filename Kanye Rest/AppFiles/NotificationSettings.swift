import Foundation
import UserNotifications
class NotificationK{
    let center = UNUserNotificationCenter.current()
    
    func sendNatification(of quote: String){
        let content = UNMutableNotificationContent()
        content.body = quote
        content.sound = .default
        var dateComp = DateComponents()
        dateComp.hour = 17
        dateComp.minute = 01
        
        let shareAction = UNNotificationAction(identifier: "shared.quote", title: "Share Quote", options: .foreground)
        let categoryAction = UNNotificationCategory(identifier: "shared.quote.category", actions: [shareAction], intentIdentifiers: [], options: [])
        content.categoryIdentifier = "shared.quote.category"
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        let request = UNNotificationRequest(identifier: "quote", content: content, trigger: trigger)
        self.center.setNotificationCategories([categoryAction])
        self.center.add(request, withCompletionHandler: nil)
        }
    
}
