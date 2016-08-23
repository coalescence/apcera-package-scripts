Verification
============

While the checksums included in the conf files provide verification of no
mutation between the time that Apcera Engineering saw a file and the time that
it is seen by a Stager building a package in Continuum, those checksums do not
in themselves verify that source was not already compromised by the time that
Apcera Engineering first viewed the file.

Unfortunately, it's uncommon for releases to be signed by PGP keys in the
strong set, with decent end-to-end assurances.  So this file records some
observances which at least let us provide for continuity and a degree of
implicit trust in a particular signing setup when a key is seen used across
multiple releases, so we at least can spot if something has _changed_.  If we
see one PGP key used for multiple years, with no cries of outrage, then that
particular key is probably legitimate.

If upstream use something as compromised as MD5, we can't do much about that,
except note it.

This file is stored in Git, which has a degree of backwards trust chaining, so
modifications to history and the contents of this file should result in
conflicts which are visible to every engineer who has this repository checked
out.

In an ideal world, we wouldn't have to rely upon software we can't
meaningfully or reasonably verify, but we're packaging up existing systems,
used by others, and the dependencies of those systems, so we don't get to
choose the software and apply market forces by selecting only software which
meets our criteria.

Note: tools exist to create PGP keys repeatedly until a chosen 8-char value is
made, so attackers can target the ‘short’ form PGP keyids (32-bits of
entropy).  Please use the 16-character form, or the key fingerprint, in this
document.


Apache
------

Release site is at <https://httpd.apache.org/download.cgi>. The site includes
the PGP signature, as well as MD5 and SHA1 hashes. The Apache Server verification
guide is at <https://httpd.apache.org/dev/verification.html> which includes
details on how to verify the PGP key used to sign the downloads.


FreeType
--------

<http://www.freetype.org/download.html> references
<http://download.savannah.gnu.org/releases/freetype/>.  Releases and detached
signatures are available there.

Signatures observed (as of 2.5.2) were with keyid 0xC1A60EACE707FDA5 which has
(very stale) signatures from 0x9710B89BCA57AD7C, the “PGP Global Directory
Verification Key”.  That service issues two-week signatures upon key
retrieval, but no longer has that key, or any other for <wl@gnu.org>.  The
last such signature dates from 2005.  So this ten-year-old 1024-bit key has
only signatures from an address verification robo-signer, eight years ago.

Same 0xC1A60EACE707FDA5 key observed for 2.5.3 release on 2014-03-09.


LibJPG
------

Release site at <http://www.ijg.org/>; HTTPS unrelated (accesses site-builder
default install setup).  Older releases also in index at
<http://www.ijg.org/files/>.  No fingerprints, no signatures.  Nada.

Using the older releases in index, we can pull back "latest" and "last one in
a package .conf" and if the latter verifies, hope that an attacker is
restricting themselves to only trojanning the latest.


LibPNG
------

Releases indexed at <http://www.libpng.org/pub/png/libpng.html>.  No HTTPS.
As of 1.6.10, I found detached PGP signatures, not observed as of 1.6.8.
MD5 checksums found in the web-page.
The SourceForge git repo is a sequence of imports from the release tarballs.

Can't spot an OS bundling newer than 1.5.x.

As of 2014-03-06 (1.6.10), the PGP signatures verify, but the key used has no
third-party signatures upon it.  At this time, the key observed is
`0xF54984BFA16C640F`, self-purporting to belong to `Glenn Randers-Pehrson
(libpng) <glennrp@users.sourceforge.net>`.
`Primary key fingerprint: 8048 643B A2C8 40F4 F92A  195F F549 84BF A16C 640F`

Previous summary, still somewhat relevant:
no meaningful verification is possible without a source audit and
ongoing delta audits.  It seems the general open source community is using
Ongoing Repeated Leaps Of Faith around libpng.


Linux Test Project
------------------

Linux Test Project is a joint project started by SGI, OSDL and Bull developed
and maintained by IBM, Cisco, Fujitsu, SUSE, Red Hat, Oracle and others. The
project goal is to deliver tests to the open source community that validate the
reliability, robustness, and stability of Linux.

The LTP testsuite contains a collection of tools for testing the Linux kernel
and related features. Our goal is to improve the Linux kernel and system
libraries by bringing test automation to the testing effort. Interested open
source contributors are encouraged to join.

We use the locktest program from this package to test fcntl file locks on SMB
file systems.

Overview of the tests in this package: https://github.com/linux-test-project/ltp/tree/20160510

fcntl locking tests: https://github.com/linux-test-project/ltp/tree/20160510/testcases/network/nfsv4/locks

