//
//  Board.h
//  TodescoSudoku
//
//  Created by Anthony Todesco on 5/10/13.
//  Copyright (c) 2013 Anthony Todesco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Constants.h"

@interface Board : NSObject

- (id) initWithString:(NSString *)start;
- (NSString *)getCharAtRow:(int)row Col:(int)col;
- (void)setSquareAtRow:(int)row Col:(int)col WithNumber:(int)num;
- (void)lockStartingNumbers;
- (BOOL)boardIsLockedAtRow:(int)row Col:(int)col;
- (BOOL)isLegalAtRow:(int)row Col:(int)col WithNumber:(int)num;
- (int)rowColSquare:(int)index;
- (void)undo;
- (void)reset;
- (BOOL)done;
- (NSString *)solvePuzzle:(NSString *)puzzle withIndex:(int)num;
- (BOOL)solvePuzzleLegalAtRow:(int)row Col:(int)col WithNumber:(int)num forString:(NSString *)string;

@property (nonatomic) NSString *board;
@property (nonatomic) NSMutableArray *locked;
@property (nonatomic) Stack *stack;

@end
