//
//  STPlayPauseButton.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STPlayPauseButton: NSButton {
    override init(frame: NSRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init() {
        super.init()
        setup()
    }

    func setup() {
        self.image = NSImage(byReferencingFile: NSBundle.mainBundle().pathForImageResource("play_b3b3b3_20.png")!)
        self.alternateImage = NSImage(byReferencingFile: NSBundle.mainBundle().pathForImageResource("pause_b3b3b3_20.png")!)
    }

    override func mouseDown(e: NSEvent) {
        var keepOn = true
        NSLog("highlighting")
        self.highlight(true)
        
        while(keepOn) {
            let mask = NSEventMask.LeftMouseUpMask
            let event = self.window!.nextEventMatchingMask(Int(mask.rawValue))
            self.highlight(false)
            NSLog("moving on")
            self.setNextState()
            keepOn = false
        }
        
        NSLog("done")
    }
    
//    override func mouseUp(e: NSEvent) {
//        NSLog("mouse up")
//        self.highlight(false)
//        self.setNextState()
//    }
}
