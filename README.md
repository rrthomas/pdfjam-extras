# pdfjam-extras

This repository holds a copy of various 'wrapper' scripts that previously
were distributed as part of the [pdfjam](https://github.com/DavidFirth/pdfjam)
package (i.e., in releases of **pdfjam** prior to version 3.02).

These scripts are explicitly **not supported**.  In particular:

- any and all issues reported for these scripts, via GitHub, 
will simply be left open;
- pull requests will not be merged.

--- unless, of course, _someone else_ decides to support the scripts in 
a repository of their own.

I make the scripts available
here just in case someone might find them useful. 

If somebody else wants to
improve and maintain these scripts as a separate package for distribution in
future, then that's fine by me of course! (and it would be warmly welcomed)

Licensed under GPL: see the file
COPYING for details. These scripts are provided with 
**absolutely no warranty of fitness for any purpose whatsoever**.

**_The wrapper scripts are_:**

- `pdfnup`, `pdfpun`
- `pdfjoin`
- `pdf90`, `pdf180`, `pdf270`
- `pdfflip`
- `pdfbook`
- `pdfjam-pocketmod`
- `pdfjam-slides3up`, `pdfjam-slides6up`

They all are intended as _example_ templates of scripts that end-users can make,
in order to apply `pdfjam` conveniently on their specific tasks.

I now cannot support these 'wrapper' scripts as part of the **pdfjam** 
package --- mainly because what people want from them seems to vary so much.  This
results in quite a lot of questions and bug reports or feature requests, which
most often I don't know how to handle.  I don't actually use most of
these wrapper scripts myself --- I typically prefer to construct a suitable call to
`pdfjam` directly. 

(An exception to that is that I _do_ often use
`pdfjam-slides3up` and `pdfjam-slides6up`; but even there I have very specific 
personal requirements, for example 4:3-shaped slides on A4 paper.)

The `pdfjam` script itself and its associated documentation are still
supported by me --- for the foreseeable future.

_David Firth_, November 2019

-------------------------------------------------------------------

Below are some excerpts from an old _pdfjam-README_ file (from version 2.09 of the
**pdfjam** package).  These excerpts refer specifically to the wrapper scripts,
and they are copied here just in case it helps someone. 


<b>(snip)</b>

<ul>
  <li> <b><tt>pdfnup</tt></b>, which allows one or more PDF files to be "n-upped" in roughly the way that <a href="https://github.com/rrthomas/psutils"><tt>psnup</tt></a> does for PostScript files. (This was the original motivation: for files that have to be printed, or have to be made available to dozens or hundreds of other people for printing, n-up formatting saves trees!)</li>
  <li><b><tt>pdfpun</tt></b>, similar to <tt>pdfnup</tt> but arranges the source pages right-to-left on the output page, ie in a format more suitable for right-to-left languages. This script works only on one file at a time. (Thanks to Ido for suggesting this.)</li>
  <li> <b><tt>pdfjoin</tt></b>, which combines the pages of multiple PDF files together into a single file.</li>
  <li> <b><tt>pdf90</tt></b>, <b><tt>pdf180</tt></b> and <b><tt>pdf270</tt></b> which rotate the pages of one or more PDF files.</li>
  <li><b><tt>pdfflip</tt></b> which reflects the pages of one or more PDF files. (Suitable for making transparencies if you want to write on the back of them!)</li>
  <li><b><tt>pdfbook</tt></b> which arranges pages into 2-up "signatures" (like <a href="https://github.com/rrthomas/psutils"><tt>psbook</tt></a> does for PostScript files), suitable for binding into a book. (Many people have suggested that this would be useful — I hope it is!)</li>
  <li><b><tt>pdfjam-pocketmod</tt></b> which converts 8 pages from a single PDF file into a pocket-sized booklet. (<a href="https://pocketmod.com/howto">Folding instructions here!</a> Thanks to Thomas Nemeth for suggesting this.)</li>
  <li><b><tt>pdfjam-slides6up</tt></b> and <b><tt>pdfjam-slides3up</tt></b> which process PDF presentation slides to six-per-page or three-per-page for handout purposes. </li>
</ul>

<b>(snip)</b>

<p>In addition, each of the scripts has a (rather basic) <tt>man</tt> page. For example,</p>

<pre>  man pdfjam-pocketmod<br></pre>
<p>gives information about usage and other aspects of the <tt>pdfjam-pocketmod</tt> script.</p>

<b>(snip)</b>

<h2 align="justify">Using the scripts</h2>

<b>(snip)</b>

<h3 align="justify">Example 1</h3>

<p>Consider converting each of two documents to a side-by-side "2-up" format. Since we want the two documents to be processed separately, we'll use the <tt>--batch</tt> option: </p>

<pre>  pdfjam --batch --nup 2x1 --suffix 2up --landscape \<br>         --outfile . file1.pdf file2.pdf<br></pre>
<p> This will produce new files <tt>file1-2up.pdf</tt> and <tt>file2-2up.pdf</tt> in the current working directory. The above call could be shortened a bit, by using <tt>pdfnup</tt>, to</p>

<pre>  pdfnup --batch --suffix 2up file1.pdf file2.pdf<br></pre>
<p> In a 'vanilla' installation of <tt>pdfjam</tt>, the default for <tt>--outfile</tt> is the current working directory.</p>

<b>(snip)</b>

<h3 align="justify">Example 5</h3>

<p>A useful application of <tt>pdfjam</tt> is for producing a handout from a file of presentation slides. For slides made with the standard 4:3 aspect ratio a nice 6-up handout on A4 paper can be made by </p>

<pre>  pdfjam --nup 2x3 --frame true --noautoscale false \<br>         --delta "0.2cm 0.3cm" --scale 0.95 myslides.pdf \<br>         --outfile myhandout.pdf<br></pre>
<p>The <tt>--delta</tt> option here comes from the pdfpages package; the <tt>--scale</tt> option is passed to LaTeX's <tt>\includegraphics</tt> command. </p>

<p>The two wrapper scripts <tt>pdfjam-slides6up</tt> and <tt>pdfjam-slides3up</tt> are provided in order to make this particular application of <tt>pdfjam</tt> easy: for example, </p>

<pre>  pdfjam-slides3up --pagenumbering true --batch \<br>         slides1.pdf slides2.pdf<br></pre>
<p>makes a pair of 3-up handouts <tt>slides1-3up.pdf</tt> and <tt>slides2-3up.pdf</tt>, with space for side-notes and with the handout pages numbered.</p>

<p>(Slides made by LaTeX's <i>beamer</i> package, using the <tt>handout</tt> class option, work especially nicely with this!)</p>

<h3 align="justify">Example 6</h3>

<p> Suppose we want to trim the pages of our input file prior to n-upping. This can be done by using a pipe: </p>

<pre>  pdfjam myfile.pdf --trim '1cm 2cm 1cm 2cm' --clip true \<br>         --outfile /dev/stdout | \<br>      pdfnup --frame true --outfile myoutput.pdf<br></pre>
<p>The <tt>--trim</tt> option specifies an amount to trim from the left, bottom, right and top sides respectively; to work as intended here it needs also <tt>--clip true</tt>. These (i.e., <tt>trim</tt> and <tt>clip</tt>) are in fact options to LaTeX's <tt>\includegraphics</tt> command (in the standard <i>graphics</i> package).</p>

<p>(Thanks to Christophe Lange and Christian Lohmaier for suggesting an example on this.)</p>


<b>(snip)</b>


<h2 align="justify">Version history</h2>

<p> <b>2.09</b>: The default behaviour of <tt>pdfbook</tt> is reverted to its pre-2.06 state, because <tt>--booklet true</tt> seems to be problematic for some users.&nbsp; [package version never released]
</p>

<p><b>2.08</b>: fixed a bug in one of the tests. [2010-11-14] </p>

<p> <b>2.07</b>: two other common graphics formats (JPG and PNG) are now explicitly allowed as input files (i.e., not only PDF files are allowed as inputs). [2010-11-13] </p>

<p><b>2.06</b>: changed the <tt>pdfbook</tt> script to include <tt>--booklet true</tt> as the default behaviour (thanks to Julien Bossert for this good suggestion). [2010-05-11] </p>

<p> <b>2.05</b>: changes to the <tt>pdfbook</tt> script [the <tt>--right-edge-binding</tt> option is now redundant, and there's a new <tt>--short-edge</tt> option for binding along the short edge of pages instead of the long edge (thanks to Marco Pessotto for this)]. The <tt>--preamble</tt> option to <tt>pdfjam</tt> is enhanced, to allow multiple instances which get concatenated. Also various minor corrections to man pages. [2010-04-25] </p>

**(snip)**
