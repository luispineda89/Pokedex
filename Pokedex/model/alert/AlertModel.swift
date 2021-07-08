//
//  AlertModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import SwiftUI

struct AlertModel: Identifiable, Equatable {
    var id: Int
    var title: String
    var text: String
    var textClose: String
    var textConfirm: String
    var type: AlertType
    
    init() {
        self.id = 1
        self.title = "TEXT_ERROR"
        self.text = "TEXT_TITLE_FAIL"
        self.textClose = "TEXT_CLOSE"
        self.textConfirm = ""
        self.type = .error
    }
    
    init(
        id: Int = 1,
        title: String,
        text: String,
        textClose: String = "TEXT_CLOSE",
        textConfirm: String = "",
        type: AlertType
    ) {
        self.id = id
        self.title = title
        self.text = text
        self.textClose = textClose
        self.textConfirm = textConfirm
        self.type = type
    }

    mutating func set(id: Int,
                       title: String,
                       text: String,
                       textClose: String = "TEXT_CLOSE",
                       textConfirm: String = "TEXT_CONFIRM",
                       type: AlertType) {
        self.id = id
        self.title = title
        self.text = text
        self.textClose = textClose
        self.textConfirm = textConfirm
        self.type = type
    }
}

