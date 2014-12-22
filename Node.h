//
//  Node.h
//  TodescoSudoku
//
//  Created by Eric Chown on 4/4/13.
//  Copyright (c) 2013 edu.bowdoin.cs210.chown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) id data;
@property (nonatomic, strong) Node *next;

@end
