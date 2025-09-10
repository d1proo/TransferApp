//
//  ViewController.swift
//  TransferApp
//
//  Created by Дмитрий Прохоренко on 30.08.2025.
//

import UIKit

class SecondViewController: UIViewController {
	
	@IBOutlet var dataTextField: UITextField!
	var updatingData: String = ""
	var completionHandler: ((String) -> Void)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateTextFieldData()
	}
	
	private func updateTextFieldData() {
		dataTextField.text = updatingData
	}
	
	@IBAction func saveDataWithProperty(_ sender: UIButton){
		self.navigationController?.viewControllers.forEach {vc in
			(vc as? ViewController)?.updatedData = dataTextField.text ?? ""
		}
	}
	
	//Обновление данных с помощью Unwind segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case "toFirstScreen":
			guard let editScreen = segue.destination as? ViewController else { return }
			editScreen.updatedData = dataTextField.text ?? ""
		default:
			break
		}
	}
	
	@IBAction func saveDataWithClosure(_ sender: UIButton) {
		// получаем обновленные данные
		let updatedData = dataTextField.text ?? ""
		// вызваем замыкание
		completionHandler?(updatedData)
		// возвращаемся на предыдущий экран
		navigationController?.popViewController(animated: true)
	}
}