The SHA256 signature for the `20160510.zip` zip file is
ee9974dcd7b0f36aafc952f6ce647aeb26153891051498897db0a0a70460c853, verified by Earl Ruby
on 2016-06-28. 

The locktest code does not need root privileges to run, so a test runner user can
run the locktest.


MYSQL
-----

Software releases are indexed at <https://dev.mysql.com/downloads/mysql/>.
select 'source code' from 'Select Platform' and find 'Generic Linux 
(Architecture Independent), Compressed TAR Archive'.

For verification they provide both a Signature(GPG) and MD5 checksums.

https://dev.mysql.com/doc/refman/5.6/en/checking-gpg-signature.html


Node.JS
-------

Releases are indexed at <http://nodejs.org/dist/>. No HTTPS is available. The
releases include a file listing all of the SHAs for the release files, available
with either SHA1s or SHA256s. They also provide a GPG signature to verify the
list of SHAs.

The signature used on the list of SHAs is not specifically documented on the
Node.JS site. The observed releases lately are all signed by the same person.

As of 2014-02-04, the signature uses the key `0246406D`, which is attributed to
`Timothy J Fontaine (Personal) <tjfontaine@gmail.com>`.


OCaml
-----

Releases are indexed at <http://ocaml.org/releases/>.  No HTTPS is available
(nothing listening on port).  No signatures, no checksums given in
public-facing documentation that I found.  However, the directory where the
actual tarballs are retrieved from has an `MD5SUM` file.

So <http://caml.inria.fr/pub/distrib/ocaml-4.00/>, or `ocaml-4.01/`.
(Attempts to use HTTPS hang).

ovftool
----

VMware's ovf tool is downloaded from https://www.vmware.com/support/developer/ovf/
VMware provides a page which contains checksums. The file must be located in the
same directory as the package script prior to running the package build.

Perl
----

Perl releases are located at: http://www.cpan.org/src/5.0/ and include a md5.txt,
sha1.txt and sha256.txt file that we use to validate all downloads. Unfortunately
they do not provide the downloads over https or we would use that download
location.


PHP
---

Software releases are indexed at <http://www.php.net/downloads.php>, HTTPS not
available.  There are different PGP keys used for each major.minor release
series; each release has a detached signature, and there's an MD5 signature on
the release-page.

As of 2013-12-15, the keys observed were:

 * `PHP 5.5.7:  0xFE857D9A90D90EC1`  (reconfirmed 2014-03-06 with 5.5.10)
 * `PHP 5.4.23: 0x2F7956BC5DA04B5D`  (reconfirmed 2014-03-07 with 5.4.26)

Neither key is in the strong set, I (Phil) have no trust path to them.  The
detached signatures validated, and the MD5 checksums of the files signed
matched those given on the unencrypted release page.


POSTGRES
---

Software releases are indexed at <http://www.postgresql.org/ftp/source/>, HTTPS not
available for the software list, but actual downloads are done with HTTPS. For
verification they provide both SHA256 and MD5 checksums.


Python
------

Software releases are are indexed at <http://www.python.org/download/releases/>,
HTTPS not available. There are different PGP keys used for each major.minor
release. Each release has a detached signature, linked to from the download
package. A list of MD5 checksums are provided on the download page as well.

PGP signing key version history:

| Software   | PGP Key            | Key Owner (purported) | First Version+Date | Latest Confirmation | Notes |
|------------|-------------------:|:----------------------|:-------------------|:--------------------|-------|
| Python 2.7 | 0x04C367C218ADD4FF | Benjamin Peterson | 2.7.6 2014-02-04  | - | |
| Python 3.3 | 0x0A5B101836580288 | Georg Brandl      | 3.3.3 2014-02-04  | 3.3.5 2014-03-10 | |
| Python 3.4 | 0x3A5CA953F73C700D | Larry Hastings    | 3.4.0 2014-03-17  | - | |
| VirtualEnv | 0x6E3CBCE93372DCFA | Donald Stufft     | 1.11.4 2014-03-17 | - | |
| Pip        | 0x6E3CBCE93372DCFA | Donald Stufft     | 1.5.4 2014-03-17  | - | |

Rsync
----
HTTPS based release index: <https://www.samba.org/ftp/rsync/src/>
As of release `rsync-2.6.2` (2004-06-16), PGP Signatures are provided.
First PGP signed and current releases are signed with the same key.

