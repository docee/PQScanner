//
//  PQViewController.m
//  PQScanner
//
//  Created by 黄盼青 on 12/31/2015.
//  Copyright (c) 2015 黄盼青. All rights reserved.
//

#import "PQViewController.h"
#import "PQScanner.h"

@interface PQViewController () <PQScannerDelegate,UIAlertViewDelegate>

{
    @private
    
    PQScanner *_scanner;
}

@end

@implementation PQViewController


#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    _scanner = [[PQScanner alloc]initWithTargetView:self.view withDelegate:self];
    
    [_scanner setupAVCapture];
    
    [_scanner startScan:^(NSString *encodeStr, NSString *codeType) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSString *msg = [NSString stringWithFormat:@"encodedString: %@ \n codeType: %@",encodeStr,codeType];
            
            UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"PQScanner"
                                                              message:msg
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil, nil];
            
            [alerView show];
            
            
        });
        
        
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PQScannerDelegate

-(void)scanner:(PQScanner *)scanner
didEncodeQRCode:(NSString *)encodeStr
      codeType:(NSString *)codeType {
    
    
    
}


-(void)scanner:(PQScanner *)scanner
didOpenCaptureFaild:(NSError *)error {
    
    NSLog(@"capture open failed!");
    
}

#pragma mark - UIAlerViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0) {
        
        [_scanner continueScan];
        
    }
    
}


@end
