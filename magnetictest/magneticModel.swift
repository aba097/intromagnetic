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
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.updateMotionData(deviceMotion: motion!)
            })
        }
        
        isStarted = true
    }
    
    func stop() {
        if isStarted {
            isStarted = false
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    private func updateMotionData(deviceMotion:CMDeviceMotion) {
        let xStr = String(deviceMotion.magneticField.field.x)
        let yStr = String(deviceMotion.magneticField.field.y)
        let zStr = String(deviceMotion.magneticField.field.z)
        
        self.delegate?.UpdateView(x: xStr, y: yStr, z: zStr)
    }
    
}
