//
//  STInfoTextField.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STInfoTextField: NSTextField {
    override init(frame: NSRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init() {
        super.init()
        setup()
    }

    func setup() {
        self.alignment = NSTextAlignment.CenterTextAlignment
        self.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.bordered = false
        self.selectable = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
