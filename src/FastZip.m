#import "FastZip.h"

@implementation FastZip

- (id) initWithBuffer: (const char*) buff {
  if (self = [super init]) {
    buffer = buff;
  }
  return self;
}

- (NSArray *) keys {
  return nil;
}

- (NSData *) objectForKey: (NSString *) key {
  return nil;
}

@end
