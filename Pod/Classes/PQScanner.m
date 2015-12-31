//
//  PQScanner.m
//  PQScanner
//
//  Created by 黄盼青 on 15/12/31.
//  Copyright © 2015年 temobi. All rights reserved.
//

#import "PQScanner.h"
#import <AVFoundation/AVFoundation.h>


@interface PQScanner () <AVCaptureMetadataOutputObjectsDelegate>

@property (weak,nonatomic) UIView *targetView;
@property (strong,nonatomic) AVCaptureSession *session;

@property (copy,nonatomic) ResultBlock block;

@end

@implementation PQScanner


#pragma mark - LifeCycle

/**
 *  @brief 初始化PQScanner
 *
 *  @param targetView 摄像头渲染视图
 *  @param delegate   委托
 *
 *  @return PQScanner
 */
- (instancetype)initWithTargetView:(UIView *)targetView
                      withDelegate:(id)delegate {
    
    self = [super init];
    if (self) {
        
        _targetView = targetView;
        _delegate = delegate;
        
        
    }
    return self;
}


/**
 *  @brief 初始化AVCapture
 */
-(void)setupAVCapture {
    
    NSError *captureError = nil;
    
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&captureError];
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    
    //打开摄像头失败
    if(captureError) {
        
        if([_delegate respondsToSelector:@selector(scanner:didOpenCaptureFaild:)]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [_delegate scanner:self didOpenCaptureFaild:captureError];
                
            });
            
        }
        
        return;
        
    }
    
    
    //设置代理，后台线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    //初始化Session
    self.session = [[AVCaptureSession alloc]init];
    [self.session addInput:input];
    [self.session addOutput:output];
    
    //设置支持的编码格式（条形码和二维码）
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = _targetView.layer.bounds;
    
    [_targetView.layer insertSublayer:layer atIndex:0];
    
}

#pragma mark - Public

/**
 *  @brief 开始扫描
 *
 *  @discuz 扫描结果可通过block返回，也可通过delegate返回
 *
 *  @param block 扫描结果
 */
-(void)startScan:(ResultBlock)block {
    
    self.block = block;
    
    self.isStop = NO;
    
    if(self.session && ![self.session isRunning]) {
        
        [self.session startRunning];
        
    }else {
        
        NSLog(@"[PQScanner]: startScan Failed!");
        
    }
    
}

/**
 *  @brief 继续扫描
 *
 *  @discuz 当获取到扫描结果以后，程序会自动停止扫描，需要继续扫描请调用continueScan
 */
-(void)continueScan {
    
    
    if(self.session && [self.session isRunning]){
        
        
        self.isStop = NO;
        
    }else {
        
        NSLog(@"[PQScanner]: continueScan Failed!");
        
    }
    
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection {
    
    if(metadataObjects.count > 0) {
        
        //获取解析字符
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        NSString *encodeStr = metadataObject.stringValue;
        
        //获取条码类型
        NSString *metaDesc = metadataObject.description;
        NSRange range = [metaDesc rangeOfString:@"(?<=type=\").*(?=\",)" options:NSRegularExpressionSearch];
        NSString *codeType = [metaDesc substringWithRange:range];
        
        
        if(!_isStop) {
            
            
            self.isStop = YES;
            
            //Block使用后台线程
            self.block?self.block(encodeStr,codeType):nil;
            
            if([_delegate respondsToSelector:@selector(scanner:didEncodeQRCode:codeType:)]) {
                
                //使用主线程回调
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_delegate scanner:self
                       didEncodeQRCode:encodeStr
                              codeType:codeType];
                    
                });
                
                
            }
            
        }
        
    }
    
    
}



@end


