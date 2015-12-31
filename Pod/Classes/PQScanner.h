//
//  PQScanner.h
//  PQScanner
//
//  Created by 黄盼青 on 15/12/31.
//  Copyright © 2015年 temobi. All rights reserved.
//

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
