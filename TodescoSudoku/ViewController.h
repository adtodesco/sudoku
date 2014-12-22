//
//  ViewController.h
//  TodescoSudoku
//
//  Created by Anthony Todesco on 5/10/13.
//  Copyright (c) 2013 Anthony Todesco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuView.h"
#import "Board.h"

// Sets ViewController as delegate of SudokuView
@interface ViewController : UIViewController <SudokuViewDelegate>

@property (weak, nonatomic) IBOutlet SudokuView *sudokuView;
@property (nonatomic, strong) Board *theBoard;
@property (nonatomic) int selectedNumber;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)solvePuzzle:(UIButton *)sender;
- (IBAction)newGame:(UIButton *)sender;
- (IBAction)undoMove:(UIButton *)sender;
- (IBAction)resetBoard:(UIButton *)sender;

@end
