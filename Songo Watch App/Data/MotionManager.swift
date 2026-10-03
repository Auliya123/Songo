//
//  MotionManager.swift
//  songo
//
//  Created by Auliya Michelle Adhana on 27/09/26.
//

import Foundation
import CoreMotion
import Combine

class MotionManager: ObservableObject{
    private let motionManager = CMMotionManager()
    @Published var roll: Double = 0.0

    func startUpdates(){
        guard motionManager.isDeviceMotionAvailable else{
            print("Device Motion tidak tersedia")
            return
        }

        guard !motionManager.isDeviceMotionActive else { return }

        motionManager.deviceMotionUpdateInterval = 1.0/30.0

        motionManager.startDeviceMotionUpdates(to: .main){[weak self] data, error in
            guard let data = data else{return}
            self?.roll = data.attitude.roll
        }

    }

    func stopUpdates(){
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}
