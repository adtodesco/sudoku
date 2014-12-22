//
//  Board.m
//  TodescoSudoku
//
//  Created by Anthony Todesco on 5/10/13.
//  Copyright (c) 2013 Anthony Todesco. All rights reserved.
//

#import "Board.h"

@implementation Board

// Initializes board with random puzzle.  Allocs a NSMutableArray for original
// numbers and a Stack for the undo.  Locks the starting numbers and pushes
// the original board into the undo stack.
- (id) initWithString:(NSString *)start {
    if (self = [super init]) {
        self.locked = [[NSMutableArray alloc] initWithCapacity:BOARDSIZE];
        self.stack = [[Stack alloc] init];
        self.board = start;
        [self lockStartingNumbers];
        [self.stack push:self.board];
    }
    return self;
}

// Returns the character at row and col.  If the character is a "." then it
// returns an empty string.
- (NSString *)getCharAtRow:(int)row Col:(int)col {
    int index = col + (row * COLS);
    NSString *digit = [self.board substringWithRange:NSMakeRange(index, 1)];
    if ([digit isEqualToString:@"."]) {
        digit = @"";
    }
    return digit;
}

// Takes an integer and sets the square at row and col to equal that integer
- (void)setSquareAtRow:(int)row Col:(int)col WithNumber:(int)num {
    if (![self boardIsLockedAtRow:row Col:col]) {
        int index = col + (row * COLS);
        if (![self.board isEqualToString:[self.stack peek]]) {
            [self.stack push:self.board];
        }
        if (num == 0) {
            self.board = [self.board stringByReplacingCharactersInRange:NSMakeRange(index, 1)
                                                             withString:@"."];
        }
        else {
            self.board = [self.board stringByReplacingCharactersInRange:NSMakeRange(index, 1)
                                                             withString:[NSString stringWithFormat:@"%d", num]];
        }

    }
    
}

