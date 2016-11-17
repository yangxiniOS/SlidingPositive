//
//  ViewController.m
//  shufflingDemo
//
//  Created by 杨鑫 on 2016/11/17.
//  Copyright © 2016年 Mr Yang. All rights reserved.
//

#import "ViewController.h"
#import "MKShufflingView.h"

@interface ViewController ()
@property (nonatomic,strong)MKShufflingView *shufflingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.shufflingView  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    [self.view addSubview:self.shufflingView];
    self.shufflingView.backgroundColor = [UIColor redColor];
    self.shufflingView.textArray =@[@"1",@"2",@"3",@"4",@"5"];
    self.shufflingView.selected = 2;
    self.shufflingView.isAutomatic = YES;
    self.shufflingView.MYslidingDirection = slidingDirectionH;
    self.shufflingView.MYslidingPositiveOrNegative = slidingPositive;
    
    [self.shufflingView initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
