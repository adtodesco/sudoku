//
//  List.m
//  TodescoSudoku
//
//  Created by Eric Chown on 4/4/13.
//  Copyright (c) 2013 edu.bowdoin.cs210.chown. All rights reserved.
//

#import "List.h"

@implementation List

@synthesize tail = _tail;
@synthesize head = _head;
@synthesize count = _count;

- (id)init
{
    if (self = [super init]) {
        self.count = 0;
        self.head = NULL;
        self.tail = NULL;
    }
    return self;
}

- (void)addToHead:(id)anObject
{
    Node *temp = [[Node alloc] init];
    temp.data = anObject;
    temp.next = self.head;
    self.head = temp;
    if (self.count == 0) {
        self.tail = temp;
    }
    self.count++;
}

- (void)addToTail:(id)anObject
{
    Node *temp = [[Node alloc] init];
    temp.data = anObject;
    temp.next = nil;
    self.tail.next = temp;
    self.tail = temp;
    if (self.count == 0) {
        self.head = temp;
    }
    self.count++;
}

- (id)removeFromHead
{
    id object = self.head.data;
    if (self.count == 1) {
        self.tail = nil;
    }
    if (self.count > 0) {
        self.count--;
    }
    self.head = self.head.next;
    return object;
}

- (id)removeFromTail
{
    id temp = self.tail.data;
    Node *finger = self.head;
    while (finger.next.next) {
        finger = finger.next;
    }
    self.tail = finger;
    self.tail.next = nil;
    if (self.count > 0) {
        self.count--;
    }
    return temp;
}

- (id)getHeadData
{
    return self.head.data;
}

- (id)getTailData
{
    return self.tail.data;
}

- (void)clear
{
    self.head = nil;
    self.tail    = nil;
    self.count = 0;
}

- (int)size
{
    return self.count;
}

- (BOOL)isEmpty
{
    return self.count == 0;
}



@end