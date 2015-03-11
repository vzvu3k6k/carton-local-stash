# carton local stash

This is a git post-checkout hook script to stash and restore local/ using cpanfile content as a key when you checkout a branch.

## Why?

carton uses cpanm to install dependencies and it doesn't remove modules from local/ when you remove modules from cpanfile. And cpanfile.snapshot is generated from modules installed in local/.

It means if you add module X in branch A to cpanfile and run `carton install`, then checkout another branch whose cpanfile doesn't have module X and run `carton install`, you'll get cpanfile.snapshot contains module X.

See also: [carton - cpanfileから消したはずの依存がcpanfile.snapshotに残る - Qiita](http://qiita.com/vzvu3k6k/items/72955846d29dbd508e36)

## Requirements

- perl 5 (tested on v5.8 and v5.20)
  - You have to install [File::Copy::Recursive](http://search.cpan.org/~dmuey/File-Copy-Recursive-0.38/Recursive.pm).

## Limitations

- Before checking out branches, you have to ensure cpanfile is not modified after its last commit and `carton install` is run after cpanfile is changed.

## License

[Creative Commons — CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/)

## Build Status

[![Build Status](https://travis-ci.org/vzvu3k6k/carton-local-stash.svg?branch=master)](https://travis-ci.org/vzvu3k6k/carton-local-stash)
