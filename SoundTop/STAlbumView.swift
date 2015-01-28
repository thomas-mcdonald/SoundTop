//
//  STAlbumView.swift
//  SoundTop
//
//  Created by Thomas McDonald on 27/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STAlbumView: NSImageView {
    var trackingArea : NSTrackingArea?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect);
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        setup()
    }
    
    func setup() {
        let url = NSURL(string: "https://i1.sndcdn.com/artworks-000092147250-ei0cxn-t500x500.jpg")!
        self.fetchImage(url);
    }

    func fetchImage(url : NSURL) {
        let request = NSURLRequest(URL: url) // TODO: unwrap optional properly
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            if error == nil {
                let image : NSImage = NSImage(data: data)!
                self.image = image
                self.needsDisplay = true
            }
            else {
                println("Error: \(error.localizedDescription)")
            }
        })
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if(trackingArea != nil) {
            removeTrackingArea(trackingArea!)
        }
        let opts = NSTrackingAreaOptions.MouseEnteredAndExited | NSTrackingAreaOptions.ActiveAlways
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: opts, owner: nextResponder, userInfo: nil)
        addTrackingArea(trackingArea!)
    }
}
