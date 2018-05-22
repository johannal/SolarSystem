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
    os_log_t _pointsOfInterestLog;
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
//        _pointsOfInterestLog = os_log_create("com.demo.SolarSystem", "PointsOfInterest");
    }
    return self;
}

- (void) parsingStarted:(NSUInteger)identifier dataSize:(NSInteger)dataSize {
//    os_signpost_interval_begin(_pointsOfInterestLog, identifier, "JSONParsing", "Started parsing data of size %lu", (unsigned long)dataSize);
    os_signpost_interval_begin(_httpCustomLog, identifier, "ResponseParsing", "[ID:%ld][SIZE:%ld]", (long)identifier, dataSize);
}

- (void) parsingFinished:(NSUInteger)identifier {
//    os_signpost_interval_end(_pointsOfInterestLog, identifier, "JSONParsing", "Finished parsing");
    os_signpost_interval_end(_httpCustomLog, identifier, "ResponseParsing", "[ID:%ld]", (long)identifier);
}

- (void) requestStarted:(NSUInteger)logID url:(NSString *)url type:(NSString *)type userIdentifier:(NSString *)userIdentifier  {
    os_signpost_interval_begin(_httpCustomLog, logID, "NetworkRequest", "Request started [ID:%ld][URL:%{public}@][TYPE:%{public}@][CATEGORY:%{public}@]", (long)logID, url, type, userIdentifier);
}

- (void) requestFinished:(NSUInteger)logID code:(NSInteger)code {
    os_signpost_interval_end(_httpCustomLog, logID, "NetworkRequest", "Request finished [ID:%ld][CODE:%ld]", (long)logID, (long)code);
}

@end
