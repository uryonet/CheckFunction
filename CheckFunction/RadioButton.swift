//
//  RadioButton.swift
//  CheckFunction
//
//  Created by 米山諒 on 2019/01/04.
//  Copyright © 2019 yoneyama ryo. All rights reserved.
//

import UIKit

enum LoginSettingsState: String {
    case NONE = "Not Selected"
    case BIOMETRICS = "Biometrics Authentications"
    case AUTO = "Automatic Authentications"
    case MANUAL = "Manual Authentications"
}

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
}

class SwitchButton: UIButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        toggleButton()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
}
