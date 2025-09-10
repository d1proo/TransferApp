//
//  ViewController.swift
//  TransferApp
//
//  Created by Дмитрий Прохоренко on 30.08.2025.
//

import UIKit

class ViewController: UIViewController {
	
	var updatedData: String = "Test data"
	
	@IBOutlet var dataLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateLabel(withText: updatedData)
	}
	// Обновляем данные в текстовой метке
	private func updateLabel(withText text: String) {
		dataLabel.text = updatedData
	}
	
	@IBAction func editDataWithProperty(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
		
		editScreen.updatingData = dataLabel.text ?? ""
		self.navigationController?.pushViewController(editScreen, animated: true)
	}
	
	//Обновление данных с помощью segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case "toEditScreen":
			guard let editScreen = segue.destination as? SecondViewController else { return }
			editScreen.updatingData = dataLabel.text ?? ""
		default:
			break
		}
	}
	
	//Unwind segue
	@IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
	
	// переход от А к Б
	// передача данных с помощью свойства и инициализация замыкания
	@IBAction func editDataWithСlosure(_ sender: UIButton) {
		// получаем вью контроллер
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
		// передаем данные
		editScreen.updatingData = dataLabel.text ?? ""
		// передаем необходимое замыкание
		editScreen.completionHandler = { [unowned self] updatedValue in
			updatedData = updatedValue
			updateLabel(withText: updatedValue)
		}
		// открываем следующий экран
		self.navigationController?.pushViewController(editScreen, animated: true)
	}
}
