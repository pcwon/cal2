//
//  ActionView.m
//  actionGame
//
//  Created by lab09 on 12. 6. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ActionView.h"

@implementation ActionView
- (id)initWithFrame:(CGRect)frame


{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(int)rand:(int)num{
    return abs(arc4random())%num;
    
}

//수치 -> 문자열

-(NSString*)num2str:(int)num len:(int)len{
    return [NSString stringWithFormat:@"%d",num];
    
}

// 코더 초기화 

-(id)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        //사이즈 지정값
        CGRect bounds=[[UIScreen mainScreen]bounds];
        if (bounds.size.width<bounds.size.height) {
            WIDTH = bounds.size.height;
            HEIGHT = bounds.size.width;
        }else {
            WIDTH =bounds.size.width;
            HEIGHT=bounds.size.height;
        }
        SCALE = -1;
        if (WIDTH>640) {
            SCALE = 2;
            WIDTH /=2;
            HEIGHT /=2;
            
        }
        //시스템
        _g=[[Graphics alloc]init];
        _bmp = [NSMutableArray array];
        for (int i= 0 ; i <4; i++) {
            [_bmp addObject:[UIImage imageNamed:[NSString stringWithFormat:@"act%d.png",i ]]];
             
        }
        //타이머 시작 
        _init = S_TITLE;
        [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
        
        
    }
    return self;
}
-(void)dealloc{
    
}


- (void)drawRect:(CGRect)rect{
    
    //컨텍스트 지정 
    [_g setContext:UIGraphicsGetCurrentContext()];
    [_g setScaleW:SCALE h:SCALE];
    
    //버퍼 클리어 
    [_g setColorR:0 g:0 b:0];
    [_g fillRectX:0 y:0 w:WIDTH h:HEIGHT];
  
    //장면 초기화 
    if (_init>=0) {
        _scene =_init;
        
        
        //타이틀
        if (_scene ==S_TITLE) {
            _message = @"Touch Start";
            _score = 0;
            _playerY = HEIGHT-50;
            _jumpPow = 0;
            _jumpAble = YES;
            _mapDX = 0;
            for (int i=0; i<10; i++) {
                _mapH[i]=1;
                
            }
            
            
            //플레이
        }else if(_scene == S_PLAY){
            _message = nil;
            _touchDown=NO;
            
            //게임오버
        }else if (_scene == S_GAMEOVER) {
            _message =@"Game Over";
        }
        
    _init =-1;
    _tick = 0;
    _key = KEY_NONE;
    }
/////////플레이 시의 처리 
    if (_scene==S_PLAY) {
        //점수 가산 
        _scene++;
        
        //충돌 판정
        if (_playerY>HEIGHT-_mapH[2]*50) {
            _init=S_GAMEOVER;
            _jumpAble=NO;
            
        }
        //위로 이동
        else if (_jumpPow >= 0){
            _playerY -= _jumpPow*2;
            _jumpPow--;
        }
        //아래로 이동(3)
        else {
            _playerY +=12;
            _jumpPow=NO;
            if (_mapH[2] !=0 &&
                _playerY > HEIGHT-_mapH[2]*50) {
                _playerY=HEIGHT-_mapH[2]*50;
                _jumpAble=YES;
            }
        }
////////// //스크롤 처리(2)
        _mapDX-=10;
        if (_mapDX==-50) {
            _mapDX=0;
            
            //지면의 높이를 왼쪽으로 시프트
            for(int i=0;i<11;i++) _mapH[i]=_mapH[i+1];
            
            int idx=[self rand:6];
            //[10]이 구멍일 때는 [9]와 같은 높이 
            if (_mapH[10] ==0) {
                _mapH[11]=_mapH[7];
            }
            //)1/6의 확률로 [11]을 구멍    
            else if (idx ==0 ) {
                _mapH[11]=0;
                
            }
            //1/6의 확률로 [11]을 [10]의 높이 +1
            else if (idx ==1){
                _mapH[11] = _mapH[10]+1;
                if (_mapH[11]>4) {
                    _mapH[11]=4;
                   }
             }
            //1/6의 확률로 [11]을 [10]의 높이 -1
            else if (idx ==2){
                _mapH[11] = _mapH[10]-1;
                if (_mapH[11]<1) {
                    _mapH[11]=1;
                }
            }

        }
///////////// //점프 처리 (3)
        if (_jumpAble) {
            if (_touchDown) {
                _jumpAble=NO;
                _jumpPow=14;
            }
        }else {
            if (!_touchDown) {
                _jumpPow=-10;
            }
        }
 }
//게임오버 때의 처리 
    else if(_scene ==S_GAMEOVER){
        if (_playerY<700) {
            _playerY+=16;
        }
    }
    
}



@end
