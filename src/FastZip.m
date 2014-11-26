#import "FastZip.h"


@implementation FastZip

@synthesize buffer, curr, size, keys;

+ (id) withBuffer: (char*) buff size: (int) sz {
  return [[[self alloc] initWithBuffer: buff size: sz] autorelease];
}

- (id) initWithBuffer: (char*) buff size: (int) sz {
  if (self = [super init]) {
    buffer = buff;
    curr = buff;
    size = sz;
    keys = [NSMutableArray new];
  }
  return self;
}

- (NSData *) objectForKey: (NSString *) key {
  return nil;
}

- (void) parseBuffer {
  zlib_filefunc_def readFunctions;
  file = unzOpen2(NULL, &readFunctions);
}

- (void) dealloc {
  [keys release], keys = nil;
  [super dealloc];
}

@end
