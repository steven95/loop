//
//  Circle.m
//  转盘
//
//  Created by Jusive on 15/11/29.
//  Copyright © 2015年 Jusive. All rights reserved.
//

#import "Circle.h"
#import "Button.h"
#define Angle2Rotation(angle)  (((angle) / 180.0) * M_PI)
@interface Circle ()
@property (weak, nonatomic) IBOutlet UIImageView *LuckyRotateWhell;
- (IBAction)staChoose;

@property (nonatomic,weak) UIButton *currentSelectedBtn;
@property (nonatomic,weak) CADisplayLink *link;
@end

@implementation Circle
+(instancetype)circle{
    return [[[NSBundle mainBundle]loadNibNamed:@"Circlexib" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib{

    UIImage *norImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    for (int i = 0; i < 12; i++) {
        Button *btn = [[Button alloc]init];
        btn.tag = 1;
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        btn.frame = CGRectMake(0, 0, 68, 143);
        btn.bounds = CGRectMake(0, 0, 68, 143);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(self.frame.size.width *  0.5, self.frame.size.height * 0.5);
        [self.LuckyRotateWhell addSubview:btn];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.transform = CGAffineTransformMakeRotation(Angle2Rotation(i * 30));
        CGFloat imageW = (norImage.size.width /12) *[UIScreen mainScreen].scale;
        CGFloat imageH = norImage.size.height * [UIScreen mainScreen].scale;
        CGFloat imageY = 0;
        CGFloat imageX = i *imageW;
        CGRect smallRect = CGRectMake(imageX, imageY, imageW, imageH);
        CGImageRef cgImage1 = CGImageCreateWithImageInRect(norImage.CGImage, smallRect);
        CGImageRef cgImage2 = CGImageCreateWithImageInRect(selImage.CGImage, smallRect);
        
        [btn setImage:[UIImage imageWithCGImage:cgImage1] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithCGImage:cgImage2] forState:UIControlStateSelected];
        if (i == 0) {
            [self buttonClick:btn];
        }
    }
}
-(void)buttonClick:(UIButton *)btn{
    self.currentSelectedBtn.selected = NO;
    btn.selected = YES;
    self.currentSelectedBtn = btn;
}

-(void)starRotating{
    if (self.link) return;
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    self.link = link;
}
-(void)update{
    self.LuckyRotateWhell.transform = CGAffineTransformRotate(self.LuckyRotateWhell.transform, M_PI / 500);
}
-(void)stopRotating{
    [self.link invalidate];
    self.link = nil;
}
- (IBAction)staChoose {
    //新增2： 计算当前选中的按钮和狮子座的偏移的角度
    CGFloat angle = M_PI * 2 / 12.0;
    angle = self.currentSelectedBtn.tag * angle;
    //
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(2 * M_PI * 10 );
    //    anim.toValue = @(2*M_PI * 10);
    anim.duration = 3;
    
    
    // 开头和结尾慢,中间快
    //    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    [self.LuckyRotateWhell.layer addAnimation:anim forKey:nil];
    
    [self stopRotating];
    self.userInteractionEnabled = NO;
}
// 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 新增3：改变实际的角度
    CGFloat angle = M_PI * 2 / 12.0;
    angle = self.currentSelectedBtn.tag * angle;
    angle = 2 * M_PI * 10 - angle;
    
    self.LuckyRotateWhell.transform = CGAffineTransformMakeRotation(angle);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self starRotating];
        self.userInteractionEnabled = YES;
        
    });
    
}

@end
