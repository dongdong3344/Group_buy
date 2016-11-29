//
//  LDSheetViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/22.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDSheetViewController.h"
#import "LDMineViewController.h"

@interface LDSheetViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;
@end

@implementation LDSheetViewController
- (IBAction)cancleAction:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)exitAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ISLOGIN"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //创建通知
    NSNotification *notification=[NSNotification notificationWithName:@"reloadData" object:nil ];
 
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

    


    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"123";
    self.view.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];

}



@end
