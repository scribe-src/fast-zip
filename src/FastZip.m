#import "FastZip.h"

@implementation FastZip

@synthesize buffer, curr, size;

+ (id) withBuffer: (char*) buff size: (int) sz {
  return [[[self alloc] initWithBuffer: buff size: sz] autorelease];
}

- (id) initWithBuffer: (char*) buff size: (int) sz {
  if (self = [super init]) {
    buffer = buff;
    curr = buff;
    size = sz;
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
