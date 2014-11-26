#import "FastZip.h"

// this doesn't actually do anything, since the buffer is already in memory
static void* fopen_file_func(void* opaque, const char* filename, int mode) {
  return NULL;
}

// this doesn't actually do anything, since the buffer is already in memory
static void* fopendisk_file_func(void* opaque, void* stream, int number_disk, int mode) {
  return NULL;
}

static unsigned long fread_file_func(
  void* opaque,
  void* stream,
  void* buf,
  unsigned long size)

{
  FastZip *instance = (FastZip *)opaque;
  unsigned long rest = instance.size - instance.offset;
  size = (rest > size) ? size : rest;
  memcpy(stream, &(instance.buffer[instance.offset]), size);
  return size;
}




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
  readFunctions.zread_file = 

  // ensure a reference to ourself gets passed around to everyone
  readFunctions.opaque = self;

  // open!
  unzOpen2(NULL, &readFunctions);

}

- (void) dealloc {
  [keys release], keys = nil;
  [super dealloc];
}

@end
