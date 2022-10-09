//
//  ViewController.swift
//  magnetictest
//
//  Created by 相場智也 on 2022/08/17.
//

import UIKit

class ViewController: UIViewController, MotionSensorDelegate {

    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    @IBOutlet weak var recordStartButton: UIButton!
    
    @IBOutlet weak var recordStopButton: UIButton!
    
    
    @IBOutlet weak var fileNameTextField: UITextField!
    
    //ファイルに記録しているかしていないかフラグ
    var recflag = false
    //記録したデータ 時間　何　データの順番，central,periheral,manager,vcで使用中
    var recdata: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let magneticmodel = MotionSensor()
        magneticmodel.delegate = self
        
        magneticmodel.start()
        
        recordStopButton.isEnabled = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //TextField以外をタッチしたときにキーボードを閉じる
        self.view.endEditing(true)
    }
    
    
    @IBAction func pressedRecordStartButton(_ sender: Any) {
        recordStartButton.isEnabled = false
        recordStopButton.isEnabled = true
        
        //MARK: -record prepare-
        recdata = ""
        recflag = true
        
        
    }
    
    @IBAction func pressedRecordStopButton(_ sender: Any) {
        recordStartButton.isEnabled = true
        recordStopButton.isEnabled = false

        recflag = false
        
        //MARK: -filename-
        let dt = Date()
        let dateformat = DateFormatter()
        //dateformat
        dateformat.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd HHmmss", options: 0, locale: Locale(identifier: "ja_JP"))
        
        var filename = dateformat.string(from: dt).replacingOccurrences(of: ":", with: "-").replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: " ", with: "-")
        
        if fileNameTextField.text! != "" {
            filename = fileNameTextField.text!
        }
        
        
        //MARK: -write file-
        let filePath = NSHomeDirectory() + "/Documents/" + filename + ".csv"
        do{
            try recdata.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
            print("Success to Wite the File")
        }catch let error as NSError{
            print("Failure to Write File\n\(error)")
        }
        
    }
    
    func UpdateView(x: String, y: String, z: String) {
        xLabel.text = "x: " + x
        yLabel.text = "y: " + y
        zLabel.text = "z: " + z
        
        if recflag {
            recdata += (y + ", " + y + ", " + z)
//            //日付関連
//            let dt = Date()
//            let dateformat = DateFormatter()
//            //dateformat
//            dateformat.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd HH:mm:ss.SSS", options: 0, locale: Locale(identifier: "ja_JP"))
//    
//            recdata += (dateformat.string(from: dt) + ", " + function + ", " + data + "\n")
            
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
}

