//
//  STPlayerView.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STPlayerView: NSView {
    var playButton: NSButton!

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
        let layer = CALayer.init()
        self.wantsLayer = true
        self.layer = layer
        self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.OnSetNeedsDisplay

        playButton = NSButton()
        playButton.title = "\u{f04b}"
        playButton.font = NSFont(name: "FontAwesome", size: 20)
        playButton.bordered = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playButton)

        let viewsDict = ["playButton": playButton]
        addConstraint(NSLayoutConstraint(item: playButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        // layout views vertically
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[playButton(==20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[playButton(==20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))

    }
}
