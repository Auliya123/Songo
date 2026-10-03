//
//  GameSessionManager.swift
//  Songo
//
//  Created by Auliya Michelle Adhana on 01/10/26.
//

import Foundation
import WatchKit

class GameSessionManager: NSObject, WKExtendedRuntimeSessionDelegate {
    private var session: WKExtendedRuntimeSession?
    
    var isRunning: Bool {
        return session?.state == .running
    }

    func startSession() {
        if let currentSession = session, currentSession.state == .running || currentSession.state == .scheduled {
            return
        }

        let newSession = WKExtendedRuntimeSession()
        newSession.delegate = self
        self.session = newSession
        newSession.start()
        print("GameSessionManager: Extended runtime session started.")
    }

    func stopSession() {
        if let currentSession = session, currentSession.state == .running || currentSession.state == .scheduled {
            currentSession.invalidate()
        }
        session = nil
        print("GameSessionManager: Extended runtime session stopped.")
    }

    // MARK: - WKExtendedRuntimeSessionDelegate
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("GameSessionManager: Session did start - App will remain active and frontmost even when wrist is down or tilted.")
    }

    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("GameSessionManager: Session will expire - Restarting session to maintain active state.")
        session = nil
        startSession()
    }

    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: (any Error)?) {
        print("GameSessionManager: Session invalidated with reason: \(reason.rawValue), error: \(String(describing: error))")
        session = nil
    }
}
