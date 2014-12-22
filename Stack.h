//
//  Stack.h
//  TodescoSudoku
//
//  Created by Eric Chown on 4/9/13.
//  Copyright (c) 2013 edu.bowdoin.cs210.chown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"

@interface Stack : NSObject

@property (nonatomic, strong) List *stack;

- (void)push:(id)anObject;
- (id)pop;
- (id)peek;
- (BOOL)isEmpty;
- (int)size;
@end
