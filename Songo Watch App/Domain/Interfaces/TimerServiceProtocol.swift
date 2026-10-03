//
//  TimerServiceProtocol.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//
import Foundation

protocol TimerServiceProtocol {
    func start(onTick: @escaping () -> Void)
    func stop()
}
