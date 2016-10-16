// STAlbumView.swift
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

class STAlbumView: NSImageView {
    var trackingArea : NSTrackingArea?

    override var mouseDownCanMoveWindow: Bool {
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
        let url = NSURL(string: "https://i1.sndcdn.com/artworks-000092147250-ei0cxn-t500x500.jpg")!
        self.fetchImage(url);
    }

    func fetchImage(url : NSURL) {
        let request = NSURLRequest(URL: url) // TODO: unwrap optional properly
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?, data: NSData?,error: NSError?) -> Void in
            if error == nil {
                let image : NSImage = NSImage(data: data!)!
                self.image = image
                self.needsDisplay = true
            }
            else {
                self.print("Error: \(error!.localizedDescription)")
            }
        })
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if(trackingArea != nil) {
            removeTrackingArea(trackingArea!)
        }
        let opts : NSTrackingAreaOptions = [.MouseEnteredAndExited, .ActiveAlways]
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: opts, owner: nextResponder, userInfo: nil)
        addTrackingArea(trackingArea!)
    }
}
