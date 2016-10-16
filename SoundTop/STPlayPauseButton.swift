// STPlayPauseButton.swift
//
// Copyright (c) 2015 Thomas McDonald
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer. Redistributions in binary
// form must reproduce the above copyright notice, this list of conditions and
// the following disclaimer in the documentation and/or other materials
// provided with the distribution. Neither the name of the nor the names of
// its contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[playImageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[pauseImageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[playImageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[pauseImageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
    }

    override func mouseDown(e: NSEvent) {
        var keepOn = true

        while(keepOn) {
            let mask = NSEventMask.LeftMouseUp
            let event = self.window!.nextEventMatchingMask(NSEventMask(rawValue: UInt64(Int(mask.rawValue))))
            nextState()
            keepOn = false
        }
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
