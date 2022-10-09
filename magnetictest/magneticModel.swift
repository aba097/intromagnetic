//
//  File.swift
//  magnetictest
//
//  Created by 相場智也 on 2022/08/18.
//

import Foundation
import CoreMotion

// デリゲートプロトコル
protocol MotionSensorDelegate {
    func UpdateView(x: String, y: String, z: String)
}

class MotionSensor: NSObject {
    
    var isStarted = false
    
    let motionManager = CMMotionManager()
    
    var delegate: MotionSensorDelegate?
    
    func start() {
        
        if motionManager.isDeviceMotionAvailable && !isStarted{
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(using: [.xMagneticNorthZVertical], to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                        self.updateMotionData(deviceMotion: motion)
                    })
            isStarted = true
        }
    }
    
    func stop() {
        if isStarted {
            isStarted = false
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    private func updateMotionData(deviceMotion: CMDeviceMotion?) {
        guard let field = deviceMotion?.magneticField.field else { return }
        
        let xStr = String(round(field.x * 100) / 100)
        let yStr = String(round(field.y * 100) / 100)
        let zStr = String(round(field.z * 100) / 100)
        
        self.delegate?.UpdateView(x: xStr, y: yStr, z: zStr)
    }
    
}
