//
//  PDFReaderManage.swift
//  PDFReaderManage
//
//  Created by jamalping on 2018/10/8.
//

import Foundation


/// 跳转到PDF阅读器的方式
///
/// - push: push
/// - present: present
public enum OpenType{
    case push(UINavigationController)
    case present(UIViewController)
}


/// PDF文件数据源类型
///
/// - local: 本地
/// - netWork: 网络
public enum SourceType {
    case local(url: String)
    case netWork(url: String)
}

/// PDF阅读器管理工具类，支持盖章的pdf展示
public class PDFReaderManage {
    
    public static let shareInstance = PDFReaderManage()
    private init() {}
    
    
    /// 打开pdf,支持本地地址以及下载地址
    ///
    /// - Parameter path: 本地地址或者下载地址
    public func openURL(_ source: SourceType, openType: OpenType) {
        
        let pdfVC = PDFReaderViewController.init(source: source)
        
        switch openType {
        case .push(let navigationController):
            navigationController.pushViewController(pdfVC, animated: true)
        case .present(let viewController):
            let nvg = UINavigationController.init(rootViewController: pdfVC)
            viewController.present(nvg, animated: true, completion: nil)
        }
        
    }
}
