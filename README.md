# XP_PDFReader

[![CI Status](https://img.shields.io/travis/jamalping/XP_PDFReader.svg?style=flat)](https://travis-ci.org/jamalping/XP_PDFReader)
[![Version](https://img.shields.io/cocoapods/v/XP_PDFReader.svg?style=flat)](https://cocoapods.org/pods/XP_PDFReader)
[![License](https://img.shields.io/cocoapods/l/XP_PDFReader.svg?style=flat)](https://cocoapods.org/pods/XP_PDFReader)
[![Platform](https://img.shields.io/cocoapods/p/XP_PDFReader.svg?style=flat)](https://cocoapods.org/pods/XP_PDFReader)

## 示例
![示例.gif](https://upload-images.jianshu.io/upload_images/6165105-a634ae268b36b568.gif?imageMogr2/auto-orient/strip)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XP_PDFReader is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XP_PDFReader'
```

## use

```
/// 加载网络PDF
let url = "http://www.gov.cn/zhengce/pdfFile/2018_PDF.pdf"

PDFReaderManage.shareInstance.openURL(.netWork(url: url), openType: .present(self))
```

```
/// 加载本地PDF文件
guard let localAdress = Bundle.main.path(forResource: "s3PreviewPDFdoid311538", ofType: "pdf") else {
	return
}
PDFReaderManage.shareInstance.openURL(.local(url: localAdress), openType: .present(self))
```

## Author

jamalping, 420436097@qq.com

## blog
[https://www.jianshu.com/p/b05da7357261](https://www.jianshu.com/p/b05da7357261)

## License

XP_PDFReader is available under the MIT license. See the LICENSE file for more info.
