# pdfjam-extras Package('d)

A separately packaged version of the 'wrapper' scripts that previously were distributed as part of the [pdfjam](https://github.com/DavidFirth/pdfjam) package (i.e. in releases of **pdfjam** prior to version 3.02) so that they are easy to install.

**why** ? : these scripts were just _too_ useful for me and used in so many of my other scripts it would have been _(a)_ a huge job to migrate to pure [pdfjam](https://github.com/DavidFirth/pdfjam) commands or _(b)_ really annoying to have to manually install these with every linux upgrade/host/install.

**what** ? : a packaged version of the ``pdf[nup,pun,join,90,180,270,flip,book,pocketmod,slides*up]`` scripts that were originally included (and installed) as part of [pdfjam](https://github.com/DavidFirth/pdfjam).

-- **[RPM download here](https://github.com/tobybreckon/pdfjam-extras/releases/download/v0.1/pdfjam-extras-0.1-0.noarch.rpm)**, **[.deb download here](https://github.com/tobybreckon/pdfjam-extras/releases/download/v0.1/pdfjam-extras_0.1-1_all.deb)**  and manual install instructions below.

These scripts are explicitly **not supported** by the original authors of [pdfjam](https://github.com/DavidFirth/pdfjam) for their [own reasons](https://github.com/DavidFirth/pdfjam-extras). It is indended this repo can become a place for _mild_ support as needed.  They are licensed under the [GPL](COPYING).

**_The wrapper scripts are_:**

- `pdfnup`, `pdfpun`
- `pdfjoin`
- `pdf90`, `pdf180`, `pdf270`
- `pdfflip`
- `pdfbook`
- `pdfjam-pocketmod`
- `pdfjam-slides3up`, `pdfjam-slides6up`

---

### Installing the scripts

The **easy way** (via a pre-packaged RPM, and signed public key):
```
wget https://github.com/tobybreckon/pdfjam-extras/releases/download/v0.1/pdfjam-extras-0.1-0.noarch.rpm
wget -O package-signing-key.pub https://breckon.org/toby/pgp.txt
sudo rpm --import package-signing-key.pub
sudo rpm -i pdfjam-extras-0.1-0.noarch.rpm
```
[following RPM convention this installs the scripts into ``/usr/bin``]

The _other_ **easy way** (via a pre-packaged .deb package):
```
wget https://github.com/tobybreckon/pdfjam-extras/releases/download/v0.1/pdfjam-extras_0.1-1_all.deb
sudo dpkg -i pdfjam-extras_0.1-1_all.deb
```
[following .deb package convention this installs the scripts into ``/usr/bin`` + the .deb file is not digitally signed]


The _slightly_ **harder way** (manually clone and install):
```
git clone git@github.com:tobybreckon/pdfjam-extras.git
cd pdfjam-extras-master
sudo sh ./install.sh
```
[following manual install convention this installs the scripts into ``/usr/local/bin``]

---

### Using the scripts

Below are some excerpts from an old _pdfjam-README_ file (from version 2.09 of the
**pdfjam** package) that are copied here for reference:


- ``pdfnup``, which allows one or more PDF files to be "n-upped" in roughly the way that [``psnup``](https://github.com/rrthomas/psutils) does for PostScript files. (This was the original motivation: for files that have to be printed, or have to be made available to dozens or hundreds of other people for printing, n-up formatting saves trees!)
- ``pdfpun``, similar to ``pdfnup`` but arranges the source pages right-to-left on the output page, ie in a format more suitable for right-to-left languages. This script works only on one file at a time.
- ``pdfjoin``, which combines the pages of multiple PDF files together into a single file.
- ``pdf90``, ``pdf180`` and ``pdf270`` which rotate the pages of one or more PDF files.
- ``pdfflip`` which reflects the pages of one or more PDF files. (Suitable for making transparencies if you want to write on the back of them!)
- ``pdfbook`` which arranges pages into 2-up "signatures" (like [``psnup``](https://github.com/rrthomas/psutils) does for PostScript files), suitable for binding into a book.
- ``pdfjam-pocketmod`` which converts 8 pages from a single PDF file into a pocket-sized booklet (with [folding instructions here](https://pocketmod.com/howto)).
- ``pdfjam-slides6up`` and ``pdfjam-slides3up`` which process PDF presentation slides to six-per-page or three-per-page for handout purposes.

In addition, each of the scripts has a (rather basic) ``man`` page. For example, typing:

```man pdfjam-pocketmod```

at the terminal gives information about usage and other aspects of the ``pdfjam-pocketmod`` script and similarly for each of the other scripts in the set (please, look at these man pages first before asking any questions).

---

### Version history

**pdfjam-extras 0.1**: first packaged version of scripts from **pdfjam 2.09**, functionally unchanged [June 2022].

**pdfjam 2.09**: The default behaviour of ``pdfbook`` is reverted to its pre-2.06 state, because ``--booklet true`` seems to be problematic for some users.&nbsp; [package version never released]

**pdfjam 2.08**: fixed a bug in one of the tests. [2010-11-14]

**pdfjam 2.07**: two other common graphics formats (JPG and PNG) are now explicitly allowed as input files (i.e., not only PDF files are allowed as inputs). [2010-11-13]

**pdfjam 2.06**: changed the ``pdfbook`` script to include ``--booklet true`` as the default behaviour (thanks to Julien Bossert for this good suggestion). [2010-05-11]

**pdfjam 2.05**: changes to the ``pdfbook`` script [the ``--right-edge-binding`` option is now redundant, and there's a new ``--short-edge`` option for binding along the short edge of pages instead of the long edge (thanks to Marco Pessotto for this)]. The ``--preamble`` option to ``pdfjam`` is enhanced, to allow multiple instances which get concatenated. Also various minor corrections to man pages. [2010-04-25]

---

##### Building the packages ...

As as _aide memoir_ to myself, this is how to re-build the RPM:

```
git clone git@github.com:tobybreckon/pdfjam-extras.git
rpmdev-setuptree
ln -s ~/pdfjam-extras/pdfjam-extras.spec ~/rpmbuild/SPECS/
cd ~/rpmbuild/
rpmbuild -bb SPECS/pdfjam-extras.spec
sudo rpmsign --addsign RPMS/noarch/pdfjam-extras-0.1-0.noarch.rpm
rpm --checksig RPMS/noarch/pdfjam-extras-0.1-0.noarch.rpm
```

Either package can also be built using the following script
(from inside the ``pdfjam-extras`` directory):

```
bash ./package.sh rpm
bash ./package.sh deb
```
