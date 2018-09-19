//
//  ViewController.swift
//  CallKitTutorial
//
//  Created by nakagawa yasuo on 2018/09/18.
//  Copyright © 2018年 nakagawa yasuo. All rights reserved.
//

import UIKit
import CallKit

class ViewController: UIViewController, CXProviderDelegate {
    @IBOutlet weak var phoneNumber: UITextField!

    let config = CXProviderConfiguration(localizedName: "My App")
    var provider: CXProvider?

    override func viewDidLoad() {
        if self.provider == nil {
            let provider = CXProvider.init(configuration: self.config)
            provider.setDelegate(self, queue: nil)
            self.provider = provider
        }
    }
    
    func providerDidReset(_ provider: CXProvider) {
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
    }
    
    @IBAction func SimulateReceiveCallButtonTapped(_ sender: UIButton) {
        guard let provider = self.provider else { return }
        guard let phoneNumberText = phoneNumber.text else { return }

        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .phoneNumber, value: phoneNumberText )
        provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
    }
}

