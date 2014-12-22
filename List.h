//
//  List.h
//  TodescoSudoku
//
//  Created by Eric Chown on 4/4/13.
//  Copyright (c) 2013 edu.bowdoin.cs210.chown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface List : NSObject

@property (nonatomic, strong) Node *head;
@property (nonatomic, strong) Node *tail;
@property int count;

- (void)addToHead:(id)anObject;
- (void)addToTail:(id)anObject;
- (id)removeFromHead;
- (id)removeFromTail;
- (void) clear;
- (int) size;
- (id) getHeadData;
- (id) getTailData;
- (BOOL)isEmpty;

@end
