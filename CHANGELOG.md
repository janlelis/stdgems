# Change Log

## 5.14.0

Ruby releases: 3.4.0

- Final updates of default and bundled gems for Ruby 3.4

## 5.13.0

Ruby releases: 3.3.6

- Update 3.2's default gems: bundler, rubygems, json, syntax_suggest, reline
- Update 3.2's bundled gems: rexml, debug

## 5.12.0

Ruby releases: 3.2.6

- Update 3.2's default gems: uri
- Update 3.2's bundled gems: rexml, rss

## 5.11.0

Add default and bundled gems for Ruby 3.4 preview release 2

Gem movements: default to bundled

- mutex_m
- getoptlong
- base64
- bigdecimal
- observer
- abbrev
- resolv-replace
- rinda
- drb
- nkf
- syslog
- csv

New bundled gems

- repl_type_completor

Other changes

- The json gem repository is now part of the Ruby organization

## 5.10.0

Ruby releases: 3.3.5

- Update 3.3's default gems: bundler, rubygems, uri
- Update 3.3's bundled gems: rexml, rss

## 5.9.0

Ruby releases: 3.2.5

No default gem changes, bump bundled gem rexml

## 5.8.1

Ruby releases: 3.3.4

No standard gem changes, but add note about missing dependencies to:
net-pop, net-ftp, net-imap, and prime

## 5.8.0

Ruby releases: 3.3.3

- Update 3.3's default gems: bundler, rubygems, stringio, strscan
- Update 3.3's bundled gems: rexml

## 5.7.0

Ruby releases: 3.3.2, 3.1.6

- Update 3.3's irb, reline, zlib
- No version changes in 3.1.6

## 5.6.1

Fix Ruby 3.3 bundled versions for debug, net-imap, rbs, typeprof

## 5.6.0

Ruby releases: 3.2.4, 3.1.5, 3.0.7

- Update 3.2 default gem: rdoc

- Update 3.1 default gems: bundler, cgi, net-http, rdoc, rubygems, stringio, uri
- Update 3.1 bundled gems: net-ftp, net-imap, net-smtp

- Update 3.0 default gems: rdoc, stringio
- Update 3.0 bundled gems: power_assert

## 5.5.0

Ruby release: 3.3.1

- Update default gems: bundler, net-http, rdoc, rubygems
- Update bundled gems: net-ftp, net-imap, net-smtp
- Fix version of bundled net-imap for Ruby 3.3.0

## 5.4.0

Ruby release: 3.2.3

- Update default gems: bundler, net-http, rubygems, uri
- Update bundled gems: net-ftp, net-imap, net-smtp

## 5.3.0

Ruby release: 3.3.0

- Final updates of default and bundled gems for Ruby 3.3
- Update maintainers for irb, reline, uri

## 5.2.0

- Update default and bundled gems for Ruby 3.3 release candidate 1
- Add prism default gem
- Add "willBecomeBundledGem" flags

## 5.1.0

- Update default and bundled gems for Ruby 3.3 preview release 2
- racc is moved from default gem to bundled gem

## 5.0.0

Adjust new stdgems.json API: Make list of gems an Array

## 4.0.1

Use camelCase for new fields in stdgems.json

## 4.0.0

New JSON file:

stdgems.json - a single API for all standard libraries and gems

Other changes:

- Add top-level "info" field to JSON files
- Clarify the set vs sorted_set situation
- Remove maintainers from removed gems

## 3.11.0

Update default and bundled gems for Ruby 3.3 preview release 1

## 3.10.0

Ruby release: 3.2.2, 3.1.4, 3.0.6, 2.7.8

- Update Ruby 3.2's bundler, rubygems, time, uri
- Update Ruby 3.1's time, uri
- Update Ruby 3.0's time, uri
- Fix uri version for other Ruby 3.0s
- Update Ruby 2.7's uri

## 3.9.0

Ruby release: 3.2.1

- Update Ruby 3.2's bundler, rubygems

## 3.8.2

- abbrev in Ruby 3.2 is 0.1.1 #18

## 3.8.1

- Fix RDoc links; point most of them to rubyapi.org

