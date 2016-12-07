//
//  ZYWaveAnimationView.h
//  11.28
//
//  Created by 毛汉卿 on 2016/12/2.
//  Copyright © 2016年 毛汉卿. All rights reserved.
//

#import <UIKit/UIKit.h>
//y=Asin（Omegax+Phi）+h
extern NSString *const ZYWaveSpeedKey;//波浪流动速度
extern NSString *const ZYWaveAmplitudeKey;//A当前波浪振幅
extern NSString *const ZYWavePhiKey;//初相位
extern NSString *const ZYWaveOmegaKey;//决定周期
extern NSString *const ZYWavehKey;
extern NSString *const ZYWaveAlphaKey;
extern NSString *const ZYWaveFillColorKey;
extern NSString *const ZYWaveStrokeColorKey;
extern NSString *const ZYWavelineWidthKey;
@interface ZYWaveAnimationView : UIView
@property (nonatomic,strong) NSArray <NSDictionary*>* wavesParameters;
-(instancetype)initWithFrame:(CGRect)frame paprameters:(NSArray<NSDictionary*>*)parameters;
+ (NSDictionary *)parametersWithSpeed:(CGFloat)speed A:(CGFloat)A Omega:(CGFloat)Omega Phi:(CGFloat)Phi  H:(CGFloat)H Alpha:(CGFloat)alpha FillColor:(UIColor*)fillColor;
@end
