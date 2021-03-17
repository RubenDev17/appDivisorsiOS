//
//  AppDelegate.swift
//  ejercicioFinalTema5
//
//  Created by user184221 on 2/14/21.
//

import UIKit

@main
//Para la notificacion importamos el UNUserNotificationCenterDelegate
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Le decimos que el delegado para las notificaciones es el appDelegate
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    //Implementamos un par de funciones que se van  a ejecutar en el momento en el que el notification center reciba una notificacion
    //Con DidReceived ha recibido la noticion
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //Solo nos interesa la funcion que trae completionHandler, con ello le indicamos que esa notificacion se ejecute
        completionHandler()
    }
    //Con willPresent va a mostrar o presentar esa notificacion
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //En este caso el completionHandler tiene unos parametros. Estos son justamente los mismos parametros que habiamos usado a la hora de especificar que permisos queriamos para las notificaciones y son aquellos que nos viene a decir que queremos que nos muestre la notificacion.
        completionHandler([.alert, .sound, .badge])
    }
}

