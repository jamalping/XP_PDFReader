//
//  ViewController.swift
//  PDFReader
//
//  Created by jamalping on 10/08/2018.
//  Copyright (c) 2018 jamalping. All rights reserved.
//

import UIKit
import XP_PDFReader

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func loadRemotePDF(_ sender: UIButton) {
        print("加载网络PDF")
        let url = "http://www.gov.cn/zhengce/pdfFile/2018_PDF.pdf"
        PDFReaderManage.shareInstance.openURL(.netWork(url: url), openType: .present(self))
    }
    
    @IBAction func loadLocalPDF(_ sender: UIButton) {
        print("加载本地PDF")
        guard let localAdress = Bundle.main.path(forResource: "s3PreviewPDFdoid311538", ofType: "pdf") else {
            return
        }
        PDFReaderManage.shareInstance.openURL(.local(url: localAdress), openType: .present(self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

