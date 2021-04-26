//
//  ViewController.swift
//  Change
//
//  Created by 王冊 on 2021/4/21.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var autoSwitch: UISwitch!
    
    let dateFormatter = DateFormatter()
    let image = ["2012","2013","2014","2015","2016","2017","2018","2019","2020","2021"]

    var dateString:String = ""
    var timer:Timer?
    var imageNumber = 0
    var sliderNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time()
        dateFormatter.dateFormat = "yyyyMMdd"
    }
    
    //使用switch做選擇照片的連續數值判斷
    func choosePicture(number:Int){
        switch number {
        case 0:
            dateString = "20120119"
        case 1:
            dateString = "20130119"
        case 2:
            dateString = "20140119"
        case 3:
            dateString = "20150119"
        case 4:
            dateString = "20160119"
        case 5:
            dateString = "20170119"
        case 6:
            dateString = "20180119"
        case 7:
            dateString = "20190119"
        case 8:
            dateString = "20200119"
        default:
            dateString = "20210119"
        }
        
        //使datePicker顯示之日期為dateString內的字串
        let date = dateFormatter.date(from: dateString)
        datePicker.date = date!
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let year = dateComponents.year!
        let picName = "\(year)"
        photoView.image = UIImage(named: picName)
    }
    
        //每秒執行一次compare(使圖片跑起來)
    func time() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { (timer) in self.compare()}
        )
    }
    
    //if eles, 比對Array內的照片
    func compare() {
        if imageNumber >= image.count{
        imageNumber = 0
        choosePicture(number: imageNumber)
        photoView.image = UIImage(named: image[imageNumber] )
        }else{
        choosePicture(number: imageNumber)
        photoView.image = UIImage(named: image[imageNumber] )
        }
        //slider跟著滑動
        timeSlider.value = Float(imageNumber)
        imageNumber += 1
    }
        
    @IBAction func changeImageDatePicker(_ sender: UIDatePicker) {
        //利用datePicker使用年、月選擇照片
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let year = dateComponents.year!
        let picName = "\(year)"
        
        photoView.image = UIImage(named: picName)
        timeSlider.value = Float(year - 2012) // timeSlider 是 0, 1, 2, 3
    }
    
    // 拉 slider 觸發
    @IBAction func changeTimeSlider(_ sender: UISlider) {
        sender.value.round()
        sliderNumber = Int(sender.value)
        let imageSlider = image[sliderNumber]
        photoView.image = UIImage(named: String(imageSlider))
        choosePicture(number: sliderNumber)
    }
        
    // auto
    @IBAction func turnSwitch(_ sender: UISwitch) {
        if sender.isOn{
            time()
            imageNumber = sliderNumber
            timeSlider.value = Float(imageNumber)
        }else{
            timer?.invalidate()
        }
    }
    //程式結束執行後 要 disable timer
    override func viewDidDisappear(_ animated: Bool) {
    timer?.invalidate()
    }
}


