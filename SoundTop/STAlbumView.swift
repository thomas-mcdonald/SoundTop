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
        self.enabled = true
        self.fetchImage();
    }

    func fetchImage() {
        let imagestr = "https://i1.sndcdn.com/artworks-000092147250-ei0cxn-t500x500.jpg"
        let imageURL = NSURL(string: imagestr)

        let request = NSURLRequest(URL: imageURL!) // TODO: unwrap optional properly
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            println(response.description)
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

    override func mouseEntered(theEvent: NSEvent) {
        NSLog("Mouse entered")
    }
    
    override func mouseExited(theEvent: NSEvent) {
        NSLog("Mouse exited")
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if(trackingArea != nil) {
            removeTrackingArea(trackingArea!)
        }
        let opts = NSTrackingAreaOptions.MouseEnteredAndExited | NSTrackingAreaOptions.ActiveAlways
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: opts, owner: self, userInfo: nil)
        addTrackingArea(trackingArea!)
    }
}