## 3.8.0

Ruby release: 3.2.0

- Final Ruby 3.2.0 gem updates

## 3.7.1

- Update default & bundled gems to Ruby 3.2 release candidate 1

## 3.7.0

Ruby release: 3.1.3, 3.0.5, 2.7.7

- Update Ruby 3.1's bundler, cgi, csv, net-http, openssl, optparse,
  psych, reline, rubygems, securerandom
- Update Ruby 3.1's bundled gems: debug, rbs
- Update Ruby 3.0's cgi, openssl, optparse
- Update Ruby 2.7's cgi, openssl

## 3.6.3

- Update default & bundled gems to latest Ruby 3.2 preview release 3

## 3.6.2

- Update altenative to matrix #15
- Fix typo #16

## 3.6.1

- Fix Ruby 3.2's date

## 3.6.0

Ruby 3.2 preview release 1

- Default gem updates: bigdecimal, bundler, cgi, etc, io-wait, logger,
  net-protocol, ostruct, reline, rubygems,
  securerandom
- Bundled gem updates: debug, rbs

## 3.5.0

Ruby release: 3.1.2, 3.0.4, 2.7.6, 2.6.10

- Update Ruby 3.0's bundler, prettyprint, rubygems, io-wait (in 3.0.3)
- Update Ruby 2.6's date

## 3.4.0

Ruby release: 3.1.1

- Default gem updates: bundler, io-console, rubygems, ipaddr
- Bundled gem updates: rbs, typeprof, net-imap

## 3.3.0

- Add alternatives / similar gems: Import from Idiosyncratic Ruby + update

## 3.2.0

- Add JRuby sources for default gems & libraries
- Add RDoc links (via rubydoc.info) to more gems

## 3.1.0

Ruby release: 3.1.0

- Final Ruby 3.1.0 gem updates

## 3.0.4

- Update Ruby 3.1's (preview) bundled & default gems
- Fix source for rbconfig.rb

## 3.0.3

- Fix optparse version for Ruby 3.1.0 and 3.0.3
- Add sources for rbconfig.rb

## 3.0.2

- Update Ruby 3.1's (preview) bundled & default gems
- Add instructions how you can disable some auto-required gems
  like did_you_mean
- Improve details website of a gem by adding proper version
  tables and link gem versions on GitHub

## 3.0.1

- Add ruby2_keywords gem to Ruby 3.1
- Add (missing) continuation to libraries, still included in Ruby
- Change website structure to highlight that some libraries
  will not be gemified (and other website tweaks)

## 3.0.0

### Website Updates

- New website design
- Gem version tables for a Ruby version now include an extra
  column with the gem version included in the previous Ruby
  version for quicker comparisons
- Fix gems that appear as both, bundled and default gems
- Remove Ruby 2.5 from supported Rubies table
- Add new ALL VERSIONS table which includes every standard
  gem version of every Ruby since 2.2.0.
- Add ChangeLog to website

### Gem Updates

- Update Ruby 3.1's (preview) bundled & default gems

## 2.8.0

Ruby releases: 3.0.3, 2.7.5, 2.6.9

### Default Gems

- Update Ruby 3.0's bundler, cgi, date, debug, drb, etc,
  fcntl, fiddle, io-wait, net-protocol, openssl, optparse,
  pp, psych, racc, rdoc, resolv, rinda, rubygems, stringio,
  strscan, zlib
- Update Ruby 2.7's cgi, date, openssl- Update Ruby 2.7's cgi, date, openssl
- Update Ruby 2.6's date

### Bundled Gems

- Update Ruby 3.0's typeprof to 0.15.2
- Update Ruby 3.0's rbs to 1.4.0

## 2.7.0

Ruby release: 3.0.0-preview1

- Update Ruby 3.1's (preview) bundled gems
  - Add new debug gem
  - Move matrix, prime, and some net-\* from default to bundled
- Update Ruby 3.1's (preview) default gems
  - Add error_highlight gem
  - Remove tracer, dbm, and gdbm
  - Add metadata for did_you_mean, drb, pathname, pp,
    prettyprint, readline, readline-ext, reline, resolv,
    resolv-replace, un, win32ole
