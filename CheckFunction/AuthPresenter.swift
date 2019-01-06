//
//  AuthPresenter.swift
//  CheckFunction
//
//  Created by 米山諒 on 2019/01/06.
//  Copyright © 2019 yoneyama ryo. All rights reserved.
//

import Foundation
import Hydra

class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: AuthViewProtocol?
    
    var invalidator: InvalidationToken!
    
    var loginSettings = LoginSettingsState.NONE
    
    init(view: AuthViewProtocol) {
        self.view = view
    }
    
    func onViewInitialized() {
        print("process onViewInitialized")
        view?.initView()
    }
    
    func onLogin() {
    }
    
    func onLogout() {
    }
    
    func setLoginSettings(state: LoginSettingsState) {
        loginSettings = state
    }
    
    // ライフサイクルイベント
    func viewDidLoad() {
        invalidator = InvalidationToken()
    }
    func viewDidDisappear() {
        invalidator.invalidate()
    }
    
}
