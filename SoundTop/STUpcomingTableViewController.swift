//
//  STUpcomingTableViewController.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STUpcomingTableViewController: NSObject, NSTableViewDelegate, NSTableViewDataSource {
    private var tracks: [STTrack] = []
    @IBOutlet weak var tableView: NSTableView!

    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateData", name: "newTracks", object: nil)
    }

    func updateData() {
        let delegate = NSApplication.sharedApplication().delegate as AppDelegate
        tracks = delegate.trackList
        tableView.reloadData()
    }

    // MARK: NSTableViewDataSource

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return tracks[row]
    }

    // MARK: NSTableViewDelegate

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = STUpcomingCellView(frame: CGRectMake(0, 0, 100, 100))
        cell.track = tracks[row]
        return cell
    }

    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return STUpcomingCellView.height()
    }
}