- Other Ruby 3.1 changes:
  - Remove fiber standard library (built-in now)

## 2.6.1

- Fix optparse version on Ruby 3.0 #9
- Remove expect from list of standard libraries, since it is
  part of pty #7; Add note explaining this

## 2.6.0

Ruby releases: 3.0.2, 2.7.4, 2.6.8

### Default Gems

- Update Ruby 3.0's bundler to 2.2.22
- Update Ruby 3.0's net-ftp to 0.1.2
- Update Ruby 3.0's rdoc to 6.3.1
- Update Ruby 2.7's rdoc to 6.2.1.1
- Update Ruby 2.6's rdoc to 6.1.2.1

## 2.5.0

Ruby releases: 3.0.1, 2.7.3, 2.6.7, 2.5.9

### Default Gems

- Update Ruby 3.0's bundler to 2.2.15
- Update Ruby 3.0's io-console to 0.5.7
- Update Ruby 3.0's irb to 1.3.5
- Update Ruby 3.0's reline to 0.2.5
- Update Ruby 3.0's rubygems to 3.2.15
- Update Ruby 3.0's tmpdir to 0.1.2
- Update Ruby 2.7's rexml to 3.2.3.1
- Update Ruby 2.7's rubygems to 3.1.6
- Update Ruby 2.7's webrick to 1.6.1
- Update Ruby 2.6's rexml to 3.1.9.1
- Update Ruby 2.6's rubygems to 3.0.3.1
- Update Ruby 2.6's webrick to 1.4.4
- Update Ruby 2.5's rubygems to 2.7.6.3
- Update Ruby 2.5's webrick to 1.4.2.1

### Bundled Gems

- Update Ruby 3.0's rexml to 3.2.5
- Update Ruby 3.0's rbs to 1.0.4
- Update Ruby 3.0's typeprof to 0.12.0

## 2.4.1

- Remove kconv from list of standard libraries, since it is
  part of nkf #6

## 2.4.0

- Ruby release: 3.0.0

### Default Gems

- Ruby 3.0 final updates:
  benchmark, bundler, cgi, date, delegate, did_you_mean, english,
  etc, fiddle, fileutils, forwardable, getoptlong, irb, json,
  logger, mutex_m, net-ftp, net-http, net-imap, net-pop, observer,
  open3, pstore, psych, rdoc, reline, resolv, rubygems, set,
  singleton, tempfile, timeout, tmpdir, tracer, weakref, yaml

### Bundled Gems

- Ruby 3.0 final updates:
  rake, test-unit, typeprof

## 2.3.0

- Ruby release: 3.0.0-rc1

### Default Gems

- Ruby 3.0 rc1 additional updates:
  bigdecimal, bundler, digest, fiddle, irb, json, matrix,
  prime, psych, reline, stringio, strscan
- Ruby 3.0 rc1 additional gemifications:
  debug, digest, drb, pathname, pp, prettyprint,
  un, win32ole
- Ruby 3.0 rc1 additional removals:
  webrick
- Maintainer updates: irb, prime

### Bundled Gems

- Ruby 3.0 rc1 additional updates:
  rake, rbs, typeprof

## 2.2.0

- Ruby release: 3.0.0-preview2

### Default Gems

- Ruby 3.0 preview2 additional updates:
  csv, fiddle, net-smtp, optparse, ostruct, racc,
  readline-ext, reline
- Ruby 3.0 preview2 additional gemifications:
  debug, digest, drb, pathname, pp, prettyprint,
  un, win32ole

### Bundled Gems

- Ruby 3.0 preview2 additional updates:
  test-unit, rbs
- Ruby 3.0 preview2 additional additions:
  typeprof

## 2.1.0

- Ruby release: 2.7.2

### Default Gems

- Update Ruby 2.7's irb to 1.2.6
- Update Ruby 2.7's reline to 0.1.5
- Update Ruby 2.7's rubygems to 3.1.4

## 2.0.1

- Fix: uri is not removed

## 2.0.0

### Default Gems

