# PQScanner

PQScanner is an awesome QR code and Barcode scanner base on iOS7 SDK.

[![CI Status](http://img.shields.io/travis/docee/PQScanner.svg?style=flat)](https://travis-ci.org/docee/PQScanner)
[![Version](https://img.shields.io/cocoapods/v/PQScanner.svg?style=flat)](http://cocoapods.org/pods/PQScanner)
[![License](https://img.shields.io/cocoapods/l/PQScanner.svg?style=flat)](http://cocoapods.org/pods/PQScanner)
[![Platform](https://img.shields.io/cocoapods/p/PQScanner.svg?style=flat)](http://cocoapods.org/pods/PQScanner)

## Usage

####Step One: 

PQScanner only provides a constructor method.

You need to set up capture display view and delegate at first.

```Objective
- (instancetype)initWithTargetView:(UIView *)targetView
withDelegate:(id)delegate;

```

####Step Two: 

Setup AVCapture.

At this time, Application will apply for camera control.

If users refuse , that will trigger

`-(void)scanner:(PQScanner *)scanner
didOpenCaptureFaild:(NSError *)error` 

callback.

You need to set up capture display view and delegate at first.

```Objective
-(void)setupAVCapture;
```

####Step Three: 

Start scan

PQScaner provides block and delegate method to callback data.

So the 

`-(void)scanner:(PQScanner *)scanner
didEncodeQRCode:(NSString *)encodeStr codeType:(NSString *)codeType` callback and block will receive callback at the same time.

```Objective
-(void)startScan:(ResultBlock)block;
```

####Step Four: 

Continue scan

Once PQScanner decoded the code , PQScanner will stop scan. 
At this time, You need to invoking continueScan method.

```Objective
-(void)continueScan;
```

## Requirements

iOS 7.0 above

## Installation

PQScanner is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PQScanner', '~> 0.1.0'
```

## Author

Docee, docee@163.com

## License

PQScanner is available under the MIT license. See the LICENSE file for more info.


