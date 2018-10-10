//
//  PDFReaderViewController.swift
//  PDFReader
//
//  Created by jamalping on 2018/10/8.
//

import UIKit

// MARK: PDF阅读器控制器

class PDFReaderViewController: UIViewController {
    
    
    let documentPath: String = {
        
        guard var document =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last else {
            return ""
        }
        return document
    }()
    
    // 缓存地址
    lazy var cachePath: String = {
        return self.documentPath + "/" + self.avaliableCachePath(self.url ?? "") + ".pdf"
    }()
    
    var webView: UIWebView = {
        let web = UIWebView()
        web.backgroundColor = .white
        return web
    }()
    
    /// PDF地址，本地路径或者下载URL
    var url: String?
    
    var loadIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
    
    let backItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(backAction))
    
    public init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "PDF阅读器"
        
        // 返回按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back", in: Bundle.init(for: self.classForCoder), compatibleWith: nil), style: .done, target: self, action: #selector(backAction))
        
        // 页面加载
        configPage()
        if let url = self.url {
            loadFile(urlString: url)
        }
    }
    
    /// 加载PDF,支持本地地址和下载地址
    func loadFile(urlString: String) {
        if FileManager.default.fileExists(atPath: self.cachePath) {
            self.loadUrlPath(path: self.cachePath)
            return
        }
        self.downLoadFile(urlString: self.url!)

    }
    
    /// 下载PDF文件，只支持下载地址
    func downLoadFile(urlString: String) {
        NetWorkManage.shareInstance.downLoad(urlString: urlString) { (url, response, error) in
            guard error == nil else {
                return
            }
            /// 下载下来的文件在temp文件夹下，需要拷贝到缓存目录下。
            let tempPath = url!.path
            
            let resulrPath = self.cachePath

            try? FileManager.default.copyItem(atPath: tempPath, toPath: resulrPath)
            
            self.loadUrlPath(path: self.cachePath)
        }
    }
    
    /// 加载PDF文件,只支持本地地址
    public func loadUrlPath(path:String) {
        
        let urlStr = Bundle.init(for: self.classForCoder).path(forResource: "viewer", ofType: "html", inDirectory: "generic/web")?.appendingFormat("?file=%@", path).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        
        if let url = URL(string: urlStr) {
            let request = URLRequest.init(url: url)
            
            DispatchQueue.main.async {
                self.webView.loadRequest(request)
                self.loadIndicatorView.isHidden = true
            }
        }
    }
    
    /// 删除/以及//
    func avaliableCachePath(_ cachePath: String) -> String {
        return cachePath.replacingOccurrences(of: "//", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: ".", with: "")
    }
    
    
    func configPage() {
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        
        loadIndicatorView.center = self.view.center
        self.view.addSubview(loadIndicatorView)
    }
    
    @objc func backAction() {
        if ((self.navigationController?.presentingViewController) != nil) && (self.navigationController?.viewControllers.count)! <= 1 {
            self.dismiss(animated: true, completion: nil)
        }else {
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