- Ruby 3.0 preview1 updates:
  bigdecimal, bundler, csv, date, fiddle, json, matrix, openssl,
  psych, rubygems, stringio, strscan
- Ruby 3.0 preview1 gemifications:
  abbrev, base64, english, erb, find, io-nonblock, io-find,
  net-ftp, net-http, net-imap, net-protocol, nkf, open-uri,
  optparse, racc, resolv, resolv-replace, rinda, securerandom,
  set, shellwords, syslog, tempfile, time, tmpdir, tsort,
  weakref
- Ruby 3.0 preview1 removals:
  sdbm

### Bundled Gems

- Ruby 3.0 preview1 updates:
  minitest, power_assert, test-unit
- Ruby 3.0 preview1 removals:
  net-telnet, xmlrpc
- Ruby 3.0 preview1 moved from default gems:
  rexml, rss
- Ruby 3.0 preview1 additions:
  rbs

### Misc

- Remove sourceRepositoryIsUpstream flag from default gems
- Add remaining rubygems links (all standard gems are now also published on rubygems.org)
- Update repository links for bundler and power_assert
- Monitor standard library is a native extension now

## 1.18.0

Ruby releases 2.6.5, 2.5.7, 2.4.9, 2.4.8

### Default Gems

- Update Ruby 2.7's bundler to 2.1.4
- Update Ruby 2.7's io-console to 0.5.6
- Update Ruby 2.7's irb to 1.2.3 and reline to 0.1.3
- Add note to json gem about security update

### Bundled Gems

- Update Ruby 2.7's power_assert to 1.1.7
- Update Ruby 2.6's rake to 12.3.3
- Update Ruby 2.5's rake to 12.3.3

## 1.17.1

### Default Gems

- Fix did_you_mean version

## 1.17.0

Ruby release: 2.7.0

### Default Gems

- Ruby 2.7 final updates:
  bundler, io-console, irb, matrix, ostruct, prime, rdoc, readline, reline, rubygems

## 1.16.0

### Default Gems

- Ruby 2.7 preview updates (rc1):
  bundler, forwardable, io-console, json, rubygems

### Bundled Gems

- Ruby 2.7 preview updates (rc1):
  rake

## 1.15.0

### Default Gems

- Ruby 2.7 preview updates:
  date, dbm, etc, fileutils, forwardable, gdbm, io-console, irb, logger, reline, stringio,
  webrick, zlib
- Gemify:
  uri
- Remove:
  e2mm
- Promote did_you_mean from bundled to default gem

## 1.14.1

### Default Gems

- Correct "removed" flags

## 1.14.0

### Default Gems

- Gemify:
  benchmark, cgi, delegate, getoptlong, net-pop, net-smtp, observer, open3, pstore,
  readline, readline-ext, singleton, timeout, yaml
- Ruby 2.7 preview default gems updates:
  reline

### Bundled Gems

- Ruby 2.7 preview bundled gems updates:
  minitest

## 1.13.0

### Default Gems

- Ruby 2.7 preview updates:
  bigdecimal, csv, fileutils, io-console, reline, rexml, stringio, strscan
- Ruby 2.7 removals:
  cmath, scanf, shell, sync, thwait

### Bundled Gems

- Ruby 2.7 preview bundled gems updates:
  did_you_mean, minitest, rake, test-unit

## 1.12.1

### Default Gems

- Improve webrick note

## 1.12.0

Ruby releases 2.6.5, 2.5.7, 2.4.9, 2.4.8

### Default Gems

- Update webrick (see note)

## 1.11.0

Ruby releases 2.6.4, 2.5.6, 2.4.7

### Default Gems

- Update Ruby 2.7's rdoc to 6.2.0
- Update Ruby 2.7's rexml to 3.2.2
- Update Ruby 2.7's reline to 0.0.1
- Update Ruby 2.6's rdoc to 6.1.2
- Update Ruby 2.5's rdoc to 6.0.1.1
- Update Ruby 2.4's rdoc to 5.0.1

### Bundled Gems

- Update Ruby 2.7's rake to 12.3.3
- Update Ruby 2.7's power_assert to 1.1.5

## 1.10.0

