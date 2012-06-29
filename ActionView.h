//
//  ActionView.h
//  actionGame
//
//  Created by lab09 on 12. 6. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Graphics.h"
//장면의 지정값(1)
#define S_TITLE 0  //타이틀
#define S_PLAY 1   //플레이 
#define S_GAMEOVER 2 //게임오버

//키 지정값
#define KEY_NONE   -1
#define KEY_SELECT  6

@interface ActionView : UIView{
    
    
    //사이즈 지정값
    int WIDTH;
    int HEIGHT;
    int SCALE;
    
    //시스템
    int             _init; 
    int             _scene;
    int             _key;
    BOOL            _touchDown;
    int             _tick;
    Graphics*       _g;
    NSMutableArray* _bmp;
    NSString*       _message;
    int             _score;
    
    //플레이어 (3)
    int _playerY;
    int _jumpPow;
    int _jumpAble;
    
    //지면(2)
    
    int _mapDX;
    int _mapH[12];
    
}

@end
