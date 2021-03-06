//
//  AttendeeFormSetViewController.swift
//  Everest_iOS
//
//  Created by Sebastian Kolosa on 2016-11-02.
//  Copyright © 2016 Everest. All rights reserved.
//

import UIKit

class AttendeeFormSetViewController: UIViewController, UITextFieldDelegate, ImagePickerAlertProtocol {
  private let headerAndStackViewContainer = HeaderAndStackViewContainer(withNavigationBar: true)
  private let addFieldButton = UIButton()
  private let removeFieldButton = UIButton()
  private let fieldButtonsContainer = UIView()
  private let totalButtonContainer = UIView()
  private let continueButton = AppStyle.sharedInstance.baseInputButton()
  
  var event: Event?
  
  //SKO - treat as a stack
  private var placeholderTextArray = [NSLocalizedString("instruments placeholder", comment: "instruments placeholder"), NSLocalizedString("work experience placeholder", comment: "work experience placeholder"), NSLocalizedString("hobbies placeholder", comment: "hobbies placeholder"),NSLocalizedString("favourite foods placeholder", comment: "favourite foods placeholder"), NSLocalizedString("skills placeholder", comment: "skills placeholder")]
  private var inputTextFieldsArray: [BaseInputTextField] = []
  
  private var headerImageView: UIImageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    
    let appStyle = AppStyle.sharedInstance
    
    let eventTitleLabel = UILabel()
    let formSetDescriptionLabel = UILabel()
    
    let defaultInputTextFieldOne = BaseInputTextField(hintText: placeholderTextArray.popLast())
    let defaultInputTextFieldTwo = BaseInputTextField(hintText: placeholderTextArray.popLast())
    
    defaultInputTextFieldOne.delegate = self
    
    defaultInputTextFieldTwo.delegate = self
    defaultInputTextFieldTwo.tag = 1
    
    inputTextFieldsArray.append(defaultInputTextFieldOne)
    inputTextFieldsArray.append(defaultInputTextFieldTwo)
    
    eventTitleLabel.textAlignment = .center
    eventTitleLabel.numberOfLines = 0
    eventTitleLabel.lineBreakMode = .byWordWrapping
    eventTitleLabel.font = appStyle.headerFontMedium
    eventTitleLabel.text = NSLocalizedString("guest questionnaire", comment: "guest questionnaire placeholder")
    
    formSetDescriptionLabel.textAlignment = .center
    formSetDescriptionLabel.numberOfLines = 0
    formSetDescriptionLabel.lineBreakMode = .byWordWrapping
    formSetDescriptionLabel.font = appStyle.headerFontMedium
    formSetDescriptionLabel.text = NSLocalizedString("attendee characteristics description", comment: "attendee characteristics description label")
    
    addFieldButton.setTitle(NSLocalizedString("add another field", comment: "add characteristic text field button"), for: .normal)
    addFieldButton.addTarget(self, action: #selector(didTapAddFieldButton), for: .touchUpInside)
    addFieldButton.titleLabel?.font = appStyle.textFontMedium
    addFieldButton.setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .normal)
    addFieldButton.setTitleColor(UIColor.black.withAlphaComponent(0.1), for: .disabled)
    addFieldButton.titleLabel?.textAlignment = .left
    
    removeFieldButton.setTitle(NSLocalizedString("remove a field", comment: "remove characteristic text field button"), for: .normal)
    removeFieldButton.addTarget(self, action: #selector(didTapRemoveFieldButton), for: .touchUpInside)
    removeFieldButton.titleLabel?.font = appStyle.textFontMedium
    removeFieldButton.setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .normal)
    removeFieldButton.titleLabel?.textAlignment = .right
    removeFieldButton.isHidden = true
    
    fieldButtonsContainer.addSubview(addFieldButton)
    fieldButtonsContainer.addSubview(removeFieldButton)
    
    continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    continueButton.setTitle(NSLocalizedString("continue", comment: "continue button"), for: .normal)
    
