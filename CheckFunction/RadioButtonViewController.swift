//
//  RadioButtonViewController.swift
//  CheckFunction
//
//  Created by 米山諒 on 2018/12/29.
//  Copyright © 2018 yoneyama ryo. All rights reserved.
//

import UIKit

class RadioButtonViewController: UIViewController, AuthViewProtocol {
    
    var presenter: AuthPresenterProtocol!
    
    @IBOutlet weak var bioButton: RadioButton!
    @IBOutlet weak var autoButton: RadioButton!
    @IBOutlet weak var manualButton: RadioButton!
    @IBOutlet weak var bioImage: UIImageView!
    @IBOutlet weak var autoImage: UIImageView!
    @IBOutlet weak var manualImage: UIImageView!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var agreeButton: SwitchButton!
    @IBOutlet weak var agreeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = AuthPresenter(view: self)
        presenter.onViewInitialized()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        checkEmptyForm(textField: emailTextField)
        checkEmptyForm(textField: passwordTextField)
    }
    
    func initView() {
        bioButton.alternateButton = [autoButton, manualButton]
        autoButton.alternateButton = [bioButton, manualButton]
        manualButton.alternateButton = [bioButton, autoButton]
        
        emailView.layer.borderWidth = 1
        emailView.layer.borderColor = UIColor.black.cgColor
        emailView.layer.cornerRadius = 5
        passwordView.layer.borderWidth = 1
        passwordView.layer.borderColor = UIColor.black.cgColor
        passwordView.layer.cornerRadius = 5
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.text = "etsryacas@gmail.com"
        checkEmptyForm(textField: emailTextField)
    }
    
    @IBAction func tappedBioBtn(_ sender: RadioButton) {
        print(checkSelected()!)
        bioImage.image = UIImage(named: "radio_check")
        autoImage.image = UIImage(named: "radio_uncheck")
        manualImage.image = UIImage(named: "radio_uncheck")
        presenter.setLoginSettings(state: .BIOMETRICS)
    }
    @IBAction func tappedAutoBtn(_ sender: RadioButton) {
        print(checkSelected()!)
        bioImage.image = UIImage(named: "radio_uncheck")
        autoImage.image = UIImage(named: "radio_check")
        manualImage.image = UIImage(named: "radio_uncheck")
        presenter.setLoginSettings(state: .AUTO)
    }
    @IBAction func tappedManualBtn(_ sender: RadioButton) {
        print(checkSelected()!)
        bioImage.image = UIImage(named: "radio_uncheck")
        autoImage.image = UIImage(named: "radio_uncheck")
        manualImage.image = UIImage(named: "radio_check")
        presenter.setLoginSettings(state: .MANUAL)
    }
    
    @IBAction func tappedAgreeBtn(_ sender: SwitchButton) {
        if sender.isSelected {
            agreeImage.image = UIImage(named: "radio_check")
        } else {
            agreeImage.image = UIImage(named: "radio_uncheck")
        }
    }
    
    @IBAction func tappedLoginBtn(_ sender: UIButton) {
        presenter.onLogin()
    }
    
    private func checkSelected() -> RadioButton? {
        if bioButton.isSelected {
            return bioButton
        } else if autoButton.isSelected {
            return autoButton
        } else if manualButton.isSelected {
            return manualButton
        } else {
            return nil
        }
    }
    
    private func checkEmptyForm(textField: UITextField) {
        var view: UIView
        switch textField {
        case emailTextField:
            view = emailView
        case passwordTextField:
            view = passwordView
        default:
            view = UIView()
        }
        if let value = textField.text, !value.isEmpty {
            view.layer.borderWidth = 3
            view.layer.borderColor = UIColor.blue.cgColor
            view.layer.cornerRadius = 5
            view.backgroundColor = UIColor.lightGray
        } else {
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.cornerRadius = 5
            view.backgroundColor = UIColor.clear
        }
    }

}

extension RadioButtonViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkEmptyForm(textField: textField)
        return true
    }
    
}
