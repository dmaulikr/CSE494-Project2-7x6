//
//  BoardView.m
//  7x6
//
//  Created by Buv Sethia on 11/26/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "BoardView.h"

@implementation BoardView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        for (int i = 0; i < ROWS; i++) {
            for(int j = 0; j < COLUMNS; j++){
                pieceColors[i][j] = [UIColor whiteColor];
            }
        }
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    float workingHeight = 6*height/7;
    float circleRadius = workingHeight/7;
    float distance = width/7;
    CGContextRef context = UIGraphicsGetCurrentContext();
    for(int i = 0; i < COLUMNS; i++){
        for(int j = 0; j < ROWS; j++){
            CGContextSetLineWidth(context, 1.0);
            CGRect rectangle = CGRectMake((distance/4) + (distance * i),20+(circleRadius+5)*j,circleRadius,circleRadius);
            CGContextAddEllipseInRect(context, rectangle);
            CGContextSetFillColorWithColor(context,
                                   pieceColors[j][i].CGColor);
            CGContextFillPath(context);
        }
    }
}

-(void)updatePieceColorAt:(int)row And:(int)column With:(UIColor *)color
{
    pieceColors[row][column] = color;
}

@end
