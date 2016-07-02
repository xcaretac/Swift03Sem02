//
//  ViewController.swift
//  Swift03Semana01Error
//
//  Created by Xcaret A Ceniceros on 01/07/16.
//  Copyright © 2016 Xcaret Arellano Ceniceros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datosLibro: UITextView!
    @IBOutlet weak var ISBN: UITextField!

    func asincrono(){
        let valorISBN=ISBN.text
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+valorISBN!
        let url = NSURL(string: urls)
        let sesion = NSURLSession.sharedSession()
        let bloque = { (datos:NSData?, resp: NSURLResponse?, error: NSError?) -> Void in
            if resp==nil {
                print("El servidor no existe / No hay red")
            }else{
                let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                dispatch_async(dispatch_get_main_queue()){
                    self.datosLibro.text=String(texto)
                }
            }
        }

        let dt = sesion.dataTaskWithURL(url!, completionHandler: bloque)
        dt.resume()
    }
    
    

    @IBAction func consultarLibro(sender: AnyObject) {
        asincrono()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

