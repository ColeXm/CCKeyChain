//
//  ViewController.m
//  CCKeyChain
//
//  Created by ColeXm on 16/3/10.
//  Copyright © 2016年 ColeXm. All rights reserved.
//

#import "ViewController.h"
#import "CCKeyChain.h"


@implementation ViewController{


    __weak IBOutlet UITextField *valueText;
}

- (IBAction)didPressSave:(UIButton *)sender {
    
    
    //默认key为test，方便测试
    if ([CCKeyChain setObject:valueText.text forKey:@"test"]) {
        [self showAlert:@"保存成功"];
    }
}

- (IBAction)didPressBtn:(UIButton *)sender {
    
    [self showAlert:[CCKeyChain objectForKey:@"test"]];
}


-(void)showAlert:(NSString *)msg{

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil
                                                                message:msg
                                                         preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:action];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
