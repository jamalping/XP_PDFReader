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
    
    /// PDF数据源
    var source: SourceType?
    
    /// PDF地址，本地路径或者下载URL
    var url: String? {
        get {
            guard let sc = source else { return nil }
            switch sc {
            case .local(url: let urlString):
                return urlString
            case .netWork(url: let urlString):
                return urlString
            }
        }
    }

    
    /// 加载中动画
    var loadIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let backItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(backAction))
    
    public init(source: SourceType) {
        self.source = source

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

        guard let sc = self.source else { return }
        loadFile(source: sc)
    }
    
    /// 加载PDF,支持本地地址和下载地址
    func loadFile(source: SourceType) {
        switch source {
        case .local(url: let urlString):
            loadLoacalPDF(url: urlString)
        case .netWork(url: let urlString):
            if FileManager.default.fileExists(atPath: self.cachePath) {
                self.loadUrlPath(path: self.cachePath)
                return
            }
            self.downLoadFile(urlString: urlString)
        }
    }
    
    /// 加载本地PDF文件
    ///
    /// - Parameter url: 本地路径
    func loadLoacalPDF(url: String) {
        self.loadUrlPath(path: url)
    }
    
    /// 下载PDF文件，只支持下载地址
    func downLoadFile(urlString: String) {
        loadIndicatorView.startAnimating()
        NetWorkManage.shareInstance.downLoad(urlString: urlString) { (url, response, error) in
            guard error == nil else {
                return
            }
            /// 下载下来的文件在temp文件夹下，需要拷贝到缓存目录下。
            let tempPath = url!.path
            
            let resulrPath = self.cachePath

            try? FileManager.default.copyItem(atPath: tempPath, toPath: resulrPath)
            
            self.loadIndicatorView.startAnimating()
            
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
    
    /// 返回上个页面
    @objc func backAction() {
        if ((self.navigationController?.presentingViewController) != nil) && (self.navigationController?.viewControllers.count)! <= 1 {
            self.dismiss(animated: true, completion: nil)
        }else {
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
