#import "FastZip.h"
#import "Stubs.h"

@implementation FastZip

@synthesize buffer, offset, size, keys;

+ (id) withBuffer: (char*) buff size: (unsigned long) sz {
  return [[[self alloc] initWithBuffer: buff size: sz] autorelease];
}

- (id) initWithBuffer: (char*) buff size: (unsigned long) sz {
  if (self = [super init]) {
    buffer = buff;
    offset = 0;
    size = sz;
    keys = [NSMutableArray new];

    [self parseBuffer];
  }
  return self;
}

- (NSData *) objectForKey: (NSString *) key {
  return nil;
}

- (void) parseBuffer {
  // install our own set of functions for file I/O
  zlib_filefunc_def readFunctions;
  readFunctions.zopen_file = &fopen_file_func;
  readFunctions.zopendisk_file = &fopendisk_file_func;
  readFunctions.zread_file = &fread_file_func;
  readFunctions.zwrite_file = NULL; // we never write to a zip
  readFunctions.ztell_file = &ftell_file_func;
  readFunctions.zseek_file = &fseek_file_func;
  readFunctions.zclose_file = &fclose_file_func;
  readFunctions.zerror_file = &ferror_file_func;

  // ensure a reference to ourself gets passed around to everyone
  readFunctions.opaque = self;

  // open!
  unzOpen2(NULL, &readFunctions);

  // unz_global_info info;
  // unzGetGlobalInfo(NULL, &info);
}

- (void) dealloc {
  [keys release], keys = nil;
  [super dealloc];
}

@end
