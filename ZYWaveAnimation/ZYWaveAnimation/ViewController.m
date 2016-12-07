//
//  ViewController.m
//  ZYWaveAnimation
//
//  Created by 毛汉卿 on 2016/12/7.
//  Copyright © 2016年 毛汉卿. All rights reserved.
//
#import "ViewController.h"
#import "ZYWaveAnimationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     extern NSString *const ZYWaveSpeedKey;//波浪流动速度
     extern NSString *const ZYWaveAmplitudeKey;//A当前波浪振幅
     extern NSString *const ZYWaveφKey;//初相位
     extern NSString *const ZYWaveωKey;//决定周期
     extern NSString *const ZYWavehKey;
     extern NSString *const ZYWaveAlphaKey;
     extern NSString *const ZYWaveFillColorKey;
     extern NSString *const ZYWaveStrokeColorKey;
     extern NSString *const ZYWavelineWidthKey;
     
     */
    
    
    
    
    
    ZYWaveAnimationView *waveView= [[ZYWaveAnimationView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,400) paprameters:@[
                                                                                                                                              [ZYWaveAnimationView parametersWithSpeed:3 A:34 Omega:0.9 Phi:M_PI_2 H:300 Alpha:0.3 FillColor:[UIColor whiteColor]],
                                                                                                                                              [ZYWaveAnimationView parametersWithSpeed:3 A:33 Omega:1 Phi:M_PI H:300 Alpha:0.4 FillColor:[UIColor whiteColor]],
                                                                                                                                              [ZYWaveAnimationView parametersWithSpeed:3 A:32 Omega:1.1 Phi:M_PI*3/2 H:300 Alpha:0.5 FillColor:[UIColor whiteColor]],
                                                                                                                                              [ZYWaveAnimationView parametersWithSpeed:1 A:10 Omega:1.5 Phi:15 H:320 Alpha:1 FillColor:[UIColor whiteColor]]]];
    
    
    waveView.backgroundColor =[UIColor blueColor];;
    
    [self.view addSubview:waveView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
