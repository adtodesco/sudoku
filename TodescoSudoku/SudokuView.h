//
//  SudokuView.h
//  TodescoSudoku
//
//  Created by Anthony Todesco on 5/10/13.
//  Copyright (c) 2013 Anthony Todesco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class SudokuView;

// Delegate methods
@protocol SudokuViewDelegate
- (NSString *)getContentAtRow:(int)row Col:(int)col;
- (void)numberSelected:(int)number;
- (void)squareSelectedAtRow:(int)row Col:(int)col;
- (BOOL)isLockedAtRow:(int)row Col:(int)col;
- (BOOL)numLegalAtRow:(int)row Col:(int)col;

@end

// Creates the delegate
@interface SudokuView : UIView {
    id <SudokuViewDelegate> delegate;
}

@property (nonatomic) id <SudokuViewDelegate> delegate;

@end
