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


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MKShufflingView *shufflingView  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [self.view addSubview:shufflingView];
    shufflingView.backgroundColor = [UIColor redColor];
    shufflingView.textArray =@[@"http://f.hiphotos.baidu.com/zhidao/pic/item/810a19d8bc3eb1357689ea10a71ea8d3fc1f44ca.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=fcae01763b87e9504217f3642039531b/2f2eb9389b504fc29fccbeb0e4dde71191ef6df7.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/4ec2d5628535e5dd5c955af875c6a7efce1b6258.jpg",@"http://c.hiphotos.baidu.com/zhidao/pic/item/95eef01f3a292df59ac3846ebc315c6034a8734c.jpg",@"http://img.hb.aicdn.com/c6c4f5ebe51328518bdcad6dfe3ee6530ff75e1d132be-FPDHXd_fw580"];
    shufflingView.MYshufflingViewShowstyle = shufflingViewShowstyleImageView;
    shufflingView.isUrlImage = YES;
    shufflingView.selected = 3;
    shufflingView.isAutomatic = YES;
    shufflingView.isShowMyPage = YES;
    MKpageStyle *myStytle = [[MKpageStyle alloc]init];
    myStytle.myPageStyle = MKpageStyleLocationBottom;
    myStytle.pageHeight = 30;
    myStytle.myDotStyle = MKDotStyleLocationCenter;
    myStytle.backGroundColor = [UIColor colorWithWhite:0 alpha:.3f];
    myStytle.styleTextColor = [UIColor blackColor];
    myStytle.currentTextColor = [UIColor whiteColor];
    myStytle.currentColor = [UIColor clearColor];
    myStytle.styleColor = [UIColor clearColor];
    myStytle.backGroundColor = [UIColor clearColor];
    myStytle.myDotFillStyle = MKDotStyleText;
    myStytle.roundedCorners = 0;
    myStytle.currentRoundedCorners = 0;
    myStytle.currentSize = CGSizeMake(15, 15);
    myStytle.styleSize =CGSizeMake(15, 15);
    myStytle.titleArray = @[@"第一个",@"第二个",@"第三个",@"第四个",@"第五个"];
    shufflingView.mypageStyle = myStytle;
    shufflingView.MYslidingDirection = slidingDirectionV;
    shufflingView.MYslidingPositiveOrNegative = slidingPositive;
    [shufflingView initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
    
    
    
    
    
    MKShufflingView *shufflingView1  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, 100)];
    [self.view addSubview:shufflingView1];
    shufflingView1.backgroundColor = [UIColor redColor];
    shufflingView1.textArray =@[@"http://f.hiphotos.baidu.com/zhidao/pic/item/810a19d8bc3eb1357689ea10a71ea8d3fc1f44ca.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=fcae01763b87e9504217f3642039531b/2f2eb9389b504fc29fccbeb0e4dde71191ef6df7.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/4ec2d5628535e5dd5c955af875c6a7efce1b6258.jpg",@"http://c.hiphotos.baidu.com/zhidao/pic/item/95eef01f3a292df59ac3846ebc315c6034a8734c.jpg",@"http://img.hb.aicdn.com/c6c4f5ebe51328518bdcad6dfe3ee6530ff75e1d132be-FPDHXd_fw580"];
    shufflingView1.MYshufflingViewShowstyle = shufflingViewShowstyleImageView;
    shufflingView1.isUrlImage = YES;
    shufflingView1.selected = 2;
    shufflingView1.countdown = 3;
    shufflingView1.isAutomatic = YES;
    shufflingView1.isShowMyPage = YES;
    MKpageStyle *myStytle1 = [[MKpageStyle alloc]init];
    myStytle1.myPageStyle = MKpageStyleLocationBottom;
    myStytle1.pageHeight = 30;
    myStytle1.myDotStyle = MKDotStyleLocationCenter;
    myStytle1.backGroundColor = [UIColor colorWithWhite:0 alpha:.3f];
    myStytle1.styleTextColor = [UIColor blackColor];
    myStytle1.currentTextColor = [UIColor whiteColor];
    myStytle1.styleColor = [UIColor clearColor];
    myStytle1.backGroundColor = [UIColor clearColor];
    myStytle1.myDotFillStyle = MKDotStyleText;
    myStytle1.roundedCorners = 7.5;
    myStytle1.currentRoundedCorners = 10;
    myStytle1.currentSize = CGSizeMake(20, 20);
    myStytle1.styleSize =CGSizeMake(15, 15);
    shufflingView1.mypageStyle = myStytle1;
    shufflingView1.MYslidingDirection = slidingDirectionH;
    shufflingView1.MYslidingPositiveOrNegative = slidingNegative;
    [shufflingView1 initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
    
    
    MKShufflingView *shufflingView2  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 220, self.view.bounds.size.width, 100)];
    [self.view addSubview:shufflingView2];
    shufflingView2.backgroundColor = [UIColor redColor];
    shufflingView2.textArray =@[@"http://f.hiphotos.baidu.com/zhidao/pic/item/810a19d8bc3eb1357689ea10a71ea8d3fc1f44ca.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=fcae01763b87e9504217f3642039531b/2f2eb9389b504fc29fccbeb0e4dde71191ef6df7.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/4ec2d5628535e5dd5c955af875c6a7efce1b6258.jpg",@"http://c.hiphotos.baidu.com/zhidao/pic/item/95eef01f3a292df59ac3846ebc315c6034a8734c.jpg",@"http://img.hb.aicdn.com/c6c4f5ebe51328518bdcad6dfe3ee6530ff75e1d132be-FPDHXd_fw580"];
    shufflingView2.MYshufflingViewShowstyle = shufflingViewShowstyleImageView;
    shufflingView2.isUrlImage = YES;
    shufflingView2.selected = 2;
    shufflingView2.isAutomatic = YES;
    shufflingView2.isShowMyPage = YES;
    shufflingView2.titleArray = @[@"我是中国人",@"中国人就是牛逼",@"你好我的宝贝",@"你是我的亲",@"我是你的某某某"];
    MKpageStyle *myStytle2 = [[MKpageStyle alloc]init];
    myStytle2.myPageStyle = MKpageStyleLocationBottom;
    myStytle2.pageHeight = 30;
    shufflingView2.countdown = 2;
    myStytle2.myDotStyle = MKDotStyleLocationRight;
    myStytle2.backGroundColor = [UIColor colorWithWhite:0 alpha:.3f];
    myStytle2.styleTextColor = [UIColor whiteColor];
    myStytle2.currentTextColor = [UIColor grayColor];
    myStytle2.currentColor = [UIColor grayColor];
    myStytle2.myDotFillStyle = MKDotStyleText;
    shufflingView2.mypageStyle = myStytle2;
    shufflingView2.MYslidingDirection = slidingDirectionH;
    shufflingView2.MYslidingPositiveOrNegative = slidingPositive;
    [shufflingView2 initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
    
    MKShufflingView *shufflingView3  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 330, self.view.bounds.size.width, 100)];
    [self.view addSubview:shufflingView3];
    shufflingView3.backgroundColor = [UIColor redColor];
    shufflingView3.textArray =@[@"http://f.hiphotos.baidu.com/zhidao/pic/item/810a19d8bc3eb1357689ea10a71ea8d3fc1f44ca.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=fcae01763b87e9504217f3642039531b/2f2eb9389b504fc29fccbeb0e4dde71191ef6df7.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/4ec2d5628535e5dd5c955af875c6a7efce1b6258.jpg",@"http://c.hiphotos.baidu.com/zhidao/pic/item/95eef01f3a292df59ac3846ebc315c6034a8734c.jpg",@"http://img.hb.aicdn.com/c6c4f5ebe51328518bdcad6dfe3ee6530ff75e1d132be-FPDHXd_fw580"];
    shufflingView3.MYshufflingViewShowstyle = shufflingViewShowstyleImageView;
    shufflingView3.isUrlImage = YES;
    shufflingView3.selected = 2;
    shufflingView3.isAutomatic = YES;
    shufflingView3.isShowMyPage = YES;
    shufflingView3.countdown = 1;
    MKpageStyle *myStytle3 = [[MKpageStyle alloc]init];
    myStytle3.myPageStyle = MKpageStyleLocationLeft;
    myStytle3.pageHeight = 30;
    myStytle3.myDotStyle = MKDotStyleLocationCenter;
    myStytle3.backGroundColor = [UIColor clearColor];
    myStytle3.styleTextColor = [UIColor whiteColor];
    myStytle3.currentTextColor = [UIColor grayColor];
    myStytle3.currentColor = [UIColor grayColor];
    myStytle3.myDotFillStyle = MKDotStyleText;
    shufflingView3.mypageStyle = myStytle3;
    shufflingView3.MYslidingDirection = slidingDirectionV;
    shufflingView3.MYslidingPositiveOrNegative = slidingNegative;
    [shufflingView3 initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
    
    
    MKShufflingView *shufflingView7  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 440, self.view.bounds.size.width, 100)];
    [self.view addSubview:shufflingView7];
    shufflingView7.backgroundColor = [UIColor redColor];
    shufflingView7.textArray =@[@"http://f.hiphotos.baidu.com/zhidao/pic/item/810a19d8bc3eb1357689ea10a71ea8d3fc1f44ca.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=fcae01763b87e9504217f3642039531b/2f2eb9389b504fc29fccbeb0e4dde71191ef6df7.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/4ec2d5628535e5dd5c955af875c6a7efce1b6258.jpg",@"http://c.hiphotos.baidu.com/zhidao/pic/item/95eef01f3a292df59ac3846ebc315c6034a8734c.jpg",@"http://img.hb.aicdn.com/c6c4f5ebe51328518bdcad6dfe3ee6530ff75e1d132be-FPDHXd_fw580"];
    shufflingView7.MYshufflingViewShowstyle = shufflingViewShowstyleImageView;
    shufflingView7.isUrlImage = YES;
    shufflingView7.selected = 2;
    shufflingView7.isAutomatic = YES;
    shufflingView7.isShowMyPage = YES;
    shufflingView7.countdown = 1;
    MKpageStyle *myStytle7 = [[MKpageStyle alloc]init];
    myStytle7.myPageStyle = MKpageStyleLocationUp;
    myStytle7.pageHeight = 30;
    myStytle7.roundedCorners = 0;
    myStytle7.currentRoundedCorners = 0;
    myStytle7.myDotStyle = MKDotStyleLocationCenter;
    myStytle7.backGroundColor = [UIColor clearColor];
    myStytle7.styleTextColor = [UIColor clearColor];
    myStytle7.styleColor = [UIColor clearColor];
    myStytle7.currentTextColor = [UIColor clearColor];
    myStytle7.currentColor = [UIColor clearColor];
    myStytle7.myDotFillStyle = MKDotStyleImage;
    myStytle7.currentImage = [UIImage imageNamed:@"favorites-filling-2"];
    myStytle7.styleImage = [UIImage imageNamed:@"favorites-filling"];
    shufflingView7.mypageStyle = myStytle7;
    shufflingView7.MYslidingDirection = slidingDirectionV;
    shufflingView7.MYslidingPositiveOrNegative = slidingNegative;
    [shufflingView7 initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
    
    MKShufflingView *shufflingView4  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 550, self.view.bounds.size.width, 30)];
    shufflingView4.backgroundColor = [UIColor redColor];
    shufflingView4.textArray =@[@"热卖",@"赚了一千万",@"赔了两千万",@"死鬼",@"照样跑"];
    shufflingView4.MYshufflingViewShowstyle = shufflingViewShowstyleText;
    shufflingView4.MYslidingDirection = slidingDirectionV;
    shufflingView4.countdown = 2;
    shufflingView4.selected = 2;
    shufflingView4.isAutomatic = YES;
    shufflingView4.MYslidingPositiveOrNegative = slidingNegative;
    [shufflingView4 initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
    [self.view addSubview:shufflingView4];
    
    
    
    
    MKShufflingView *shufflingView5  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 590, self.view.bounds.size.width, 30)];
    shufflingView5.backgroundColor = [UIColor grayColor];
    shufflingView5.textArray =@[@"热卖",@"赚了一千万",@"赔了两千万",@"死鬼",@"照样跑"];
    shufflingView5.MYshufflingViewShowstyle = shufflingViewShowstyleText;
    shufflingView5.MYslidingDirection = slidingDirectionV;
    shufflingView5.countdown = 1;
    shufflingView5.selected = 3;
    shufflingView5.isAutomatic = YES;
    shufflingView5.MYslidingPositiveOrNegative = slidingPositive;
    [shufflingView5 initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
    [self.view addSubview:shufflingView5];
    
    
    
    MKShufflingView *shufflingView6  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 630, self.view.bounds.size.width, 30)];
    shufflingView6.backgroundColor = [UIColor redColor];
    shufflingView6.textArray =@[@"热卖",@"赚了一千万",@"赔了两千万",@"死鬼",@"照样跑"];
    shufflingView6.MYshufflingViewShowstyle = shufflingViewShowstyleText;
    shufflingView6.MYslidingDirection = slidingDirectionH;
    shufflingView6.countdown = 3;
    shufflingView6.selected = 4;
    shufflingView6.isAutomatic = YES;
    shufflingView6.MYslidingPositiveOrNegative = slidingNegative;
    [shufflingView6 initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];
    [self.view addSubview:shufflingView6];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
