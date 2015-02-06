// STUpcomingCellView.swift
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

class STUpcomingCellView: NSView {
    private var albumImage: NSImageView!
    private var title: STInfoTextField!
    private var artist: STInfoTextField!
    var track: STTrack! {
        didSet { self.updateData() }
    }

    class func height() -> CGFloat { return 44 }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        // setup album art
        albumImage = NSImageView(frame: CGRectMake(0, 0, 100, 100))
        albumImage.translatesAutoresizingMaskIntoConstraints = false

        title = STInfoTextField()
        title.frame = CGRectMake(0, 0, self.frame.width - 60, 16)
        let font = NSFontManager().fontWithFamily(NSFont.systemFontOfSize(16).familyName!, traits: NSFontTraitMask(0), weight: 3, size: 16)
        title.font = font
        title.textColor = NSColor.labelColor()
        title.alignment = NSTextAlignment.LeftTextAlignment
        title.lineBreakMode = NSLineBreakMode.ByTruncatingTail

        artist = STInfoTextField()
        artist.alignment = NSTextAlignment.LeftTextAlignment
        artist.font = NSFont.systemFontOfSize(12)
        artist.textColor = NSColor.secondaryLabelColor()

        addSubview(albumImage)
        addSubview(title)
        addSubview(artist)

        let viewsDict = ["albumImage": albumImage, "title": title, "artist": artist]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[albumImage(==40)]-8-[title(==180)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[albumImage(==40)]-8-[artist(==100)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[albumImage(==40)]-2-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-6-[title(==18)][artist(==13)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDict))
    }

    func updateData() {
        if track.artworkURL != nil {
            let request = NSURLRequest(URL: NSURL(string: track.artworkURL!)!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    let image : NSImage = NSImage(data: data)!
                    self.albumImage.image = image
                    self.needsDisplay = true
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
        }
        title.stringValue = track.title!
        artist.stringValue = track.artist!
    }
}
