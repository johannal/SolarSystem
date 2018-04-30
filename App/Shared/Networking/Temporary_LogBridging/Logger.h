//
//  Logger.h
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <os/signpost.h>

NS_ASSUME_NONNULL_BEGIN

extern void swift_os_signpost_impl(os_log_t log, os_signpost_id_t sid, os_signpost_type_t type, const char *name, NSString *rendered);

@interface Logger : NSObject
- (void) parsingStarted:(NSUInteger)identifier dataSize:(NSInteger)dataSize;
- (void) parsingFinished:(NSUInteger)identifier;
- (void) requestStarted:(NSUInteger)logID url:(NSString *)url type:(NSString *)type;
- (void) requestFinished:(NSUInteger)logID code:(NSInteger)code;
@end

NS_ASSUME_NONNULL_END