Ruby preview release: 2.7.0

### Default Gems

- Ruby 2.7 preview changes:
  Updates bigdecimal, bundler, irb, json, rubygems, rss
- Update strscan's maintainer to Kouhei Sutou (kou)
- Add reline gem

### Bundled Gems

- Ruby 2.7 preview changes: Updates power_assert, test-unit

### Other

- Remove profiler & profile

## 1.9.0

Ruby release: 2.6.2

### Default Gems

- Update Ruby 2.6's csv to 3.0.9

## 1.8.0

Ruby release: 2.4.6

### Default Gems

- Update Ruby 2.4's rubygems to 2.6.14.4

## 1.7.0

Ruby releases: 2.6.2, 2.5.4

### Default Gems

- Update Ruby 2.6's rubygems to 3.0.3
- Update Ruby 2.5's rubygems to 2.7.6.2

## 1.6.0

Ruby release 2.6.1

### Default Gems

- Update Ruby 2.6's date to 2.0.0
- Update Ruby 2.6's csv to 3.0.4
- Fix Ruby 2.6's bigdecimal (it's 1.4.1)

## 1.5.0

Ruby releases: 2.6.0

### Default Gems

- Update Ruby 2.6's bigdecimal to 1.4.2
- Update Ruby 2.6's csv to 3.0.2
- Update Ruby 2.6's io-console to 0.4.7
- Update Ruby 2.6's rexml to 3.1.9
- Fix Ruby 2.6's rubygems version

### Bundled Gems

- Update Ruby 2.6's did_you_mean to 1.3.0

## 1.4.7

### Default Gems

- Update Ruby 2.6's rubygems to 3.0.1
- Update Ruby 2.6's csv to 3.0.2
- Update Ruby 2.6's rexml to 3.1.8

## 1.4.6

### Default Gems

- Update Ruby 2.6's irb to 1.0.0
- Update Ruby 2.6's ipaddr to 1.2.2

## 1.4.5

### Default Gems

- Fix typo in bundler version
- Update Ruby 2.6's logger to 1.3.0
- Update Ruby 2.6's openssl to 1.1.2
- Update Ruby 2.6's sync to 0.5.0
- Update rubygems links

## 1.4.4

### Default Gems

- Downgrade Ruby 2.6's bundler to 1.17.2

### Bundler Gems

- Update Ruby 2.6's rake to 12.3.1
- Update Ruby 2.6's test-unit to 3.2.9

## 1.4.3

### Default Gems

- Update Ruby 2.6's bigdecimal to 1.4.0

## 1.4.2

### Default Gems

- Update Ruby 2.6's stringio to 0.0.2

## 1.4.1

### Default Gems

- Ruby 2.6: Add bundler

## 1.4.0

Ruby releases: 2.5.3, 2.5.2, 2.4.5, 2.3.8

### Default Gems

- Update Ruby 2.5's openssl to 2.1.2
- Fix Ruby 2.5's rdoc (it's 6.0.1)
- Update Ruby 2.4's openssl to 2.0.9
- Update Ruby 2.4's rubygems to 2.6.14.3

## 1.3.1

### Default Gems

- Update Ruby 2.6's csv to 3.0.1
- Update Ruby 2.6's psych to 3.1.0
- Update Ruby 2.6's rdoc to 6.1.0

## 1.3.0

Ruby 2.6 (preview) changes

## 1.2.0

Ruby releases: 2.5.1, 2.4.4, 2.3.7, 2.2.10

### Default Gems

- Update Ruby 2.4's bigdecimal to 1.3.2
- Update Ruby 2.4's openssl to 2.0.7
- Update Ruby 2.5's rdoc to 6.0.3
- Update Ruby 2.5's rubygems to 2.7.6
- Update Ruby 2.4's rubygems to 2.6.14.1
- Update Ruby 2.3's rubygems to 2.5.2.3
- Update Ruby 2.2's rubygems to 2.4.5.4

## 1.1.2

### Default Gems

- Update etc's, fcntl's, and zlib's maintainers

## 1.1.1

### Default Gems

- Update csv's maintainer

## 1.1.0

