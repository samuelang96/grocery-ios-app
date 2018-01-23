//
//  ViewController2.swift
//  heb-ios-app
//
//  Created by David Garretson on 9/22/17.
//  Copyright © 2017 TU. All rights reserved.
//

import UIKit
import Alamofire

class ViewController2: UIViewController, SimplePingDelegate {
    
    var pinger: SimplePing?
    var sendTimer: Timer?
    var hostName = "131.194.34.80"
    @IBOutlet weak var pingButton: UIButton!
    
    @IBOutlet weak var textView0: UITextView!
    @IBOutlet weak var textView1: UITextView!
    var pingText = "";
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start() {
        textView0.text = pingText;
        pingButton.setTitle("STOP PINGING", for:.normal)
        NSLog("start")
        let pinger = SimplePing(hostName: self.hostName)
        self.pinger = pinger
        pinger.addressStyle = .icmPv4
        pinger.delegate = self
        pinger.start()
    }
    
    func stop() {
        pingButton.setTitle("PING SERVER", for:.normal)
        
        NSLog("stop")
        self.pinger?.stop()
        self.pinger = nil
        self.sendTimer?.invalidate()
        self.sendTimer = nil
    }
    
    @IBAction func showMessage() {
        print("Ping Called");
        if self.pinger == nil {
            self.start()
        } else {
            self.stop()
        }
        print("End of Ping Funciton reached");
    }
    
    @IBAction func showProduct(_ sender: Any) {
        testRequest()
    }
    
    func testRequest(){
        //Alamofire.request("http://heb.cs.trinity.edu/api/products", method: .get).responseJSON { response in
        Alamofire.request("http://headers.jsontest.com/", method: .get).responseJSON{response in
            print(response)
            let rData = response.description
            self.textView1.text = rData
        }
        //let request = Alamofire.request("http://httpbin.org/get", method: .get)
        debugPrint(request)
    }
    
    
    func simplePing(_ pinger: SimplePing, didStartWithAddress address: Data) {
        NSLog("pinging %@", ViewController2.displayAddressForAddress(address))
        
        // Send the first ping straight away.
        self.sendPing()
        
        // And start a timer to send the subsequent pings.
        assert(self.sendTimer == nil)
        self.sendTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ViewController2.sendPing), userInfo: nil, repeats: true)
    }
    
    func simplePing(_ pinger: SimplePing, didFailWithError error: Error) {
        NSLog("failed: %@", ViewController2.shortErrorFromError(error as NSError))
        pingText.append("failed: \(ViewController2.shortErrorFromError(error as NSError))\n")
        textView0.text = pingText
        self.stop()
    }
    
    func simplePing(_ pinger: SimplePing, didSendPacket packet: Data, sequenceNumber: UInt16) {
        NSLog("#%u sent", sequenceNumber)
        pingText.append("#\(sequenceNumber) sent\n")
        textView0.text = pingText
    }
    
    func simplePing(_ pinger: SimplePing, didFailToSendPacket packet: Data, sequenceNumber: UInt16, error: Error) {
        NSLog("#%u send failed: %@", sequenceNumber, ViewController2.shortErrorFromError(error as NSError))
        pingText.append("#\(sequenceNumber) send failed: \(ViewController2.shortErrorFromError(error as NSError))\n")
        textView0.text = pingText
    }
    
    func simplePing(_ pinger: SimplePing, didReceivePingResponsePacket packet: Data, sequenceNumber: UInt16) {
        NSLog("#%u received, size=%zu", sequenceNumber, packet.count)
        pingText.append("#\(sequenceNumber) received, size=\(packet.count)\n")
        textView0.text = pingText
    }
    
    func simplePing(_ pinger: SimplePing, didReceiveUnexpectedPacket packet: Data) {
        NSLog("unexpected packet, size=%zu", packet.count)
        pingText.append("unexpected packet, size=\(packet.count)\n")
        textView0.text = pingText
    }
    
    
    
    // MARK: utilities
    
    @objc func sendPing() {
        self.pinger!.send(with: nil)
    }
    
    /// Returns the string representation of the supplied address.
    ///
    /// - parameter address: Contains a `(struct sockaddr)` with the address to render.
    ///
    /// - returns: A string representation of that address.
    
    static func displayAddressForAddress(_ address: Data) -> String {
        var hostStr = [Int8](repeating: 0, count: Int(NI_MAXHOST))
        
        let success = getnameinfo(
            (address as NSData).bytes.bindMemory(to: sockaddr.self, capacity: address.count),
            socklen_t(address.count),
            &hostStr,
            socklen_t(hostStr.count),
            nil,
            0,
            NI_NUMERICHOST
            ) == 0
        let result: String
        if success {
            result = String(cString: hostStr)
        } else {
            result = "?"
        }
        return result
    }
    
    /// Returns a short error string for the supplied error.
    ///
    /// - parameter error: The error to render.
    ///
    /// - returns: A short string representing that error.
    
    static func shortErrorFromError(_ error: NSError) -> String {
//        if error.domain == kCFErrorDomainCFNetwork as String && error.code == Int(CFNetworkErrors.cfHostErrorUnknown.rawValue) {
//            if let failureObj = error.userInfo[kCFGetAddrInfoFailureKey as AnyHashable] {
//                if let failureNum = failureObj as? NSNumber {
//                    if failureNum.int32Value != 0 {
//                        let f = gai_strerror(failureNum.int32Value)
//                        if f != nil {
//                            return String(cString: f!)
//                        }
//                    }
//                }
//            }
//        }
//        if let result = error.localizedFailureReason {
//            return result
//        }
//        return error.localizedDescription
//    }
        return "woops"
    }
}
