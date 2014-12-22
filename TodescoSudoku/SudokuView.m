//
//  SudokuView.m
//  TodescoSudoku
//
//  Created by Anthony Todesco on 5/10/13.
//  Copyright (c) 2013 Anthony Todesco. All rights reserved.
//

#import "SudokuView.h"

@implementation SudokuView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    int fieldWidth = COLS;
    int fieldHeight = ROWS;
    
    CGPoint temp;
    
    // Draws the 9x9 Grid
    for (int i = 0; i < fieldWidth; i++) {
        for (int j = 0; j < fieldHeight; j++) {
            int x = FIELDINSET + i * CELLSIZE;
            int y = FIELDINSET + j * CELLSIZE;
            CGRect rectangle = CGRectMake(x,y,CELLSIZE,CELLSIZE);
            temp.x = i;
            temp.y = j;
            CGContextSetLineWidth(context, 2.0);
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
            CGContextFillRect(context, rectangle);
            CGContextStrokeRect(context, rectangle);
            
            // Gets the contents of the square from Board through the controller
            NSString *digit = [self.delegate getContentAtRow:j Col:i];

            CGPoint mid;
            mid.x = x + (CELLSIZE / 3);
            mid.y = y + 10;
            
            if ([self.delegate isLockedAtRow:j Col:i]) {
                [[UIColor blackColor] setFill];
            }
            else if (![self.delegate numLegalAtRow:j Col:i]) {
                [[UIColor redColor] setFill];
            }
            else {
                [[UIColor blueColor] setFill];
            }
            // Draws the digit in the color set above
            [digit drawAtPoint:mid withFont:[UIFont systemFontOfSize:48.0]];
        }
    }
    
    // Draws the 3x3 Bold Grid
    for (int i = 0; i < fieldWidth; i = i + 3) {
        for (int j = 0; j < fieldHeight; j = j + 3) {
            int x = FIELDINSET + i * CELLSIZE;
            int y = FIELDINSET + j * CELLSIZE;
            CGRect rectangle = CGRectMake(x,y,CELLSIZE * 3.0,CELLSIZE * 3.0);
            temp.x = i;
            temp.y = j;
            CGContextSetLineWidth(context, 5.0);
            CGContextStrokeRect(context, rectangle);
        }
    }
    
    // Draws the 1x9 Digit Grid with numbers
    for (int i = 0; i < fieldWidth; i++) {
        int x = FIELDINSET + i * CELLSIZE;
        CGRect rectangle = CGRectMake(x, FIELDINSET + GAPHEIGHT + (ROWS * CELLSIZE), CELLSIZE, CELLSIZE);
        temp.x = i;
        temp.y = 1;
        CGContextSetLineWidth(context, 5.0);
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        CGContextFillRect(context, rectangle);
        CGContextStrokeRect(context, rectangle);
        
        CGPoint mid;
        mid.x = x + (CELLSIZE / 3);
        mid.y = FIELDINSET + GAPHEIGHT + (ROWS * CELLSIZE) + 10;
        NSString *digit = [NSString stringWithFormat:@"%d", i+1];
        [[UIColor blackColor] setFill];
        [digit drawAtPoint:mid withFont:[UIFont systemFontOfSize:48.0]];
    }
    
    // Draws the "Clear" rectangle
    CGRect rectangle = CGRectMake(FIELDINSET + CELLSIZE * 3.0 + 30, FIELDINSET + (GAPHEIGHT * 2) + (CELLSIZE * (ROWS + 1)), CELLSIZE * 3.0 - 60, CELLSIZE);
    CGContextSetLineWidth(context, 5.0);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, rectangle);
    CGContextStrokeRect(context, rectangle);
    
    CGPoint mid;
    mid.x = FIELDINSET + CELLSIZE * 3.0 + 55;
    mid.y = FIELDINSET + (GAPHEIGHT * 2) + (CELLSIZE * (ROWS + 1)) + 10;
    NSString *digit = @"Clear";
    [[UIColor blackColor] setFill];
    [digit drawAtPoint:mid withFont:[UIFont systemFontOfSize:48.0]];
    
}

// Sets up the tap recognizer for the grid, numbers, and clear button
- (void)tap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint tapPoint = [gesture locationInView:self];
        int fieldWidth = COLS;
        int fieldHeight = ROWS;
        
        CGPoint temp;
        // Recognizer for grid
        for (int i = 0; i < fieldWidth; i++) {
            for (int j = 0; j < fieldHeight; j++) {
                int x = FIELDINSET + i * CELLSIZE;
                int y = FIELDINSET + j * CELLSIZE;
                CGRect rectangle = CGRectMake(x,y,CELLSIZE,CELLSIZE);
                if (CGRectContainsPoint(rectangle, tapPoint)) {
                    [self.delegate squareSelectedAtRow:j Col:i];
                }
                temp.x = i;
                temp.y = j;
            }
        }
        
        // Recognizer for number grid
        for (int i = 0; i < fieldWidth; i++) {
            int x = FIELDINSET + i * CELLSIZE;
            CGRect rectangle = CGRectMake(x, FIELDINSET + GAPHEIGHT + (ROWS * CELLSIZE), CELLSIZE, CELLSIZE);
            if (CGRectContainsPoint(rectangle, tapPoint)) {
                [self.delegate numberSelected:i+1];
            }
            temp.x = i;
            temp.y = 1;
        }
        
        // Recognizer for clear button
        CGRect rectangle = CGRectMake(FIELDINSET + CELLSIZE * 3.0 + 30, FIELDINSET + (GAPHEIGHT * 2) + (CELLSIZE * (ROWS + 1)), CELLSIZE * 3.0 - 60, CELLSIZE);
        if (CGRectContainsPoint(rectangle, tapPoint)) {
            [self.delegate numberSelected:0];
        }
    }
}


@end
