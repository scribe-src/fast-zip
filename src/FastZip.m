#import "FastZip.h"
#import "Stubs.h"

@implementation FastZip

@synthesize buffer, offset, size, keys;

+ (id) withData: (NSData *) data {
  return [[[self alloc] initWithData: data] autorelease];
}

+ (id) withBuffer: (char*) buff size: (unsigned long) sz {
  return [[[self alloc] initWithBuffer: buff size: sz] autorelease];
}

- (id) initWithData: (NSData *) data {
  return [self initWithBuffer: (char*)[data bytes] size: [data length]];
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

- (NSData *) dataForKey: (NSString *) key {
  NSUInteger index = [keys indexOfObject: key];

  if (index != NSNotFound) {
    unzGoToFirstFile(file);
    for (int i = 0; i < index; i++) {
      unzGoToNextFile(file);
    }
    unzOpenCurrentFile(file);
    unz_file_info fileInfo;
    unzGetCurrentFileInfo(file, &fileInfo, NULL, 0, NULL, 0, NULL, 0);

    int len = fileInfo.uncompressed_size;
    void* buf = malloc(len);
    unzReadCurrentFile(file, buf, len);
    unzCloseCurrentFile(file);
    return [NSData dataWithBytesNoCopy: buf length: len freeWhenDone: YES];
  }

  return nil;
}

- (NSString *) stringForKey: (NSString *) key {
  return [NSString stringWithUTF8String: [[self dataForKey: key] bytes]];
}

- (NSData *) compressedDataForKey: (NSString *) key {
  NSUInteger index = [keys indexOfObject: key];

  if (index != NSNotFound) {
    unzGoToFirstFile(file);
    for (int i = 0; i < index; i++) {
      unzGoToNextFile(file);
    }
    int compressionMethod, compressionLevel;
    unzOpenCurrentFile2(file, &compressionMethod, &compressionLevel, 1);
    unz_file_info fileInfo;
    unzGetCurrentFileInfo(file, &fileInfo, NULL, 0, NULL, 0, NULL, 0);

    int len = fileInfo.compressed_size;
    void* buf = malloc(len);
    unzReadCurrentFile(file, buf, len);
    unzCloseCurrentFile(file);
    return [NSData dataWithBytesNoCopy: buf length: len freeWhenDone: YES];
  }

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
  file = unzOpen2(NULL, &readFunctions);

  unz_global_info info;
  if (unzGetGlobalInfo(file, &info) == UNZ_OK) {
    // printf("%d\n", info.number_entry);
    // printf("%ld\n", info.number_disk_with_CD);
    // printf("%ld\n", info.size_comment);

    for (int i = 0; i < info.number_entry; i++) {
      char filename[2048];
      unzOpenCurrentFile(file);
      unz_file_info fileInfo;
      unzGetCurrentFileInfo(file, &fileInfo, filename, 2048, NULL, 0, NULL, 0);
      [keys addObject: [NSString stringWithCString: filename encoding: NSASCIIStringEncoding]];

      unzCloseCurrentFile(file);
      unzGoToNextFile(file);
    }
  }
}

- (void) dealloc {
  [keys release], keys = nil;
  [super dealloc];
}

@end
