//
//  AddrepairvehicleViewController.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class AddrepairvehicleViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var vehicleTitle: UITextField!
    @IBOutlet weak var vehicleType: UITextField!
    @IBOutlet weak var repairType: UITextField!
    @IBOutlet weak var repairDetails: UITextField!
    @IBOutlet weak var selectWorker: DropDown!
    @IBOutlet weak var repairDate: UITextField!
    @IBOutlet weak var ownerName: UITextField!
    @IBOutlet weak var amountRepair: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applyGradientToButton(button: saveButton)
        setupGestureRecognizers()
        setupDatePicker(for: repairDate)
        loadWorkerNames()
    }


    func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func setupDatePicker(for textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        // Assign the date picker as the input view for the text field
        textField.inputView = datePicker

        // Create a toolbar with a "Done" button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true

        // Set the toolbar as the accessory view for the text field
        textField.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        // Find the active text field
        if let datePicker = repairDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            repairDate.text = dateFormatter.string(from: datePicker.date)
        }

        // Dismiss the date picker
        view.endEditing(true)
    }


    func loadWorkerNames() {
        var workerNames: [String] = []

        if let savedWorkers = UserDefaults.standard.object(forKey: "EmployeeDetails") as? [Data] {
            let decoder = JSONDecoder()
            for workerData in savedWorkers {
                do {
                    let worker = try decoder.decode(Employee.self, from: workerData)
                    workerNames.append(worker.name)
                } catch {
                    print("Error decoding worker data: \(error.localizedDescription)")
                }
            }
        }

        selectWorker.optionArray = workerNames
        selectWorker.didSelect { (selectedText, index, id) in
            self.selectWorker.text = selectedText
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        saveRepairData()
    }

    func saveRepairData() {
        guard let title = vehicleTitle.text, !title.isEmpty,
              let type = vehicleType.text, !type.isEmpty,
              let repairType = repairType.text, !repairType.isEmpty,
              let repairDetails = repairDetails.text, !repairDetails.isEmpty,
              let selectedWorker = selectWorker.text, !selectedWorker.isEmpty,
              let repairDateText = repairDate.text, !repairDateText.isEmpty,
              let ownerName = ownerName.text, !ownerName.isEmpty,
              let amountText = amountRepair.text, let amount = Double(amountText),
              let notes = notes.text else {
            displayAlert(title: "Error", message: "Please fill in all fields.")
            return
        }

        let newRepair = RepairVehicle(
            id: UUID().uuidString,
            vehicleTitle: title,
            vehicleType: type,
            repairType: repairType,
            repairDetails: repairDetails,
            selectedWorker: selectedWorker,
            repairDate: repairDateText,
            ownerName: ownerName,
            amountRepair: amount,
            notes: notes
        )

        saveRepairDetails(newRepair)
    }

    func saveRepairDetails(_ repair: RepairVehicle) {
        var repairs = UserDefaults.standard.object(forKey: "RepairDetails") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(repair)
            repairs.append(data)
            UserDefaults.standard.set(repairs, forKey: "RepairDetails")
            clearTextFields()
            displayAlert(title: "Success", message: "Repair details saved successfully!")
        } catch {
            print("Error encoding repair details: \(error.localizedDescription)")
        }
    }

    func clearTextFields() {
        vehicleTitle.text = ""
        vehicleType.text = ""
        repairType.text = ""
        repairDetails.text = ""
        selectWorker.text = ""
        repairDate.text = ""
        ownerName.text = ""
        amountRepair.text = ""
        notes.text = ""
    }

    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    @IBAction func btnback(_ sender: Any) {
        self.dismiss(animated: true)
    }
}