// Inserts all numbers in original puzzle into an NSMutableArray
- (void)lockStartingNumbers {
    for (int i = 0; i < BOARDSIZE; i++) {
        if(![[self.board substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"."]) {
            self.locked[i] = [NSNumber numberWithInt:1];
        }
        else {
            self.locked[i] = [NSNumber numberWithInt:0];
        }
    }
}

// Checks to see if a row and col contains an original number
- (BOOL)boardIsLockedAtRow:(int)row Col:(int)col {
    int index = col + (row * COLS);
    if (self.locked[index] == [NSNumber numberWithInt:1]) {
        return true;
    }
    return false;
}

// Pops off the last board inserted into the stack to perform and undo operation
- (void)undo {
    if ([self.stack peek]!=NULL) {
        self.board = [self.stack pop];
    }
}

// Resets the board by calling undo the size of the stack
- (void)reset {
    while ([self.stack size] > 0) {
        [self undo];
    }
}

// Checks to see if a number is in a legal position on the board
- (BOOL)isLegalAtRow:(int)row Col:(int)col WithNumber:(int)num{
    int colNumberInstances = 0;
    for (int compareRow = 0; compareRow < ROWS; compareRow++) {
        int index = col + (compareRow * COLS);
        NSString *compare = [self.board substringWithRange:NSMakeRange(index, 1)];
        if ([compare isEqualToString:[NSString stringWithFormat:@"%d",num]]) {
            colNumberInstances++;
            if(colNumberInstances > 1) {
                return false;
            }
        }
    }
    int rowNumberInstances = 0;
    for (int compareCol = 0; compareCol < COLS; compareCol++) {
        int index = compareCol + (row * COLS);
        NSString *compare = [self.board substringWithRange:NSMakeRange(index, 1)];
        if ([compare isEqualToString:[NSString stringWithFormat:@"%d",num]]) {
            rowNumberInstances++;
            if(rowNumberInstances > 1) {
                return false;
            }
        }
    }
    int squareNumberInstances = 0;
    row = [self rowColSquare:row];
    col = [self rowColSquare:col];
    for(int compareRow = row; compareRow < row + 3; compareRow++) {
        for(int compareCol = col; compareCol < col + 3; compareCol++) {
            int compareIndex = compareCol + (compareRow * COLS);
            NSString *compare = [self.board substringWithRange:NSMakeRange(compareIndex, 1)];
            if([compare isEqualToString:[NSString stringWithFormat:@"%d",num]]) {
                squareNumberInstances++;
                if(squareNumberInstances > 1) {
                    return false;
                }
            }
        }
    }
    return true;
}

// Takes in an index and sets it equal to the index of the top left of the box it is in
- (int)rowColSquare:(int)index {
    if (index < 3) {
        index = 0;
    }
    else if (index < 6){
        index = 3;
    }
    else {
        index = 6;
    }
    return index;
}

// Checks to see if the board is finished
- (BOOL)done{
    for (int row = 0; row < ROWS; row++) {
        for (int col = 0; col < COLS; col++) {
            int index = col + (row * COLS);
            NSString *numString = [self.board substringWithRange:NSMakeRange(index, 1)];
            if ([numString isEqualToString:@"."]) {
                return false;
            }
            int num = [numString intValue];
            if (![self isLegalAtRow:row Col:col WithNumber:num]) {
                return false;
            }
        }
    }
    return true;
}

// Basic puzzle solver. Iterates each box until it is legal then goes to the next.  If it cannot
// find a legal number it goes back one box and searches for another legal number.  This only works
// if the puzzle has approximately 20 or less empty boxes.  Otherwise it takes too long/runs out of
// memory.
- (NSString *)solvePuzzle:(NSString *)puzzle withIndex:(int)num {
    if (num == 81) {
        return puzzle;
    }
    int row = num / 9;
    int col = num % 9;
    for (int number = 1; number <= 9; number++) {
        NSString* returnPuzzle;
        NSString* puzzlePass;
        if (![[puzzle substringWithRange:NSMakeRange(num, 1)] isEqualToString: @"."]) {
            returnPuzzle = [self solvePuzzle:puzzle withIndex:num + 1];
        }
        else if ([self solvePuzzleLegalAtRow:row Col:col WithNumber:number forString:puzzle]) {
            puzzlePass = puzzle;
            puzzlePass = [puzzlePass stringByReplacingCharactersInRange:NSMakeRange(num, 1)
                                                             withString:[NSString stringWithFormat:@"%d", number]];
            returnPuzzle = [self solvePuzzle:puzzlePass withIndex:num + 1];
        }
        if (returnPuzzle != nil) {
            return returnPuzzle;
        }
    }
    return nil;
}

// Similar to isLegalAtRow but takes in a string as a parameter.  Created to work with solvePuzzle method
- (BOOL)solvePuzzleLegalAtRow:(int)row Col:(int)col WithNumber:(int)num forString:(NSString *)string{
    for (int compareRow = 0; compareRow < ROWS; compareRow++) {
        int index = col + (compareRow * COLS);
        NSString *compare = [string substringWithRange:NSMakeRange(index, 1)];
        if ([compare isEqualToString:[NSString stringWithFormat:@"%d",num]]) {
            return false;
        }
    }
    for (int compareCol = 0; compareCol < COLS; compareCol++) {
        int index = compareCol + (row * COLS);
        NSString *compare = [string substringWithRange:NSMakeRange(index, 1)];
        if ([compare isEqualToString:[NSString stringWithFormat:@"%d",num]]) {
            return false;
        }
    }
    row = [self rowColSquare:row];
    col = [self rowColSquare:col];
    for(int compareRow = row; compareRow < row + 3; compareRow++) {
        for(int compareCol = col; compareCol < col + 3; compareCol++) {
            int compareIndex = compareCol + (compareRow * COLS);
            NSString *compare = [string substringWithRange:NSMakeRange(compareIndex, 1)];
            if([compare isEqualToString:[NSString stringWithFormat:@"%d",num]]) {
                    return false;
            }
        }
    }
    return true;
}

@end
