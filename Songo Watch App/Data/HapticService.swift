//
//  HapticService.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//

import WatchKit

class HapticService: HapticServiceProtocol{
    func playSuccess(){
        WKInterfaceDevice.current().play(.success)
    }

    func playFailure(){
        WKInterfaceDevice.current().play(.failure)
    }

    func playTimerTick(){
        WKInterfaceDevice.current().play(.click)
    }

    func playNewRecord(){
        WKInterfaceDevice.current().play(.notification)
    }

    func playGameOver(){
        WKInterfaceDevice.current().play(.retry)
    }
}
