//
//  Graphics.h
//  actionGame
//
//  Created by lab09 on 12. 6. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//Graphics 선언 (4)
@interface Graphics : NSObject{
    
    CGContextRef    _context;       //컨텍스트
    unsigned char*  _contextBMP;    //컨텍스트BMP
    UIFont*         _font;          //폰트 
    
}

//컨텍스트
-(void)setContext:(CGContextRef)context;
-(void)makeContext:(CGSize)size;
-(void)releaseContext;

//출력 설정
-(void)setColorR:(float)r g:(float)g b:(float)b a:(float)a;
-(void)setColorR:(float)r g:(float)g b:(float)b;
-(void)setFont:(UIFont*)font;
-(void)setLineWidth:(float)lineWidth;
-(int)stringWidth:(NSString*)str;
-(void)setScaleW:(float)scaleW h:(float)scaleH;

//출력
-(void)drawLineX0:(float)x0 y0:(float)y0 x1:(float)x1 y1:(float)y1;
-(void)drawRectX:(float)x y:(float)y w:(float)w h:(float)h;
-(void)fillRectX:(float)x y:(float)y w:(float)w h:(float)h;
-(void)drawImage:(UIImage*)image x:(float)x y:(float)y;
-(void)drawImage:(UIImage*)image x:(float)x y:(float)y w:(float)w h:(float)h;
-(void)drawString:(NSString*)string x:(float)x y:(float)y;


@end
