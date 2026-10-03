//
//  HapticServiceProtocol.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//

import Foundation

protocol HapticServiceProtocol {
    func playSuccess()
    func playFailure()
    func playTimerTick()
    func playNewRecord()
    func playGameOver()
}
