//Copyright (c) 2015 Docee <docee@163.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ResultBlock)(NSString *encodeStr,NSString *codeType);


#pragma mark - PQScanner

@interface PQScanner : NSObject


@property (weak,nonatomic) id delegate;    //委托
@property (assign,nonatomic) BOOL isStop;  //是否结束扫描

/**
 *  @brief 初始化PQQRScanner
 *
 *  @param targetView 摄像头渲染视图
 *  @param delegate   委托
 *
 *  @return PQQRScanner
 */
- (instancetype)initWithTargetView:(UIView *)targetView
                      withDelegate:(id)delegate;


/**
 *  @brief 初始化AVCapture
 */
-(void)setupAVCapture;


/**
 *  @brief 开始扫描
 *
 *  @discuz 扫描结果可通过block返回，也可通过delegate返回
 *
 *  @param block 扫描结果
 */
-(void)startScan:(ResultBlock)block;

/**
 *  @brief 继续扫描
 *
 *  @discuz 当获取到扫描结果以后，程序会自动停止扫描，需要继续扫描请调用continueScan
 */
-(void)continueScan;


@end


#pragma mark - PQScannerDelegate

@protocol PQScannerDelegate <NSObject>

@optional


/**
 *  @brief 扫描解析结果
 *
 *  @param scanner   PQScanner
 *  @param encodeStr 解析结果
 *  @param codeType  条码类型
 */
-(void)scanner:(PQScanner *)scanner
didEncodeQRCode:(NSString *)encodeStr
      codeType:(NSString *)codeType;

/**
 *  @brief 摄像头开启失败
 *
 *  @discuz 如果打开摄像头失败，可以继续调用setupAVCaputre
 *
 *  @param scanner PQScanner
 *  @param error   NSError
 */
-(void)scanner:(PQScanner *)scanner
didOpenCaptureFaild:(NSError *)error;

@end
