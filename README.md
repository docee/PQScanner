# PQScanner

PQScanner is an awesome QR code and Barcode scanner base on iOS7 SDK.

PQScanner是一个基于iOS原生SDK开发的二维码、条形码扫描组件。

[![CI Status](http://img.shields.io/travis/docee/PQScanner.svg?style=flat)](https://travis-ci.org/docee/PQScanner)
[![Version](https://img.shields.io/cocoapods/v/PQScanner.svg?style=flat)](http://cocoapods.org/pods/PQScanner)
[![License](https://img.shields.io/cocoapods/l/PQScanner.svg?style=flat)](http://cocoapods.org/pods/PQScanner)
[![Platform](https://img.shields.io/cocoapods/p/PQScanner.svg?style=flat)](http://cocoapods.org/pods/PQScanner)

## Usage 用法

####Step One步骤一: 

PQScanner only provides a constructor method.

PQScanner 仅提供一个构造方法。

You need to set up capture display view and delegate at first.

通过该构造方法，你需要设置摄像头渲染视图和委托。

```Objective
- (instancetype)initWithTargetView:(UIView *)targetView
withDelegate:(id)delegate;

```

####Step Two步骤二: 

Setup AVCapture.

初始化摄像头

At this time, Application will apply for camera control.

执行该方法时，系统会提示用户授权访问摄像头。

If users refuse , that will trigger

如果用于拒绝了，将触发以下回调：

`-(void)scanner:(PQScanner *)scanner
didOpenCaptureFaild:(NSError *)error` 

callback.

You need to set up capture display view and delegate at first.

你需要先初始化摄像头以后才能执行其他方法，否则会报错。

```Objective
-(void)setupAVCapture;
```

####Step Three步骤三: 

Start scan

开始扫描

PQScaner provides block and delegate method to callback data.

PQScanner提供block和delegate方式回调数据。

So the 

`-(void)scanner:(PQScanner *)scanner
didEncodeQRCode:(NSString *)encodeStr codeType:(NSString *)codeType`

callback and block will receive callback at the same time.

所以以上delegate回调方法和block将同时受到数据，另外需要注意的是，block回调返回数据采用后台线程返回，而delegate采用UI线程返回。

```Objective
-(void)startScan:(ResultBlock)block;
```

####Step Fourb步骤四: 

Continue scan

继续扫描

Once PQScanner decoded the code , PQScanner will stop scan. 
At this time, You need to invoking continueScan method.

一旦扫描到二维码/条形码,程序将自动停止扫描。只有当你调用continueScan方法时，程序才会继续扫描返回结果。

```Objective
-(void)continueScan;
```

## Supports 支持

iOS 7.0 above

支持>=iOS 7.0

## Installation 安装

PQScanner is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PQScanner', '~> 0.1.3'
```

## Author 作者

Docee, docee@163.com

## License 协议

PQScanner is available under the MIT license. See the LICENSE file for more info.



