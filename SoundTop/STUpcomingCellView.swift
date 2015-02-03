//
//  STUpcomingCellView.swift
//  SoundTop
//
//  Created by Thomas McDonald on 30/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

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
