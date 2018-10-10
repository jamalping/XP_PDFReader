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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let url = "http://www.gov.cn/zhengce/pdfFile/2018_PDF.pdf"
        //        let url = "http://img03.tooopen.com/images/20160630/tooopen_sy_168334097794.jpg"
        //        let url = "/Users/jamalping/Desktop/s3PreviewPDFdoid311538.pdf"
        PDFReaderManage.shareInstance.openURL(url, openType: .present(self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

