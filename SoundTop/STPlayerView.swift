//
//  STPlayerView.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STPlayerView: NSView {
    var playPauseButton: STPlayPauseButton?

    override class func requiresConstraintBasedLayout() -> Bool { return true }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect);
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        setup()
    }

    func setup() {
        NSLog("setting up STPlayerView")
        let layer = CALayer.init()
        self.wantsLayer = true
        self.layer = layer
        self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.OnSetNeedsDisplay

        playPauseButton = STPlayPauseButton(frame: CGRectMake(0, 0, 20, 20))
        playPauseButton!.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playPauseButton!)

        let viewsDict = ["playPauseButton": playPauseButton!]
        addConstraint(NSLayoutConstraint(item: playPauseButton!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        // layout views vertically
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[playPauseButton(==20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[playPauseButton(==20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
    }

    func paused() {
        playPauseButton!.showPlay()
    }

    func playing() {
        playPauseButton!.showPause()
    }
}
