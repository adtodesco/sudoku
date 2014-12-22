//
//  ViewController.m
//  TodescoSudoku
//
//  Created by Anthony Todesco on 5/10/13.
//  Copyright (c) 2013 Anthony Todesco. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize sudokuView = _sudokuView;
@synthesize theBoard = _theBoard;
@synthesize selectedNumber = _selectedNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Reads in the puzzles from "msk_009" puts it into NSString content
    NSString* path = [[NSBundle mainBundle] pathForResource:@"msk_009"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    // Splits up content into array of strings "puzzles"
    NSArray *puzzles = [content componentsSeparatedByString:@"\n"];
    
    // Declares itself as delegate
    self.sudokuView.delegate = self;
    
    // Creates random int from 0 - 1010 and then calls that random puzzle
    int randomPuzzle = arc4random() %1010;
    // Allocs board with puzzle
    self.theBoard = [[Board alloc] initWithString:puzzles[randomPuzzle]];
    // Initializes properties
    self.label.text = @"";
    self.selectedNumber = 0;
    
    // Creates gesture recognizer
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self.sudokuView action:@selector(tap:)];
    [self.sudokuView addGestureRecognizer:tap];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Returns content of board at row and col
- (NSString *)getContentAtRow:(int)row Col:(int)col {
    return [self.theBoard getCharAtRow:row Col:col];
}

// When number on number grid is selected, sets selected number
- (void)numberSelected:(int)number {
    self.selectedNumber = number;

}

// When square is selected and game is not over, tells the board to
// set square to selected number
- (void)squareSelectedAtRow:(int)row Col:(int)col {
    if (![self.theBoard done]) {
        [self.theBoard setSquareAtRow:row Col:col WithNumber:self.selectedNumber];
        [self.sudokuView setNeedsDisplay];
        
        if([self.theBoard done]) {
            self.label.text = @"You win!";
        }
    }

}

// Checks to if the number at row and col is part of the original puzzle
- (BOOL)isLockedAtRow:(int)row Col:(int)col {
    return [self.theBoard boardIsLockedAtRow:row Col:col];
}

// Checks if a number on the board at row and col is legal in its current position
- (BOOL)numLegalAtRow:(int)row Col:(int)col {
    int index = col + (row * COLS);
    NSString *num = [self.theBoard.board substringWithRange:NSMakeRange(index, 1)];
    return [self.theBoard isLegalAtRow:row Col:col WithNumber:[num intValue]];
}

// Solves the original puzzle [Note: This solver only works with approximately 20 empty
// boxes or less.  Puzzle[1011] demonstrates this solver]
- (IBAction)solvePuzzle:(UIButton *)sender {
    [self.theBoard reset];
    self.theBoard.board = [self.theBoard solvePuzzle:self.theBoard.board withIndex:0];
    [self.sudokuView setNeedsDisplay];
}

// Creates a new game
- (IBAction)newGame:(UIButton *)sender {
    [self viewDidLoad];
    [self.sudokuView setNeedsDisplay];
}

// Takes back the last move made
- (IBAction)undoMove:(UIButton *)sender {
    if(![self.theBoard done]) {
        [self.theBoard undo];
        [self.sudokuView setNeedsDisplay];
    }
}

// Sets the board back to the original puzzle
- (IBAction)resetBoard:(UIButton *)sender {
    if(![self.theBoard done]) {
        [self.theBoard reset];
        [self.sudokuView setNeedsDisplay];
    }
}
@end
