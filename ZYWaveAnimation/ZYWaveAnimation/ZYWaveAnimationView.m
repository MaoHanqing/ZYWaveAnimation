//
//  ZYWaveAnimationView.m
//  11.28
//
//  Created by 毛汉卿 on 2016/12/2.
//  Copyright © 2016年 毛汉卿. All rights reserved.
//

#import "ZYWaveAnimationView.h"

@interface ZYWaveAnimationView ()
{
    CGFloat _offSet ;
}
@property (nonatomic,strong) NSMutableArray <CAShapeLayer*>*waves;
@property (nonatomic,strong) NSMutableArray *offsets;
@end
NSString *const ZYWaveSpeedKey = @"ZYWaveSpeedKey";
NSString *const ZYWaveAmplitudeKey = @"ZYWaveAmplitudeKey";
NSString *const ZYWavePhiKey =@"ZYWavePhiKey";
NSString *const ZYWaveOmegaKey =@"ZYWaveOmegaKey";
NSString *const ZYWavehKey =@"ZYWavehKey";
NSString *const ZYWaveFillColorKey =@"ZYWaveFillColorKey";
NSString *const ZYWaveStrokeColorKey = @"ZYWaveStrokeColorKey";
NSString *const ZYWavelineWidthKey =@"ZYWavelineWidthKey";
NSString *const ZYWaveAlphaKey = @"ZYWaveAlphaKey";
@implementation ZYWaveAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame paprameters:(NSArray<NSDictionary*>*)parameters{
    self = [super initWithFrame:frame];
    if (self) {
        self.wavesParameters  = parameters;
    }
    return self;
}
- (void)displayLinkAction:(CADisplayLink*)sender{
    CGFloat waveWidth = CGRectGetWidth(self.frame);
    CGFloat height= self.frame.size.height;
    [self.waves enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *parameter = self.wavesParameters[idx];
        CGFloat waveA = [parameter[ZYWaveAmplitudeKey] floatValue];
        
        CGFloat offset =  [self.offsets[idx] floatValue] ;
        CGFloat speed = [parameter[ZYWaveSpeedKey] floatValue];
        offset += speed;
        [self.offsets replaceObjectAtIndex:idx withObject:@(offset)];
        CGFloat Omega = [parameter [ZYWaveOmegaKey] floatValue];
        CGFloat Phi = [parameter [ZYWavePhiKey] floatValue];
        CGFloat h = [parameter [ZYWavehKey] floatValue];
        
        
        //设置第一条波曲线的路径
        CGMutablePathRef pathRef = CGPathCreateMutable();
        //起始点
        CGFloat startY = waveA*sin(offset*M_PI/waveWidth+Phi);
        CGPathMoveToPoint(pathRef, NULL, 0, startY);
        //第一个波的公式
        for (CGFloat x = 0.0; x < waveWidth; x ++) {
          CGFloat  y = waveA * sin(Omega/waveWidth*M_PI* x+(offset)*M_PI/waveWidth+Phi)+h;
            CGPathAddLineToPoint(pathRef, NULL, x, y);
        }
        CGPathAddLineToPoint(pathRef, NULL, waveWidth, height);
        CGPathAddLineToPoint(pathRef, NULL, 0, height);
        CGPathCloseSubpath(pathRef);
        //设置第一个波layer的path
        obj.path = pathRef;
        CGPathRelease(pathRef);
    }];
    
}

#pragma mark - tool
- (CAShapeLayer*)wavelayerWithParameters:(NSDictionary *)parameters{
    CAShapeLayer *shapeLayer= [CAShapeLayer layer];
    shapeLayer.fillColor = ((UIColor *)parameters[ZYWaveFillColorKey]).CGColor;
    if (parameters[ZYWaveStrokeColorKey]) {
        shapeLayer.strokeColor =((UIColor *)parameters[ZYWaveStrokeColorKey]).CGColor;
    }
    if (parameters[ZYWavelineWidthKey]) {
        shapeLayer.lineWidth = [parameters[ZYWavelineWidthKey] integerValue];
    }
    if (parameters[ZYWaveAlphaKey]) {
        shapeLayer.opacity =[parameters[ZYWaveAlphaKey] floatValue];
    }
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}
+ (NSDictionary *)parametersWithSpeed:(CGFloat)speed A:(CGFloat)A Omega:(CGFloat)Omega Phi:(CGFloat)Phi  H:(CGFloat)H Alpha:(CGFloat)alpha FillColor:(UIColor*)fillColor{
    return  @{ZYWaveSpeedKey:@(speed),ZYWaveAmplitudeKey:@(A),ZYWavehKey:@(H),ZYWaveAlphaKey:@(alpha),ZYWaveFillColorKey:fillColor,ZYWavePhiKey:@(Phi),ZYWaveOmegaKey:@(Omega)};
}
#pragma mark - setter getter
-(void)setWavesParameters:(NSArray<NSDictionary *> *)wavesParameters{
    _wavesParameters = wavesParameters;
    [_wavesParameters enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.waves addObject:[self wavelayerWithParameters:obj]];
        [self.offsets addObject:@(0)];
    }];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
-(NSMutableArray *)waves{
    if (!_waves) {
        _waves =[[NSMutableArray alloc]init];
    }
    return _waves;
}
-(NSMutableArray *)offsets{
    if (!_offsets) {
        _offsets = [[NSMutableArray alloc]init];
        
    }
    return _offsets;
}
@end
