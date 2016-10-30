//
//  LandingViewController.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-10-29.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

  var baseCameraView: BaseCameraSesssion
  var overlayView: UIView
  var scanButtonContainer, createEvenButtonContainer, loginButtonContainer, signupButtonContainer: BaseInputButtonContainer
  var headerTextView, subHeaderTextView: BaseInputTextView
  
  init(_ coder: NSCoder? = nil) {
    
    overlayView = UIView()
    scanButtonContainer = BaseInputButtonContainer(buttonTitle: "Scan")
    createEvenButtonContainer = BaseInputButtonContainer(buttonTitle: "Create Event")
    loginButtonContainer = BaseInputButtonContainer(buttonTitle: "Login")
    signupButtonContainer = BaseInputButtonContainer(buttonTitle: "Sign up")
    headerTextView = BaseInputTextView(textInput: "Hi! Sign up to get started.")
    subHeaderTextView = BaseInputTextView(textInput: "Or scan now and join later!")
    baseCameraView = BaseCameraSesssion()
    
    if let coder = coder {
      super.init(coder: coder)!
    } else {
      super.init()
    }
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    self.init(aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    overlayView.addSubview(headerTextView)
    overlayView.addSubview(subHeaderTextView)
    overlayView.addSubview(scanButtonContainer)
    overlayView.addSubview(createEvenButtonContainer)
    overlayView.addSubview(loginButtonContainer)
    overlayView.addSubview(signupButtonContainer)
    view.addSubview(baseCameraView)
    view.addSubview(overlayView)
    baseCameraView.startCameraSession(controller: self)
    
    setupConstraints()
  }
  
  //SKU - Setup constraints for all containers and views
  func setupConstraints(){
    setupBaseCameraViewConstraints()
    setupOverlayViewConstraints()
    setupScanButtonContainerConstraints()
    setupCreateEventButtonContainerConstraints()
    setupHeaderTextViewConstraints()
    setupSubHeaderTextViewConstraints()
    setupFooterConstraints()
  }
  
  func setupBaseCameraViewConstraints(){
    baseCameraView.translatesAutoresizingMaskIntoConstraints = false
    
    baseCameraView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    baseCameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    baseCameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    baseCameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  func setupOverlayViewConstraints(){
    overlayView.isUserInteractionEnabled = true
    
    overlayView.translatesAutoresizingMaskIntoConstraints = false
    overlayView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  func setupScanButtonContainerConstraints(){
    scanButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    
    scanButtonContainer.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 40).isActive = true
    scanButtonContainer.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -40).isActive = true
    scanButtonContainer.bottomAnchor.constraint(equalTo: createEvenButtonContainer.topAnchor).isActive = true
  }
  
  func setupCreateEventButtonContainerConstraints(){
    createEvenButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    
    createEvenButtonContainer.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 40).isActive = true
    createEvenButtonContainer.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -40).isActive = true
    createEvenButtonContainer.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -80).isActive = true
    createEvenButtonContainer.button.setBackgroundImage(AppUtil.resizableImageWithColor(color: AppStyle.sharedInstance.baseInputSecondaryButtonColor), for: .normal)
  }

  func setupHeaderTextViewConstraints(){
    headerTextView.translatesAutoresizingMaskIntoConstraints = false
    
    headerTextView.isEditable = false
    headerTextView.isUserInteractionEnabled = false
    headerTextView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 50).isActive = true
    headerTextView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 10).isActive = true
    headerTextView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -10).isActive = true
    headerTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    headerTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
    headerTextView.textColor = AppStyle.sharedInstance.textFieldBackgroundColor
    headerTextView.backgroundColor = nil
    headerTextView.textAlignment = .center
  }
  
  func setupSubHeaderTextViewConstraints(){
    subHeaderTextView.translatesAutoresizingMaskIntoConstraints = false
    
    subHeaderTextView.isEditable = false
    subHeaderTextView.isUserInteractionEnabled = false
    subHeaderTextView.topAnchor.constraint(equalTo: headerTextView.bottomAnchor).isActive = true
    subHeaderTextView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 10).isActive = true
    subHeaderTextView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -10).isActive = true
    subHeaderTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    subHeaderTextView.font = UIFont(name: "HelveticaNeue", size: 20)
    subHeaderTextView.textColor = AppStyle.sharedInstance.textFieldBackgroundColor
    subHeaderTextView.backgroundColor = nil
    subHeaderTextView.textAlignment = .center
    subHeaderTextView.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
  }
  
  func setupFooterConstraints(){
    loginButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    signupButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    
    loginButtonContainer.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor,constant: 10).isActive = true
    loginButtonContainer.widthAnchor.constraint(equalTo: loginButtonContainer.button.widthAnchor).isActive = true
    loginButtonContainer.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -5).isActive = true
    loginButtonContainer.button.setBackgroundImage(nil, for: .normal)
    
    signupButtonContainer.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -10).isActive = true
    signupButtonContainer.widthAnchor.constraint(equalTo: signupButtonContainer.button.widthAnchor).isActive = true
    signupButtonContainer.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -5).isActive = true
    signupButtonContainer.button.setBackgroundImage(nil, for: .normal)
  }
}
