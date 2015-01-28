//
//  STSongInfoView.swift
//  SoundTop
//
//  Created by Thomas McDonald on 27/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STSongInfoView: NSView {
    var songTitleView : STInfoTextField = STInfoTextField()
    var songArtistView : STInfoTextField = STInfoTextField()

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

        // add song title
        songTitleView.stringValue = "No Qualms"
        songTitleView.textColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        songTitleView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 15)
        songTitleView.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0)
        addSubview(songTitleView)

        // add song artist
        songArtistView.stringValue = "Karma Kid - No Qualms"
        songArtistView.textColor = NSColor.secondaryLabelColor()
        songArtistView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 15)
        songArtistView.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.addSubview(songArtistView)

        let viewsDict = ["songTitleView": songTitleView, "songArtistView": songArtistView]
        // center views
        addConstraint(NSLayoutConstraint(item: songTitleView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: songArtistView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        // layout views vertically
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[songTitleView]-0-[songArtistView]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
    }
}
