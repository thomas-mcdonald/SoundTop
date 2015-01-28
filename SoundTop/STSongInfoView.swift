//
//  STSongInfoView.swift
//  SoundTop
//
//  Created by Thomas McDonald on 27/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STSongInfoView: NSView {
    var songTitleView : NSTextField = NSTextField()

    override var allowsVibrancy : Bool {
        get { return true }
    }

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
        songTitleView.autoresizingMask = NSAutoresizingMaskOptions.ViewMinXMargin
                                       | NSAutoresizingMaskOptions.ViewMaxXMargin
                                       | NSAutoresizingMaskOptions.ViewMinYMargin
                                       | NSAutoresizingMaskOptions.ViewMaxYMargin
        songTitleView.alignment = NSTextAlignment.CenterTextAlignment
        songTitleView.selectable = false
        songTitleView.editable = false
        songTitleView.stringValue = "No Qualms"
        songTitleView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 30)
        addSubview(songTitleView)
    }
}
