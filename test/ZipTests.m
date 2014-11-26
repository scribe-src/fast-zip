#import "UnitTest.h"
#import "FastZip.h"

TEST_SUITE(ZipTests)

TEST(ATxtZipFileExists)

  NSData *data = [NSData dataWithContentsOfFile: @"./test/data/a.txt.zip"];
  Assert(data && [data length] > 0);

END_TEST

TEST(ATxtZipFileContainsFiles)

  NSData *data = [NSData dataWithContentsOfFile: @"./test/data/a.txt.zip"];
  FastZip *zip = [[FastZip alloc] initWithBuffer: (char*)[data bytes] size: [data length]];
  Assert(zip.keys.count == 1);
  [zip release];

END_TEST

TEST(ATxtZipFileContainsTheFileADotTxt)

  NSData *data = [NSData dataWithContentsOfFile: @"./test/data/a.txt.zip"];
  FastZip *zip = [[FastZip alloc] initWithBuffer: (char*)[data bytes] size: [data length]];
  AssertObjEqual([zip.keys objectAtIndex: 0], @"a.txt");
  [zip release];

END_TEST

TEST(ATxtZipFileDecompressesCorrectly)

  NSData *data = [NSData dataWithContentsOfFile: @"./test/data/a.txt.zip"];
  FastZip *zip = [[FastZip alloc] initWithBuffer: (char*)[data bytes] size: [data length]];
  AssertObjEqual([NSString stringWithUTF8String: [[zip dataForKey: @"a.txt"] bytes]], @"a");
  [zip release];

END_TEST


TEST(ATxtZipFileDecompressesStringCorrectly)

  NSData *data = [NSData dataWithContentsOfFile: @"./test/data/a.txt.zip"];
  FastZip *zip = [[FastZip alloc] initWithBuffer: (char*)[data bytes] size: [data length]];
  AssertObjEqual([zip stringForKey: @"a.txt"], @"a");
  [zip release];

END_TEST

TEST(ATxtZipFileLookupCompressedData)

  NSData *data = [NSData dataWithContentsOfFile: @"./test/data/a.txt.zip"];
  FastZip *zip = [[FastZip alloc] initWithBuffer: (char*)[data bytes] size: [data length]];
  AssertNotNil([zip compressedDataForKey: @"a.txt"]);
  [zip release];

END_TEST

END_TEST_SUITE
