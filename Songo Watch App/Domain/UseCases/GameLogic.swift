//
//  GameLogic.swift
//  songo
//
//  Created by Auliya Michelle Adhana on 27/09/26.
//
import Foundation

struct GameLogic {
    static func isDivisibleBy9(_ number: Int) -> Bool {
        return number % 9 == 0
    }

    static func generateNumber(divisibleBias: Double = 0.45) -> Int {
        let isDivisible = Double.random(in: 0...1) < divisibleBias

        if isDivisible {
            return Int.random(in: 112...1111) * 9
        } else {
            var number = Int.random(in: 1000...9999)
            if isDivisibleBy9(number) {
                number = (number == 9999) ? number - 1 : number + 1
            }
            return number
        }
    }
}

