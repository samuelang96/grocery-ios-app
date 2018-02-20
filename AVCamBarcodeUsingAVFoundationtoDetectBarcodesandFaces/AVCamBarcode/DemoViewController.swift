//
//  DemoViewController.swift
//  AVCamBarcode
//
//  Created by Samuel Ang on 2/19/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
class DemoViewController: UIViewController {

    @IBOutlet weak var demoTextView: UITextView!
    @IBOutlet weak var barcodeTextField: UITextField!
    @IBAction func getSampleProduct(_ sender: Any) {
        //testRequest();
        //0044600046907
        //0070847012474
        testBarcodeRequest(barcode: self.barcodeTextField.text!);
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testRequest(){
        //Alamofire.request("http://heb.cs.trinity.edu/api/products", method: .get).responseJSON { response in
        Alamofire.request("http://headers.jsontest.com/", method: .get).responseJSON{response in
            print(response)
            let rData = response.description
            self.demoTextView.text = rData
        }
        //let request = Alamofire.request("http://httpbin.org/get", method: .get)
        debugPrint(request)
    }
    
    func testBarcodeRequest(barcode: String){
            //Alamofire.request("http://heb.cs.trinity.edu/api/products", method: .get).responseJSON { response in
            Alamofire.request("http://heb.cs.trinity.edu/api/products/" + barcode, method: .get).responseJSON{response in
                print(response)
                let rData = response.description
                self.demoTextView.text = rData
            }
            //let request = Alamofire.request("http://httpbin.org/get", method: .get)
            debugPrint(request)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
