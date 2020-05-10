//
//  ViewController.swift
//  FoodTracker
//
//  Created by Vegesna, Vijay V EX1 on 5/3/20.
//  Copyright © 2020 Vegesna, Vijay V EX1. All rights reserved.
//

import UIKit
import os.log

class FoodItemViewController: UIViewController {
    
    
    @IBOutlet weak var mealItemTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingsControl: RatingsControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //MARK: Model
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealItemTextField.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            mealItemTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingsControl.rating = meal.rating
        }
        
        updateSaveButtonState()
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = mealItemTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingsControl.rating
        
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Actions
    
    @IBAction func cacelDidPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    @IBAction func selectedImageFromPhotos(_ sender: UITapGestureRecognizer) {
        
        mealItemTextField.resignFirstResponder()
        
        let imagePickerControl = UIImagePickerController()
        imagePickerControl.sourceType = .photoLibrary
        imagePickerControl.delegate = self
        present(imagePickerControl, animated: true, completion: nil)
    }
    
    //MARK: Private methods
    
    private func updateSaveButtonState() {
        let text = mealItemTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

extension FoodItemViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension FoodItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage  else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
