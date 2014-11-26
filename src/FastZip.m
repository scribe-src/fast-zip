#import "FastZip.h"

@implementation FastZip

- (id) initWithBuffer: (const char*) buff {
  if (self = [super init]) {
    buffer = buff;
    curr = buff;
  }
  return self;
}

- (NSArray *) keys {
  return (NSArray *)keys;
}

- (NSData *) objectForKey: (NSString *) key {
  return nil;
}

@end