    totalButtonContainer.addSubview(fieldButtonsContainer)
    totalButtonContainer.addSubview(continueButton)
    
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: eventTitleLabel)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: formSetDescriptionLabel)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: defaultInputTextFieldOne)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: defaultInputTextFieldTwo)
    headerAndStackViewContainer.addArrangedSubviewToStackView(view: totalButtonContainer)
    
    headerAndStackViewContainer.setHeaderView(view: headerImageView)
    
    let headerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
    headerAndStackViewContainer.headerView.addGestureRecognizer(headerTapGestureRecognizer)
    
    self.view.addSubview(headerAndStackViewContainer)
    
    self.view.backgroundColor = appStyle.backgroundColor
    
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let headerImage = event?.getHeaderImage() {
      if headerImageView.image != headerImage {
        headerImageView.image = headerImage
      }
    } else {
      headerImageView.image = AppStyle.sharedInstance.pictureImageWide
    }
    
    if let attendeeCharacteristics = event?.getAttendeeCharacteristics() {
      for attendeeCharacteristic in attendeeCharacteristics {
        let index = attendeeCharacteristics.index(of: attendeeCharacteristic)
        inputTextFieldsArray[index!].text = attendeeCharacteristic
      }
    }
  }
  
  private func setupConstraints() {
    headerAndStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
    totalButtonContainer.translatesAutoresizingMaskIntoConstraints = false
    fieldButtonsContainer.translatesAutoresizingMaskIntoConstraints = false
    addFieldButton.translatesAutoresizingMaskIntoConstraints = false
    removeFieldButton.translatesAutoresizingMaskIntoConstraints = false
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    
    headerAndStackViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    headerAndStackViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    headerAndStackViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    headerAndStackViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    
    totalButtonContainer.heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.baseInputTextFieldHeight * 2.5).isActive = true
    
    fieldButtonsContainer.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -5).isActive = true
    fieldButtonsContainer.leadingAnchor.constraint(equalTo: totalButtonContainer.leadingAnchor).isActive = true
    fieldButtonsContainer.trailingAnchor.constraint(equalTo: totalButtonContainer.trailingAnchor).isActive = true
    fieldButtonsContainer.heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.baseInputTextFieldHeight).isActive = true
    
    addFieldButton.topAnchor.constraint(equalTo: fieldButtonsContainer.topAnchor).isActive = true
    addFieldButton.bottomAnchor.constraint(equalTo: fieldButtonsContainer.bottomAnchor).isActive = true
    addFieldButton.leadingAnchor.constraint(equalTo: fieldButtonsContainer.leadingAnchor).isActive = true
    addFieldButton.trailingAnchor.constraint(equalTo: removeFieldButton.leadingAnchor).isActive = true
    addFieldButton.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width - 2*AppStyle.sharedInstance.baseInputViewSideMargin)/2).isActive = true
    
    removeFieldButton.topAnchor.constraint(equalTo: fieldButtonsContainer.topAnchor).isActive = true
    removeFieldButton.bottomAnchor.constraint(equalTo: fieldButtonsContainer.bottomAnchor).isActive = true
    removeFieldButton.leadingAnchor.constraint(equalTo: addFieldButton.trailingAnchor).isActive = true
    removeFieldButton.trailingAnchor.constraint(equalTo: fieldButtonsContainer.trailingAnchor).isActive = true
    
    addFieldButton.titleLabel?.leadingAnchor.constraint(equalTo: addFieldButton.leadingAnchor, constant: 10).isActive = true
    removeFieldButton.titleLabel?.trailingAnchor.constraint(equalTo: removeFieldButton.trailingAnchor, constant: -10).isActive = true
    
    continueButton.bottomAnchor.constraint(equalTo: totalButtonContainer.bottomAnchor).isActive = true
    continueButton.leadingAnchor.constraint(equalTo: totalButtonContainer.leadingAnchor).isActive = true
    continueButton.trailingAnchor.constraint(equalTo: totalButtonContainer.trailingAnchor).isActive = true
    continueButton.heightAnchor.constraint(equalToConstant: AppStyle.sharedInstance.baseInputTextFieldHeight).isActive = true
  }
  
  func didTapAddFieldButton(sender: UIButton) {
    if let nextInputPlaceholder = placeholderTextArray.popLast() {
      let nextInputTextField = BaseInputTextField(hintText: nextInputPlaceholder)
      headerAndStackViewContainer.baseInputView.addArrangedSubviewToStackView(view: nextInputTextField, aboveView: totalButtonContainer)
      inputTextFieldsArray.append(nextInputTextField)
      //SKO - adjust height of scroll view's content view to accommodate for new textField
      headerAndStackViewContainer.scrollViewContentViewHeightConstaint.constant += AppStyle.sharedInstance.baseInputTextFieldHeight + 20
      
      nextInputTextField.tag = (inputTextFieldsArray.index(of: nextInputTextField)!)
      nextInputTextField.delegate = self
      //SKO - set content touch delay once view is scrollable
      if !headerAndStackViewContainer.scrollView.delaysContentTouches {
        headerAndStackViewContainer.scrollView.delaysContentTouches = true
      }
      self.view.setNeedsLayout()
      self.view.layoutIfNeeded()
      if placeholderTextArray.isEmpty {
        addFieldButton.isEnabled = false
      }
      if removeFieldButton.isHidden {
        removeFieldButton.isHidden = false
      }
    }
  }
  
  func didTapRemoveFieldButton(sender: UIButton) {
    if let lastInputTextField = inputTextFieldsArray.popLast() {
      if let lastPlaceholderText = lastInputTextField.placeholder {
        lastInputTextField.removeFromSuperview()
        placeholderTextArray.append(lastPlaceholderText)
        headerAndStackViewContainer.scrollViewContentViewHeightConstaint.constant -= AppStyle.sharedInstance.baseInputTextFieldHeight + 20
        if inputTextFieldsArray.count == 2 {
          removeFieldButton.isHidden = true
          //SKO - remove content touch delay when scroll view no longer scrollable
          headerAndStackViewContainer.scrollView.delaysContentTouches = false
        }
        if !addFieldButton.isEnabled {
          addFieldButton.isEnabled = true
        }
      }
    }
  }
  
  func didTapContinueButton(sender: UIButton) {
    self.view.endEditing(true)
    
    if let navigationController = (UIApplication.shared.delegate as! AppDelegate).navigationController {
      var attendeeCharacteristicsArray: [String] = []
      for textField in inputTextFieldsArray {
        if textField.hasText {
          attendeeCharacteristicsArray.append(textField.text!)
        }
      }
      event?.setAttendeeCharacteristics(attendeeCharacteristics: attendeeCharacteristicsArray)
      let adminDescriptionFormViewController = AdminDescriptionFormViewController()
      adminDescriptionFormViewController.event = event
      navigationController.pushViewController(adminDescriptionFormViewController, animated: true)
    }
  }
  
  func didTapHeader(sender: UITapGestureRecognizer) {
    let imagePicker = ImagePickerAlertController(frame: view.bounds, controller: self)
    imagePicker.delegate = self
    imagePicker.displayAlert()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let nextTextField = headerAndStackViewContainer.baseInputView.stackView.viewWithTag(textField.tag + 1) {
      nextTextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return false
  }
  
  //MARK: ImagePickerAlertProtocol
  
  func didPickImage(image: UIImage) {
    headerImageView.image = image
    event?.setHeaderImage(image: image)
  }
}
