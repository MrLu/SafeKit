//
//  SafeKitMacro.h
//  SafeKitExample
//
//  Created by zhangyu on 14-3-24.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#if __has_feature(objc_arc)
#define SK_AUTORELEASE(exp) exp
#define SK_RELEASE(exp) exp
#define SK_RETAIN(exp) exp
#else
#define SK_AUTORELEASE(exp) [exp autorelease]
#define SK_RELEASE(exp) [exp release]
#define SK_RETAIN(exp) [exp retain]
#endif

//可以修改这里处理 caseTest 可以去掉
#define SafeAssert(condition, desc, ...) \
    NSAssert(condition, desc, ##__VA_ARGS__)
