#import "UnitTest.h"
#import "FastZip.h"

TEST_SUITE(InstantiationTests)

TEST(FastZipDotBuffer)

  char a;
  FastZip *f = [[FastZip alloc] initWithBuffer: &a size: 1];
  AssertEqual(f.buffer, &a);
  [f release];

END_TEST

TEST(FastZipDotCurrIsHeadOfBuffer)

  char a;
  FastZip *f = [[FastZip alloc] initWithBuffer: &a size: 1];
  AssertEqual(f.curr, &a);
  [f release];

END_TEST

TEST(FastZipDotSize)

  char a;
  FastZip *f = [[FastZip alloc] initWithBuffer: &a size: 1];
  AssertIntEqual(f.size, 1);
  [f release];

END_TEST

TEST(FastZipDotKeys)

  char a;
  FastZip *f = [[FastZip alloc] initWithBuffer: &a size: 1];
  AssertIntEqual(f.keys.count, 0);
  [f release];

END_TEST

TEST(StaticMethodConstructor)

  char a;
  FastZip *f = [FastZip withBuffer: &a size: 1];
  AssertIntEqual(f.size, 1);

END_TEST

END_TEST_SUITE
