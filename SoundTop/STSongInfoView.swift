// STSongInfoView.swift
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
        self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.OnSetNeedsDisplay

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
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[songTitleView]-0-[songArtistView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict))
    }

    func updateTrack(track: STTrack) {
        songTitleView.stringValue = track.title! as String
        songArtistView.stringValue = track.artist! as String
    }
}
