fast-zip [![Build Status](https://travis-ci.org/scribe-src/fast-zip.svg)](https://travis-ci.org/scribe-src/fast-zip)

==

`fast-zip` implements a small Objective-C wrapper around `minizip` that allows for in-memory ZIP access. No ARC support at this time.

#### Setup

    $ git submodule update --init --recursive

#### Sample Code

    FastZip *zip = [FastZip withData: data];

    // prints every filename in the zip
    NSLog(@"%@", [zip keys]);

    // look up the data for a given file:
    NSData *binaryData = [zip stringForKey: @"data.bin"];

    // if your file is has no NULL terminators:
    NSString *jsonString = [zip stringForKey: @"config.json"];

    // you can also get the raw compressed data
    NSData *zippedData = [zip compressedDataForKey: @"data.bin"];

#### Build

    $ make all

#### Run tests

    $ make test

#### License

 - FastZip itself is released under the [BSD3 License](http://opensource.org/licenses/BSD-3-Clause)
 - minizip is included under the [Zlib License](www.zlib.net/zlib_license.html)

#### Copyright

    2014 Scribe.io
