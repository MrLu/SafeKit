//
//  NSArray+SafeKit.m
//  SafeKitExample
//
//  Created by zhangyu on 14-2-28.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "NSArray+SafeKit.h"
#import "NSObject+swizzle.h"

@implementation NSArray (SafeKit)

- (instancetype)initWithObjects_safe:(id *)objects count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
#ifdef DEBUG
            SafeAssert(false, @"NSArray initWithObjects:count: anObject is nil");
#endif
            break;
        }
        newCnt++;
    }
    self = [self initWithObjects_safe:objects count:newCnt];
    return self;
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
#ifdef DEBUG
        SafeAssert(false, @"NSArray objectAtIndex: index >= count");
#endif
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

- (NSArray *)safe_arrayByAddingObject:(id)anObject {
    if (!anObject) {
#ifdef DEBUG
        SafeAssert(false, @"NSArray arrayByAddingObject: anObject is nil");
#endif
        return self;
    }
    return [self safe_arrayByAddingObject:anObject];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(initWithObjects_safe:count:) tarClass:@"__NSPlaceholderArray" tarSel:@selector(initWithObjects:count:)];
        [self safe_swizzleMethod:@selector(safe_objectAtIndex:) tarClass:@"__NSArrayI" tarSel:@selector(objectAtIndex:)];
        [self safe_swizzleMethod:@selector(safe_arrayByAddingObject:) tarClass:@"__NSArrayI" tarSel:@selector(arrayByAddingObject:)];
    });
}

@end
