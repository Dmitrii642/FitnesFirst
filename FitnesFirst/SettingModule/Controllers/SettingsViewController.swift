//
//  SettingsViewController.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 07.10.2023.
//

import UIKit
import PhotosUI

class SettingsViewController: UIViewController {
    
    private let editingProfileLabel = UILabel(text: "EDITING PROFILE",
                                              font: .robotoMedium24(),
                                              textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.image = UIImage(named: "addPhoto")
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var saveButton = GreenButton(text: "SAVE")
    
    private let settingsView = SettingsView()
    private var userModel = UserModel()
    
    override func viewDidLayoutSubviews() {
        addPhotoImageView.layer.cornerRadius = addPhotoImageView.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        addTaps()
        loadUserInfo()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(editingProfileLabel)
        view.addSubview(closeButton)
        view.addSubview(settingsView)
        view.addSubview(addPhotoView)
        view.addSubview(addPhotoImageView)
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
        
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        setUserModel()
        
        let userArray = RealmManager.shared.getResultUserModel()
        
        if userArray.isEmpty {
            RealmManager.shared.saveUserModel(userModel)
        } else {
            RealmManager.shared.updateUserModel(model: userModel)
        }
        userModel = UserModel()
    }
    
    private func addTaps() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
        addPhotoImageView.isUserInteractionEnabled = true
        addPhotoImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc func setUserPhoto() {
        alertPhotoOrCamera{ [weak self] source in
            guard let self else { return }
            
            if #available(iOS 14.0, *) {
                self.presentPHPicker()
            } else {
                self.choseImagePickeer(source: source)
            }
        }
    }
    
    private func setUserModel() {
        guard let firstName = settingsView.firstNameTextField.text,
              let secondName = settingsView.secondNameTextField.text,
              let height = settingsView.heightTextField.text,
              let weight = settingsView.weightTextField.text,
              let target = settingsView.targetTextField.text,
              let intWeight = Int(weight),
              let intHeight = Int(height),
            let intTagret = Int(target) else {
            return
        }
        
        userModel.userFirstName = firstName
        userModel.userSecondName = secondName
        userModel.userHeight = intHeight
        userModel.userWeight = intWeight
        userModel.userTarget = intTagret
        
        if addPhotoImageView.image == UIImage(named: "addPhoto") {
            userModel.userImage = nil
        } else {
            guard let image = addPhotoImageView.image else { return }
            let jpegData = image.jpegData(compressionQuality: 1.0)
            userModel.userImage = jpegData
        }
    }
    
    private func loadUserInfo() {
        let userArray = RealmManager.shared.getResultUserModel()
        
        if !userArray.isEmpty {
            settingsView.firstNameTextField.text = userArray[0].userFirstName
            settingsView.secondNameTextField.text = userArray[0].userSecondName
            settingsView.heightTextField.text = "\(userArray[0].userHeight)"
            settingsView.weightTextField.text = "\(userArray[0].userWeight)"
            
            guard let data = userArray[0].userImage,
                  let image = UIImage(data: data) else {
                return
            }
            addPhotoImageView.image = image
            addPhotoImageView.contentMode = .scaleAspectFill
        }
    }
}


//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func choseImagePickeer(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        addPhotoImageView.image = image
        addPhotoImageView.contentMode = .scaleAspectFit
        dismiss(animated: true)
    }
}


//MARK: - PHPickerViewControllerDelegate
@available(iOS 14.0, *)
extension SettingsViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.addPhotoImageView.image = image
                    self.addPhotoImageView.contentMode = .scaleAspectFill
                }
            }
        }
    }
    
    private func presentPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images])
        
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
}


//MARK: - Set Constraints
extension SettingsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            editingProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editingProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: editingProfileLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            
            addPhotoImageView.topAnchor.constraint(equalTo: editingProfileLabel.bottomAnchor, constant: 20),
            addPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            addPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            addPhotoView.topAnchor.constraint(equalTo: addPhotoImageView.topAnchor, constant: 50),
            addPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addPhotoView.heightAnchor.constraint(equalToConstant: 70),
            
            settingsView.topAnchor.constraint(equalTo: addPhotoView.bottomAnchor, constant: 20),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            saveButton.topAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
            
        ])
    }
}