| PGP Key            | Key Owner (purported) | First Version+Date | Latest Confirmation | Notes |
|-------------------:|:----------------------|:-------------------|:--------------------|-------|
| 0x6C859FB14B96A8C5 | Wayne Davison         | rsync-2.6.2 2004-06-16 | 3.1.1 2014-06-22 | |

Checksums are not availble in the release index. Ben Werthmann has verified version 3.3.1 and generated
a sha256 checksum for the package script. The signing key is not in the stong set. There are a few
signatures from a few years ago, one of which appears to be another key belonging to Wayne. <http://pgp.surfnet.nl:11371/pks/lookup?op=vindex&fingerprint=on&search=0xADB8A2B829C67D63>

Phil Pennock has a full trust path to key 0x6C859FB14B96A8C5 for the uid Wayne Davison <wayned@samba.org>;
Phil has signed Marc Merlin's key 0x7E3150A6763BE901 which has signed 0x3C63CA3FA0B3E88B which has
signed Martin Pool's key 0x3C63CA3FA0B3E88B which signed Wayne's key. Based on this, we have strong cause
to believe that a key owned by Wayne Davison (whoever that is) was used to sign the release, and since the
verified trust path is to an @samba.org email address, we can (more or less) assume that he's authorized
to generate rsync releases based on the assumption that someone would asserted concern years ago.

Ruby
----

Releases are indexed at <https://www.ruby-lang.org/en/downloads/>. HTTPS is
available and is the default. No cryptographic signatures are provided. MD5
checksums are provided on the downloads page. The checksums are not stored with
the release, so only the MD5s for the latest release of the supported versions
are available.


Spark
-----

Spark 1.6.1 source code was downloaded from http://apache.mirror.anlx.net/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz
on 2016-06-29 by Earl Ruby. The MD5 sum of spark-1.6.1-bin-hadoop2.6.tgz = 667a62d7f289479a19da4b563e7151d4,
which matches the value shown at http://www.apache.org/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz.md5.
SHA256 of 09f3b50676abc9b3d1895773d18976953ee76945afa72fa57e6473ce4e215970 was computed by Earl Ruby, who uploaded the
file from Apache.org into the Apcera S3 bucket https://apcera-sources.s3.amazonaws.com/spark/spark-1.6.1-bin-hadoop2.6.tgz.

Spark 2.0.0 source code was downloaded from http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0-bin-hadoop2.6.tgz
on 2016-08-08 by Earl Ruby. The MD5 sum of spark-2.0.0-bin-hadoop2.6.tgz = 6d9cac116f3434330869dedb6c5fe9ca,
which matches the value shown at http://www.apache.org/dist/spark/spark-2.0.0/spark-2.0.0-bin-hadoop2.6.tgz.md5.
SHA256 of e17d9da4b3ac463ea3ce42289f2a71cefb479d154b1ffd00310c7d7ab207aa2c was computed by Earl Ruby, who uploaded the
file from Apache.org into the Apcera S3 bucket https://apcera-sources.s3.amazonaws.com/spark/spark-2.0.0-bin-hadoop2.6.tgz.

For an example of using the Spark package on the Apcera Platform, see https://www.apcera.com/blog/apache-spark-apcera-platform-community-edition.

ZSH
---

Current version listed at <http://zsh.sourceforge.net/Arc/source.html> and
announced at <zsh-announce@zsh.org>.  MD5 checksums are available at
<http://www.zsh.org/pub/MD5SUM> but that is auto-updated on upload, rather
than being generated by the person packaging (and is unsigned).

Source is available via git, does have annotated (but not signed)
tags for releases.  It is possible, but not necessary, to perform a more
thorough verification thusly:

Have yodl installed, which requires icmake.  Give up at this point unless
determined (yes, it really is bad).

Checkout the release tag, then invoke the release script, normalizing the
locale (see below), which should produce a tarball which you can extract and
compare against the contents from the release tarball. Junk the documentation
and FAQ (`Doc/` & `Etc/FAQ`) as results vary by version of `yodl`; at this
point a `diff -qr` should show that the only files possibly still differing
are `config.h.in` and `configure`, as a result of automake variances.

```console
% git clean -fx .
% ./.preconfig
% ( export LC_ALL=C; ./configure && make targz-src )
```

If in doubt, ask Phil, who can chase on the dev mailing-list; his git repo has
the reference points below, confirmed against the release tarballs with the
above steps.  This should provide a baseline for future comparisons: if these
commits are not in your git history, be wary.

* 5.0.5 git sha `79abe00e1d73b3f0681343a70e3e7f84e5e3d647`
* 5.0.7 git sha `208bdede3e812ea9e28937034fdbfdf1d7549fed`

#EOF
