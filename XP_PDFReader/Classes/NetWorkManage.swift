//
//  NetWorkManage.swift
//  PDFReader
//
//  Created by jamalping on 2018/10/9.
//

import Foundation


/// 网络请求类
class NetWorkManage {
 
    static let shareInstance = NetWorkManage()
    private init() {}
    
    func downLoad(urlString: String, completionHandler: @escaping ((URL?, URLResponse?, Error?) -> Swift.Void)) {
        let session = URLSession.shared
        guard let url = URL.init(string: urlString) else {
            return
        }
        let request = URLRequest.init(url: url)
        
        let downLoadTask: URLSessionDownloadTask = session.downloadTask(with: request) { (url, response, error) in
            
            completionHandler(url, response, error)
        }
        /// 启动任务
        downLoadTask.resume()
    }
}
