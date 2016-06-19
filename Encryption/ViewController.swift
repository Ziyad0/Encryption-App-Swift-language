//
//  ViewController.swift
//  Encryption
//
//  Created by Zyiad Alotaibi on 5/18/16.
//  Copyright © 2016 Ziyad. All rights reserved.
//

import UIKit

enum EncryptionError: ErrorType {
    case Empty
    case Short
    case obvious(String)
}

class ViewController: UIViewController {

    @IBOutlet weak var str: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func button(sender: AnyObject) {
        do { // Do-Catch
            let encrypted = try encryptString(str.text!, withPassword: password.text!)
            label.text = encrypted
        } catch EncryptionError.Empty {
            label.text = "You must provide a password."
        } catch EncryptionError.Short {
            label.text = "Passwords must be at least five characters, preferably eight or more."
        } catch {
            label.text = "Something went wrong!"
        }
    }
    
    func encryptString(str: String, withPassword password: String) throws -> String { // why we use trhows?
        guard password.characters.count > 0 else { throw EncryptionError.Empty }
        guard password.characters.count >= 5 else { throw EncryptionError.Short }
        guard passwordNotObvious(password) else { throw EncryptionError.obvious("I've got the same passcode on my luggage!") }
        // complicated encryption goes here
        let encrypted = password + str + password
        return String(encrypted.characters.reverse())
    }
    func passwordNotObvious(password: String) -> Bool {
        let range = NSMakeRange(0, password.characters.count)
        let misspelledRange = UITextChecker().rangeOfMisspelledWordInString(password, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }


}
