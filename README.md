# SlidingPositive
一个强大的轮播实现。



![image](https://github.com/yangxiniOS/SlidingPositive/blob/master/shufflingDemo/演示.gif)



支持图片轮播，文字轮播，正反序，水平竖直方向只需要赋值调用即可，即可实现无限轮播

应广大使用者需求现添加如下功能

新增网络图片
高度自定义PageControl  支持数字显示，图片显示，可以设置在轮播的任何位置，可以设置任何图片，点击切换等等，随君设置
如何调用

     self.shufflingView  = [[MKShufflingView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 250)];
    [self.view addSubview:self.shufflingView];
    self.shufflingView.backgroundColor = [UIColor redColor];
    self.shufflingView.textArray =@[@"http://f.hiphotos.baidu.com/zhidao/pic/item/810a19d8bc3eb1357689ea10a71ea8d3fc1f44ca.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=fcae01763b87e9504217f3642039531b/2f2eb9389b504fc29fccbeb0e4dde71191ef6df7.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/4ec2d5628535e5dd5c955af875c6a7efce1b6258.jpg",@"http://c.hiphotos.baidu.com/zhidao/pic/item/95eef01f3a292df59ac3846ebc315c6034a8734c.jpg",@"http://img.hb.aicdn.com/c6c4f5ebe51328518bdcad6dfe3ee6530ff75e1d132be-FPDHXd_fw580"];
    self.shufflingView.MYshufflingViewShowstyle = shufflingViewShowstyleImageView;
    self.shufflingView.isUrlImage = YES;
    self.shufflingView.selected = 3;
    self.shufflingView.isAutomatic = YES;
    self.shufflingView.isShowMyPage = YES;
    MKpageStyle *myStytle = [[MKpageStyle alloc]init];
    myStytle.myPageStyle = MKpageStyleLocationBottom;
    myStytle.pageHeight = 30;
    myStytle.myDotStyle = MKDotStyleLocationCenter;
    myStytle.backGroundColor = [UIColor clearColor];
    myStytle.styleTextColor = [UIColor whiteColor];
    myStytle.currentTextColor = [UIColor greenColor];
    myStytle.myDotFillStyle = MKDotStyleText;
    self.shufflingView.mypageStyle = myStytle;
    self.shufflingView.MYslidingDirection = slidingDirectionH;
    self.shufflingView.MYslidingPositiveOrNegative = slidingPositive;
    [self.shufflingView initShufflingView:^(NSInteger selected) {
        NSLog(@"%ld",selected);
    }];

技术交流解惑QQ群426981364
