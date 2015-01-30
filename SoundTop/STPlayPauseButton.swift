//
//  STPlayPauseButton.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STPlayPauseButton: NSControl {
    private var pauseImageView: NSImageView!
    private var playImageView: NSImageView!
    private var playState = false

    override init(frame: NSRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        NSLog("setting up")
        let playImage = NSImage(byReferencingFile: NSBundle.mainBundle().pathForImageResource("play_b3b3b3_20.png")!)
        let pauseImage = NSImage(byReferencingFile: NSBundle.mainBundle().pathForImageResource("pause_b3b3b3_20.png")!)

        playImageView = NSImageView()
        playImageView.image = playImage
        playImageView.translatesAutoresizingMaskIntoConstraints = false

        pauseImageView = NSImageView()
        pauseImageView.image = pauseImage
        pauseImageView.hidden = true
        pauseImageView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(pauseImageView)
        self.addSubview(playImageView)

        // add constraints
        let viewsDict = ["pauseImageView": pauseImageView, "playImageView": playImageView]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[playImageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[pauseImageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[playImageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[pauseImageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
    }

    override func mouseDown(e: NSEvent) {
        var keepOn = true
        NSLog("highlighting")
        
        while(keepOn) {
            let mask = NSEventMask.LeftMouseUpMask
            let event = self.window!.nextEventMatchingMask(Int(mask.rawValue))
            nextState()
            NSLog("moving on")
            keepOn = false
        }
        
        NSLog("done")
    }

    private func nextState() {
        if(playState) {
            NSNotificationCenter.defaultCenter().postNotificationName("paused", object: nil)
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("playing", object: nil)
        }
    }

    func showPause() {
        playState = true
        playImageView.hidden = true
        pauseImageView.hidden = false
    }

    func showPlay() {
        playState = false
        pauseImageView.hidden = true
        playImageView.hidden = false
    }
}
