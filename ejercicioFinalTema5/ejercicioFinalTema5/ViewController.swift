//
//  ViewController.swift
//  ejercicioFinalTema5
//
//  Created by user184221 on 2/14/21.
//

import UIKit

class ViewController: UIViewController {
    
    //Creamos los outlets de los elementos del Mainstoryboard para poder trabajar con ellos
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var labelPercentage: UILabel!
    @IBOutlet weak var progressview: UIProgressView!
    @IBOutlet weak var labelDivisors: UILabel!
    
    //Creamos un array para guardar los divisores
    var divisors = Array<Int>()
    //Creamos la variable para el porcentaje
    var percentage: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Solicitamos los permisos de la notificacion
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("tenemos permiso para las notificaciones")
            }else{
                print("No nos han dado permisos")
                print(error.debugDescription)
            }
        }
    }


    @IBAction func buttonPreseed(_ sender: UIButton) {
        //Cuando le demos al botón si el array no esta vacío, lo borramos todo. Esto se hace para poder hacer varias consultas de un divisor y que no se guarden los divisiores de consultas anteriores
        if divisors.isEmpty == false{
            divisors.removeAll()
        }
        
        //Parseamos el numero int que si esta vacío escriba un 0
        let number = Int(textfield.text ?? "") ?? 0
        //Le indicamos que la barra de progreso este vacía
        self.progressview.setProgress(0, animated: false)
        //Hacemos una comprobacion en la que si el texto esta vacío nos aparezca un mensaje para que escribamos un numero
        if let number = textfield.text, number.isEmpty{
            self.labelDivisors.text = "Escriba un número sino es imposible darle un resultado"
        }else{
            //Creamos una funcion multihilo que sea asincrona
            DispatchQueue.global().async {
                //bucle para realizar el calculo de los divisores
                for i in 1 ... number{
                    DispatchQueue.main.async {
                        //Calculamos la barra de progreso. Esto se hace en primer plano para poder ver lo que tarda nuestra petición
                        self.progressview.setProgress(Float(i)/Float(number), animated: true)
                        //Calculamos el porcentaje
                        self.percentage = (Float(i)/Float(number))*100
                        //Parseamos el porcentaje de un float a un int para mostrarlo en pantalla
                        var intPercentage: Int = Int(self.percentage)
                        //Mostramos el porcentaje
                        self.labelPercentage.text = "\(intPercentage)%"
                    }
                    //Si el numero es divisor lo añadimos al array
                    if number %  i == 0{
                        self.divisors.append(i)
                    }
                }
            
                //Tareas en primer plano
                DispatchQueue.main.async {
                    //Convertimos el array de Int en un array de String
                    let stringArrayDivisors = self.divisors.map{String($0)}
                    //Convertimos el array de String en un String separado por comas
                    let allDivisors = stringArrayDivisors.joined(separator: ", ")
                    //Imprimimos en nuestro label los divisores
                    self.labelDivisors.text = "Los divisores del número \(number) son  \(allDivisors)"
                    //Ejecutamos la notificacion y le mostramos el resultado
                    self.showNotification(text: self.labelDivisors.text ?? "")
                }
            }
        }
    }

    
    //Creamos el metodo para la notificacion
    func showNotification(text: String) {
        //Le pasamos una cadena
        let content = UNMutableNotificationContent()
        //Le asignamos un titulo, subtitulo, body, sound y badge
        content.title = "Ya tenemos el resultado obtenido"
        content.subtitle = "Ha costado pero se ha conseguido"
        content.body = text
        content.sound = .default
        content.badge = 1
        //Creamos el trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        //Creamos la request y añadimos el content y el trigger
        let request = UNNotificationRequest(identifier: "Mi notificación", content: content, trigger: trigger)
        //Añadimos la notificación al centro de notificaciones
        UNUserNotificationCenter.current().add(request){(error) in
            print(error.debugDescription) //Si nos diese un error al añadirlo simplemente lo sacaaremos por consola
        }
    }
}
