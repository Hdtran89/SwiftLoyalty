//
//  Card.swift
//  SwiftPrototype
//
//  Created by Hieu Tran on 2/6/15.
//  Copyright (c) 2015 Hieu Tran. All rights reserved.
//

import Foundation
import UIKit

class Card : UIViewController {
    var barcodeString:String!
    var barcodeImage:UIImage!
    
    var QRCode:String!
    var EAN13Code:String!
    var EAN8Code:String!
    var Code128Code:String!
    var Code39Code:String!
    var AztecCode:String!
    var Code39Mod43Code:String!
    var Code93Code:String!
    var PDF417Code:String!
    var UPCECode:String!
    
    @IBOutlet weak var bImage: UIImageView!
    @IBOutlet weak var bString: UILabel!
    override func viewDidLoad(){
        super.viewDidLoad()
        SelectBarcode()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    func SelectBarcode()
    {
        if QRCode != nil {
           // barcodeString = QRCode
            barcodeImage = CreateBarcodeImage(QRCode)
        }else if EAN13Code != nil {
            barcodeString = EAN13Code
            barcodeImage = CreateBarcodeImage(EAN13Code)
        }else if EAN8Code != nil {
            barcodeString = EAN8Code
            barcodeImage = CreateBarcodeImage(EAN8Code)
        }else if Code128Code != nil {
            barcodeString = Code128Code
            barcodeImage = CreateBarcodeImage(Code128Code)
        }else if Code39Code != nil {
            barcodeString = Code39Code
            barcodeImage = CreateBarcodeImage(Code39Code)
        }else if AztecCode != nil {
            barcodeString = AztecCode
            barcodeImage = CreateBarcodeImage(AztecCode)
        }else if Code39Mod43Code != nil {
            barcodeString = Code39Mod43Code
            barcodeImage = CreateBarcodeImage(Code39Mod43Code)
        }else if Code93Code != nil {
            barcodeString = Code93Code
            barcodeImage = CreateBarcodeImage(Code93Code)
        }else if PDF417Code != nil {
            barcodeString = PDF417Code
            barcodeImage = CreateBarcodeImage(PDF417Code)
        }else if UPCECode != nil {
            barcodeString = UPCECode
            barcodeImage = CreateBarcodeImage(UPCECode)
        }else{
            println("Can not Select Barcode")
        }
    }
    func CreateBarcodeImage(bstring:String) ->UIImage {
        if QRCode != nil {
            
        }else if EAN13Code != nil {
     

        }else if EAN8Code != nil {
            barcodeString = EAN8Code
            barcodeImage = CreateBarcodeImage(EAN8Code)
        }else if Code128Code != nil {
            barcodeString = Code128Code
            barcodeImage = CreateBarcodeImage(Code128Code)
        }else if Code39Code != nil {
            barcodeString = Code39Code
            barcodeImage = CreateBarcodeImage(Code39Code)
        }else if AztecCode != nil {
            barcodeString = AztecCode
            barcodeImage = CreateBarcodeImage(AztecCode)
        }else if Code39Mod43Code != nil {
            barcodeString = Code39Mod43Code
            barcodeImage = CreateBarcodeImage(Code39Mod43Code)
        }else if Code93Code != nil {
            barcodeString = Code93Code
            barcodeImage = CreateBarcodeImage(Code93Code)
        }else if PDF417Code != nil {
            barcodeString = PDF417Code
            barcodeImage = CreateBarcodeImage(PDF417Code)
        }else if UPCECode != nil {
            barcodeString = UPCECode
            barcodeImage = CreateBarcodeImage(UPCECode)
        }else{
            println("Can not Select Barcode")
        }
        return barcodeImage
    }
}