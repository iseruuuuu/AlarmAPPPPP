//
//  ViewController.swift
//  AlarmAPP_new
//
//  Created by 井関竜太郎 on 2021/01/08.



import UIKit
import AVFoundation
import MediaPlayer
import NotificationCenter

class ViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    weak var timer: Timer?
    var notification = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "sample.mp3"))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let format  = DateFormatter()
        format.calendar = Calendar(identifier: .gregorian)
        format.locale = Locale(identifier: "ja_JP")
        format.timeZone = TimeZone(identifier: "Asia/Tokyo")
        format.dateFormat = "MM月dd日HH:mm:ss"
        button.layer.cornerRadius = 20
        stopButton.layer.borderColor = UIColor.gray.cgColor
        stopButton.layer.borderWidth = 3
        stopButton.setTitleColor(.white, for: .normal)
        stopButton.layer.cornerRadius = 30.0
        stopButton.layer.masksToBounds = true;
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(displayP3Red: 0/255, green: 172/255, blue: 254/255,alpha: 1.0).cgColor, UIColor(displayP3Red: 79/255, green: 242/255, blue: 254/255,alpha: 1.0).cgColor]
        stopButton.layer.insertSublayer(gradientLayer, at:0)
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.setValue(false, forKey: "highlightsToday")
    }
    
    
    @IBAction func setTimer(_ sender: Any) {
        let format  = DateFormatter()
        format.calendar = Calendar(identifier: .gregorian)
        format.locale = Locale(identifier: "ja_JP")
        format.timeZone = TimeZone(identifier: "Asia/Tokyo")
        format.dateFormat = "MM月dd日HH:mm:ss"
        let dataString = format.string(from: Date())
        print(dataString)
        
        //もし通知をオンにしていたら。
        if (UIApplication.shared.currentUserNotificationSettings?.types.contains( UIUserNotificationType.alert))! {
            for i in 0...63 {
                let content = UNMutableNotificationContent()
                content.title = "おはようございます"
                content.body = "朝になりました！！\(i)回目でーす！"
                content.sound = notification
                
                
                
                if let path = Bundle.main.path(forResource: "ii", ofType: "jpg") {
                    content.attachments = [try! UNNotificationAttachment(identifier: "renchon", url: URL(fileURLWithPath: path), options: nil)]}
                let n = datePicker.date.addingTimeInterval(TimeInterval(0 + (3 * i)))
                let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: n)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                let request = UNNotificationRequest.init(identifier: "CalendarNotification\(i)",content: content,trigger: trigger)
                UNUserNotificationCenter.current().add(request) { error in
                    print(request)
                    if error != nil {
                        print("something went wrong")
                    }
                }
                
                let content2 = UNMutableNotificationContent()
                content2.title = "起床時間：\(format.string(from: datePicker.date))"
                content2.body = "この通知を消さないようにお願いします！"
                content2.sound = notification
                if let path = Bundle.main.path(forResource: "s", ofType: "jpg") {
                    content2.attachments = [try! UNNotificationAttachment(identifier: "renchon", url: URL(fileURLWithPath: path), options: nil)]
                }
                let trigger2 = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
                let request2 = UNNotificationRequest.init(identifier: "Calendar", content: content2, trigger: trigger2)
                UNUserNotificationCenter.current().add(request2, withCompletionHandler: nil)
            }
        }else {
            let dialog = UIAlertController(title: "通知をオンにしてください。", message: "協力お願いします", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "設定する", style: .default, handler:{ action in
                let url = URL(string: "app-settings:root=General&path=com.gekkado.lunascope")
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }))
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func stop(_ sender: Any) {
        
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "next") as! ShakeViewController
        self.present(next, animated: true, completion: nil)
    }
}


