//
//  Logger.swift
//  myCocoaPodLibrary
//
//  Created by Abhishek.Batra on 6/26/23.
//

import Foundation


public class Logger{
    var timer : Timer?
   
    public init() {
        setUpData()
    }
    
    private func setUpData() {
        let queue = DispatchQueue.global(qos: .background)
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
                print("Timer fired!")
            }
        }
        queue.async {
            RunLoop.current.add(self.timer ?? Timer(), forMode: .default)
            RunLoop.current.run()
        }
    }
    
    
    public func printLog() {
        print("Hello world")
    }
    
    func privateMethod() {
        print("Private")
    }
    
    
}