- Add new libraries.json file which lists non-gemified standard libraries

## 1.0.0

Ruby 2.5 release

## 0.1.17

### Default Gems

- Update Ruby 2.5's bigdecimal to 1.3.4
- Update Ruby 2.5's rdoc to 6.0.1
- Update Ruby 2.5's webrick to 1.4.2
- Ruby 2.5's stringio is only at 0.0.1

## 0.1.16

### Default Gems

- Remove digest (will not be gemified with Ruby 2.5)
- Update Ruby 2.5's cmath to 1.0.0
- Update Ruby 2.5's etc to 1.0.0
- Update Ruby 2.5's fileutils to 1.0.2
- Update Ruby 2.5's psych to 3.0.2
- Update Ruby 2.5's stringio to 1.0.0
- Update Ruby 2.5's strscan to 1.0.0
- Update Ruby 2.5's webrick to 1.4.1
- Improve rubygems' rubygems link

## 0.1.15

### Default Gems

- Add rubygems itself as a default gem

## 0.1.14

### Default Gems

- Update Ruby 2.5's bigdecimal to 1.3.3
- Update Ruby 2.5's bundler to 1.16.1
- Update Ruby 2.5's csv to 1.0.0
- Update Ruby 2.5's date to 1.0.0
- Update Ruby 2.5's fcntl to 1.0.0
- Update Ruby 2.5's fileutils to 1.0.1
- Update Ruby 2.5's sdbm to 1.0.0
- Update Ruby 2.5's scanf to 1.0.0
- Update Ruby 2.5's zlib to 1.0.0
- Add Hiroshi SHIBATA (hsbt) as maintainer for bundler
- Fix Ruby 2.4's json version: 2.0.4
- Add Ruby 2.4's webrick version: 1.3.1

### Bundled Gems

- Update Ruby 2.5's did_you_mean to 1.2.0
- Update Ruby 2.5's test-unit to 3.2.7

## 0.1.13

### Default Gems

- Move rdoc repo to Ruby organization

## 0.1.12

### Default Gems

- ipaddr is published on rubygems.org

### Bundled Gems

- Update Ruby 2.5's rake to 12.3.0

## 0.1.11

### Default Gems

- Update Ruby 2.5's bundle to 1.16.0
- Update Ruby 2.5's ipaddr to 1.2.0

### Bundled Gems

- Update Ruby 2.5's power_assert to 1.1.1
- Update Ruby 2.5's rake to 12.2.1
- Update Ruby 2.5's test-unit to 3.2.6

## 0.1.10

### Default Gems

- Update Ruby 2.5's openssl to 2.1.0
- Update Ruby 2.5's zlib to 0.1.0
- Update Ruby 2.5's csv to 0.1.0
- Update Ruby 2.5's bundler to 1.15.4

### Bundled Gems

- Update Ruby 2.5's rake to 12.1.0

## 0.1.9

### Default Gems

- Fix that Ruby 2.4.2 bundles openssl v2.0.5 (@pvalena)

## 0.1.8

- Please ignore

## 0.1.7

### Default Gems

- Update versions for Ruby releases: 2.4.2, 2.3.5, 2.2.8
- Fix & improve bundler info

### Bundled Gems

- Fix minitest version for Ruby 2.3.x

## 0.1.6

### Default Gems

- Add bundler
- Update rdoc

### Bundled Gems

- Update openssl and minitest

## 0.1.5

### Default Gems

- Mark ipaddr repository as upstream
- Update OpenSSL version for 2.4 and 2.5
- Current fileutils version is 0.7.2

### Bundled Gems

- 2.5: Bump power_assert version

## 0.1.4

### Default Gems

- 2.5: Add digest
- Fix broken Wikipedia links

## 0.1.3

### Default Gems

- 2.5: Add ipaddr

## 0.1.2

### Default Gems

- New maintainer for webrick
- 2.5: Update openssl, json

### Bundled Gems

- 2.5: Update did_you_mean, minitest, test-unit, xmlrpc

## 0.1.1

### Default Gems

- Add source repository for io-console and stringio

## 0.1.0

- Initial release
