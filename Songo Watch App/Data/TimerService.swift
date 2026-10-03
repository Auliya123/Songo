//
//  TimerService.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//
import Foundation
import Combine

class TimerService: TimerServiceProtocol {
    private var cancellable: AnyCancellable?
    func start(onTick: @escaping () -> Void) {
        stop()
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                onTick()
            }
    }
    func stop() {
        cancellable?.cancel()
        cancellable = nil
    }
}


