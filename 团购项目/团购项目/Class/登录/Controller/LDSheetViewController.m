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
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}

    


    

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
