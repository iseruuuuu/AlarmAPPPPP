//
//  ShakeViewController.swift
//  AlarmAPP_new2
//
//  Created by 井関竜太郎 on 2021/03/19.
//

// やること TODO
/*
 
・・・・・・・・・・・・・・・・・・ ShakeViewのデザイン
・・・・・・・・・・・・・・・・・ ViewControllerのデザイン
 
 ・・・・・・・・・・・・・・・・シェイクの回数調整（ちょうど疲れるくらい。。。）
 
 //通知を無限にすることができた。しかし！！！！
 //設定した時間が秒数が正確になってしまう。。。。。。00秒に揃えたい。 =>>>別に時間だからいけるかな？？？
 
 
 
 
 おやすみモードに対応できるのか？ => だめだった。。
 マナーモードでも音を鳴らす。　＝＝＞
 サイレントモード　＝＝＞
 音声の変更　＝＝＞
 shakeがどうやったら識別するのかを説明する必要あり？？ ==>>>
 
 
 ・・・・・・・・・・・・通知を設定した時間が間違っている。 ===>>>修正済み
 
 
 
 */



import UIKit

class ShakeViewController: UIViewController {

    var currentNumber = 5
    @IBOutlet weak var label: UILabel!
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
    }
        currentNumber -= 1
        label.text = "あと　\(currentNumber)回"
        if (currentNumber <= 0) {
            label.text = "クリア！"
            // 通知を全削除する
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            // 指定した通知を削除する
            let identifiers = ["CalendarNotification1", "CalendarNotification2", "CalendarNotification3","CalendarNotification4"]
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "あと　\(currentNumber)回"
    }
}
