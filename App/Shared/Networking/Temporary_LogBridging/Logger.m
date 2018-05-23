//
//  Logger.m
//  Solar System
//
//  Copyright © 2018 Apple. All rights reserved.
//

#import "Logger.h"
#import <sys/kdebug_signpost.h>
#import <objc/runtime.h>
#import <stdatomic.h>
#import <os/log.h>
#import <os/signpost.h>

@implementation Logger {
    os_log_t _httpCustomLog;
}

void swift_os_signpost_impl(os_log_t log, os_signpost_id_t sid, os_signpost_type_t type, const char *name, NSString *rendered) {
    NSString *composed = [NSString stringWithFormat:@"[%s] %@", name, rendered];
    if (type == OS_SIGNPOST_INTERVAL_BEGIN) {
        os_signpost_interval_begin(log, sid, "", "%s", composed.UTF8String);
    } else {
        os_signpost_interval_end(log, sid, "", "%s", composed.UTF8String);
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpCustomLog = os_log_create("com.demo.SolarSystem", "Networking");
    }
    return self;
}

- (void) parsingStarted:(NSUInteger)identifier dataSize:(NSInteger)dataSize {
    os_signpost_interval_begin(_httpCustomLog, identifier, "ResponseParsing", "Parsing started SIZE:%ld", dataSize);
}

- (void) parsingFinished:(NSUInteger)identifier {
    os_signpost_interval_end(_httpCustomLog, identifier, "ResponseParsing", "Parsing finished");
}

- (void) requestStarted:(NSUInteger)logID url:(NSString *)url type:(NSString *)type userIdentifier:(NSString *)userIdentifier  {
    os_signpost_interval_begin(_httpCustomLog, logID, "NetworkRequest", "Request started URL:%{public}@,TYPE:%{public}@,CATEGORY:%{public}@", url, type, userIdentifier);
}

- (void) requestFinished:(NSUInteger)logID code:(NSInteger)code {
    os_signpost_interval_end(_httpCustomLog, logID, "NetworkRequest", "Request finished CODE:%ld", (long)code);
}

@end
