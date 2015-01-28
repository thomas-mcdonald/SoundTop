//
//  STPlayerView.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STPlayerView: NSView {
    var playPauseButton: NSButton!

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

        playPauseButton = NSButton()
        playPauseButton.image = NSImage(byReferencingFile: NSBundle.mainBundle().pathForImageResource("play_b3b3b3_20.png")!)
        playPauseButton.alternateImage = NSImage(byReferencingFile: NSBundle.mainBundle().pathForImageResource("pause_b3b3b3_20.png")!)

        playPauseButton.bordered = false
        playPauseButton.imagePosition = NSCellImagePosition.ImageOnly
        playPauseButton.setButtonType(NSButtonType.ToggleButton)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playPauseButton)

        let viewsDict = ["playPauseButton": playPauseButton]
        addConstraint(NSLayoutConstraint(item: playPauseButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        // layout views vertically
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[playPauseButton(==20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[playPauseButton(==20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))

    }
}
