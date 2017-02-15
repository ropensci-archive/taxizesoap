taxizesoap
==========



[![Build Status](https://api.travis-ci.org/ropensci/taxizesoap.png?branch=master)](https://travis-ci.org/ropensci/taxizesoap)
[![codecov.io](https://codecov.io/github/ropensci/taxizesoap/coverage.svg?branch=master)](https://codecov.io/github/ropensci/taxizesoap?branch=master)

__UPDATE__: WORMS data source is in the development version of `taxize` - and will be on CRAN soon - so for WORMS you can use `taxize` - but for PESI and Mycobank continue to use this package.

`taxizesoap` is an extension to [taxize](https://github.com/ropensci/taxize), but for data sources that use SOAP data transfer protocol, which is hard to support in R. This package won't go on CRAN.

Most functions in this package are different from those in `taxize`, but there are some of the same (e.g,. `classification()`). In this package, where a function is named the same as in `taxize`, I've added a `_s` at the end of the function representing the version of that function in the `taxizesoap` package. This is to avoid confounding effects when both packages are loaded at the same time.

### Currently implemented in `taxizesoap`

<table>
<colgroup>
<col style="text-align:left;"/>
<col style="text-align:left;"/>
<col style="text-align:left;"/>
<col style="text-align:left;"/>
</colgroup>

<thead>
<tr>
  <th style="text-align:left;">Souce</th>
	<th style="text-align:left;">Function prefix</th>
	<th style="text-align:left;">API Docs</th>
	<th style="text-align:left;">API key</th>
</tr>
</thead>

<tbody>
<tr>
	<td style="text-align:left;">World Register of Marine Species (WoRMS)</td>
	<td style="text-align:left;"><code>worms</code></td>
	<td style="text-align:left;"><a href="http://www.marinespecies.org/aphia.php?p=webservice">link</a></td>
	<td style="text-align:left;">none</td>
</tr>
<tr>
	<td style="text-align:left;">Pan-European Species directories Infrastructure (PESI)</td>
	<td style="text-align:left;"><code>pesi</code></td>
	<td style="text-align:left;"><a href="http://www.eu-nomen.eu/portal/webservices.php">link</a></td>
	<td style="text-align:left;">none</td>
</tr>
<tr>
	<td style="text-align:left;">Mycobank</td>
	<td style="text-align:left;"><code>myco</code></td>
	<td style="text-align:left;"><a href="http://www.mycobank.org/Services/Generic/Help.aspx?s=searchservice">link</a></td>
	<td style="text-align:left;">none</td>
</tr>
</tbody>
</table>

**Note:** Euro+Med is available through PESI.

## R versions

We previously had problems with this package, where [it didn't work on R > 3.2](https://github.com/ropensci/taxizesoap/issues/4#issuecomment-218175649). But now
those problems seem to have been solved. let us know if you run into any more problems.

## Install taxizesoap


```r
devtools::install_github("ropensci/taxizesoap")
```

That should install two dependencies not on CRAN (`XMLSchema`, `SSOAP`). If they aren't installed
correctly for you, try installing from our Drat repo.


```r
install.packages(c("XMLSchema", "SSOAP"), repos = c("http://packages.ropensci.org", "http://cran.rstudio.com"))
```

If that doesn't work, try insatlling from GitHub:


```r
install.packages("devtools")
devtools::install_github("omegahat/XMLSchema")
devtools::install_github("sckott/SSOAP")
```

Load the package


```r
library('taxizesoap')
```

### Get taxonomic ids

PESI


```r
get_pesiid(searchterm = "Salvelinus")
#> [1] "urn:lsid:marinespecies.org:taxname:126142"
#> attr(,"match")
#> [1] "found"
#> attr(,"uri")
#> [1] "http://www.eu-nomen.eu/portal/taxon.php?GUID=urn:lsid:marinespecies.org:taxname:126142"
#> attr(,"class")
#> [1] "pesiid"
```

Worms


```r
get_wormsid(searchterm = "Salvelinus fontinalis")
#> [1] "154241"
#> attr(,"match")
#> [1] "found"
#> attr(,"uri")
#> [1] "http://www.marinespecies.org/aphia.php?p=taxdetails&id=154241"
#> attr(,"class")
#> [1] "wormsid"
```

### Use taxonomic ids for more

Get taxonomic classification


```r
classification_s(get_wormsid("Salvelinus fontinalis"))
#> $`154241`
#>                     name       rank
#> 1               Animalia    Kingdom
#> 2               Chordata     Phylum
#> 3             Vertebrata  Subphylum
#> 4          Gnathostomata Superclass
#> 5                 Pisces Superclass
#> 6            Actinopteri      Class
#> 7          Salmoniformes      Order
#> 8             Salmonidae     Family
#> 9             Salmoninae  Subfamily
#> 10            Salvelinus      Genus
#> 11 Salvelinus fontinalis    Species
#>
#> attr(,"class")
#> [1] "classification_s"
```

### WORMS

Get name from a WORMS id


```r
worms_name(ids=1080)
#> [1] "Copepoda"
```

Common names from WoRMS ID


```r
worms_common(ids=c(1080,22388,160281,123080,22388))
#>    inputid       vernacular language_code                    language
#> 1     1080         copepods           eng                     English
#> 2     1080      hoppkräftor           swe                     Swedish
#> 3     1080 roeipootkreeften           dut                       Dutch
#> 4    22388        barnacles           eng                     English
#> 5   160281       dierluizen           dut                       Dutch
#> 6   160281         djurlöss           swe                     Swedish
#> 7   160281             lice           eng                     English
#> 8   160281    phthiraptères           fra                      French
#> 9   160281        Tierläuse           deu                      German
#> 10  123080         astéries           fra                      French
#> 11  123080  estrella de mar           spa                     Spanish
#> 12  123080   étoiles de mer           fra                      French
#> 13  123080  hitode (ヒトデ)           jpn                    Japanese
#> 14  123080        sea stars           eng                     English
#> 15  123080        Seesterne           deu                      German
#> 16  123080      sjöstjärnor           swe                     Swedish
#> 17  123080         starfish           eng                     English
#> 18  123080   tapak sulaiman           zlm Malay (individual language)
#> 19  123080       zeesterren           dut                       Dutch
#> 20  123080         불가사리           kor                      Korean
#> 21   22388        barnacles           eng                     English
```

Get records by ID, scientific name, common name, date, worms id, or external id.


```r
head( worms_records(scientific=c('Salmo','Aphanius')) )
#>   inputid AphiaID
#> 1   Salmo  126141
#> 2   Salmo  154470
#> 3   Salmo  154471
#> 4   Salmo  712455
#> 5   Salmo  305943
#> 6   Salmo  305944
#>                                                             url
#> 1 http://www.marinespecies.org/aphia.php?p=taxdetails&id=126141
#> 2 http://www.marinespecies.org/aphia.php?p=taxdetails&id=154470
#> 3 http://www.marinespecies.org/aphia.php?p=taxdetails&id=154471
#> 4 http://www.marinespecies.org/aphia.php?p=taxdetails&id=712455
#> 5 http://www.marinespecies.org/aphia.php?p=taxdetails&id=305943
#> 6 http://www.marinespecies.org/aphia.php?p=taxdetails&id=305944
#>              scientificname        authority     rank
#> 1                     Salmo   Linnaeus, 1758    Genus
#> 2           Salmo (Osmerus)   Linnaeus, 1758 Subgenus
#> 3 Salmo (Osmerus) eperlanus (Linnaeus, 1758)  Species
#> 4           Salmo abanticus  Tortonese, 1954  Species
#> 5              Salmo albula   Linnaeus, 1758  Species
#> 6               Salmo albus Bonnaterre, 1788  Species
#>                     status unacceptreason valid_AphiaID
#> 1                 accepted           <NA>        126141
#> 2                 accepted           <NA>        154470
#> 3 alternate representation        synonym        154774
#> 4                 accepted           <NA>        712455
#> 5               unaccepted           <NA>        127178
#> 6               unaccepted           <NA>        223866
#>            valid_name  valid_authority  kingdom   phylum       class
#> 1               Salmo   Linnaeus, 1758 Animalia Chordata Actinopteri
#> 2     Salmo (Osmerus)   Linnaeus, 1758 Animalia Chordata Actinopteri
#> 3     Salmo eperlanus   Linnaeus, 1758 Animalia Chordata Actinopteri
#> 4     Salmo abanticus  Tortonese, 1954 Animalia Chordata Actinopteri
#> 5    Coregonus albula (Linnaeus, 1758) Animalia Chordata Actinopteri
#> 6 Salmo trutta trutta   Linnaeus, 1758 Animalia Chordata Actinopteri
#>           order     family genus
#> 1 Salmoniformes Salmonidae Salmo
#> 2 Salmoniformes Salmonidae Salmo
#> 3 Salmoniformes Salmonidae Salmo
#> 4 Salmoniformes Salmonidae Salmo
#> 5 Salmoniformes Salmonidae Salmo
#> 6 Salmoniformes Salmonidae Salmo
#>                                                                                                                                                                                                                                        citation
#> 1                          Bailly, N. (2014). Salmo. In: Froese, R. and D. Pauly. Editors. (2016). FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=126141 on 2016-09-29
#> 2                          WoRMS (2015). Salmo (Osmerus). In: Froese, R. and D. Pauly. Editors. (2015) FishBase. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=154470 on 2016-09-29
#> 3                                                                  Bailly, N. (2015). Salmo (Osmerus) eperlanus. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=154471 on 2016-09-29
#> 4 Bailly, N. (2015). Salmo abanticus Tortonese, 1954. In: Froese, R. and D. Pauly. Editors. (2015) FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=712455 on 2016-09-29
#> 5     Bailly, N. (2015). Salmo albula Linnaeus, 1758. In: Froese, R. and D. Pauly. Editors. (2015) FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=305943 on 2016-09-29
#> 6    Bailly, N. (2015). Salmo albus Bonnaterre, 1788. In: Froese, R. and D. Pauly. Editors. (2015) FishBase. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=305944 on 2016-09-29
#>                                        lsid isMarine isBrackish
#> 1 urn:lsid:marinespecies.org:taxname:126141        1          0
#> 2 urn:lsid:marinespecies.org:taxname:154470     <NA>       <NA>
#> 3 urn:lsid:marinespecies.org:taxname:154471        1          1
#> 4 urn:lsid:marinespecies.org:taxname:712455        1          1
#> 5 urn:lsid:marinespecies.org:taxname:305943        1          1
#> 6 urn:lsid:marinespecies.org:taxname:305944        1          1
#>   isFreshwater isTerrestrial isExtinct match_type             modified
#> 1            0          <NA>      <NA>       like 2014-11-21T14:09:38Z
#> 2         <NA>          <NA>      <NA>       like 2005-04-18T10:19:09Z
#> 3            1             0      <NA>       like 2013-03-22T14:42:51Z
#> 4            1          <NA>      <NA>       like 2012-12-21T13:57:20Z
#> 5            1          <NA>      <NA>       like 2008-02-28T14:41:08Z
#> 6            1             0      <NA>       like 2013-01-08T15:50:09Z
```

Get sources/references by ID


```r
worms_sources(ids=1080)
#>   inputid source_id                  use
#> 1    1080        40      basis of record
#> 2    1080       503 original description
#>                                                                                                                                                                                                       reference
#> 1                                                                                       Brusca, R.C.; Brusca, G.J. (1990). Invertebrates. Sinauer Associates: Sunderland, MA (USA). ISBN 0-87893-098-1. 922 pp.
#> 2 Milne Edwards, H. (1840). Ordre des Copepodes. In: Histoire naturelle des Crustaces, comprenant l'anatomie, la physiologie et la classification de ces animaux. Par M. Milne Edwards. 3: 411-529, pls. 37-40.
#>   page                                                           url link
#> 1       http://www.marinespecies.org/aphia.php?p=sourcedetails&id=40
#> 2      http://www.marinespecies.org/aphia.php?p=sourcedetails&id=503
#>   fulltext
#> 1
#> 2
```

Children search of WoRMS data.


```r
head( worms_children(ids=106135) )
#> $`106135`
#>    inputid AphiaID
#> 1   106135  733743
#> 2   106135  106242
#> 3   106135  883119
#> 4   106135  733262
#> 5   106135  733744
#> 6   106135  733263
#> 7   106135  733264
#> 8   106135  733265
#> 9   106135  733745
#> 10  106135  733746
#> 11  106135  733266
#> 12  106135  733267
#> 13  106135  733747
#> 14  106135  733268
#> 15  106135  733269
#> 16  106135  733748
#> 17  106135  733270
#> 18  106135  733271
#> 19  106135  733272
#> 20  106135  733273
#> 21  106135  733274
#> 22  106135  535189
#>                                                              url
#> 1  http://www.marinespecies.org/aphia.php?p=taxdetails&id=733743
#> 2  http://www.marinespecies.org/aphia.php?p=taxdetails&id=106242
#> 3  http://www.marinespecies.org/aphia.php?p=taxdetails&id=883119
#> 4  http://www.marinespecies.org/aphia.php?p=taxdetails&id=733262
#> 5  http://www.marinespecies.org/aphia.php?p=taxdetails&id=733744
#> 6  http://www.marinespecies.org/aphia.php?p=taxdetails&id=733263
#> 7  http://www.marinespecies.org/aphia.php?p=taxdetails&id=733264
#> 8  http://www.marinespecies.org/aphia.php?p=taxdetails&id=733265
#> 9  http://www.marinespecies.org/aphia.php?p=taxdetails&id=733745
#> 10 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733746
#> 11 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733266
#> 12 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733267
#> 13 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733747
#> 14 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733268
#> 15 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733269
#> 16 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733748
#> 17 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733270
#> 18 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733271
#> 19 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733272
#> 20 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733273
#> 21 http://www.marinespecies.org/aphia.php?p=taxdetails&id=733274
#> 22 http://www.marinespecies.org/aphia.php?p=taxdetails&id=535189
#>             scientificname             authority    rank     status
#> 1        Hexelasma alearum            Hoek, 1913 Species unaccepted
#> 2     Hexelasma americanum         Pilsbry, 1916 Species   accepted
#> 3    Hexelasma antarcticum      Borradaile, 1916 Species   accepted
#> 4       Hexelasma arafurae            Hoek, 1913 Species   accepted
#> 5   Hexelasma aucklandicum        (Hector, 1888) Species unaccepted
#> 6       Hexelasma aureolum           Jones, 2000 Species   accepted
#> 7       Hexelasma brintoni (Newman & Ross, 1971) Species   accepted
#> 8  Hexelasma callistoderma         Pilsbry, 1911 Species   accepted
#> 9   Hexelasma corolliforme          (Hoek, 1883) Species unaccepted
#> 10     Hexelasma ecaudatum          (Hiro, 1939) Species unaccepted
#> 11      Hexelasma flavidum           Jones, 2000 Species   accepted
#> 12       Hexelasma foratum           Jones, 2000 Species   accepted
#> 13       Hexelasma fosteri   Newman & Ross, 1971 Species unaccepted
#> 14      Hexelasma globosum           Jones, 2000 Species   accepted
#> 15      Hexelasma gracilis          Foster, 1981 Species   accepted
#> 16      Hexelasma hirsutum          (Hoek, 1883) Species unaccepted
#> 17    Hexelasma leptoderma (Newman & Ross, 1971) Species   accepted
#> 18      Hexelasma nolearia          Foster, 1978 Species   accepted
#> 19      Hexelasma persicum           Jones, 2000 Species   accepted
#> 20    Hexelasma sandaracum           Jones, 2000 Species   accepted
#> 21      Hexelasma triderma (Newman & Ross, 1971) Species   accepted
#> 22     Hexelasma velutinum            Hoek, 1913 Species   accepted
#>                                 unacceptreason valid_AphiaID
#> 1                         generic reassignment        292966
#> 2                                         <NA>        106242
#> 3                                         <NA>        883119
#> 4                                         <NA>        733262
#> 5  transferred to Bathylasma (see Jones, 2000)        733253
#> 6                                         <NA>        733263
#> 7                                         <NA>        733264
#> 8                                         <NA>        733265
#> 9  transferred to Bathylasma (see Jones, 2000)        173667
#> 10                                     synonym        733244
#> 11                                        <NA>        733266
#> 12                                        <NA>        733267
#> 13    transferred to Mesolasma by Foster, 1981        733255
#> 14                                        <NA>        733268
#> 15                                        <NA>        733269
#> 16 transferred to Bathylasma (see Jones, 2000)        106241
#> 17                                        <NA>        733270
#> 18                                        <NA>        733271
#> 19                                        <NA>        733272
#> 20                                        <NA>        733273
#> 21                                        <NA>        733274
#> 22                                        <NA>        535189
#>                 valid_name       valid_authority  kingdom     phylum class
#> 1       Bathylasma alearum        (Foster, 1978) Animalia Arthropoda  <NA>
#> 2     Hexelasma americanum         Pilsbry, 1916 Animalia Arthropoda  <NA>
#> 3    Hexelasma antarcticum      Borradaile, 1916 Animalia Arthropoda  <NA>
#> 4       Hexelasma arafurae            Hoek, 1913 Animalia Arthropoda  <NA>
#> 5  Bathylasma aucklandicum        (Hector, 1887) Animalia Arthropoda  <NA>
#> 6       Hexelasma aureolum           Jones, 2000 Animalia Arthropoda  <NA>
#> 7       Hexelasma brintoni (Newman & Ross, 1971) Animalia Arthropoda  <NA>
#> 8  Hexelasma callistoderma         Pilsbry, 1911 Animalia Arthropoda  <NA>
#> 9  Bathylasma corolliforme          (Hoek, 1883) Animalia Arthropoda  <NA>
#> 10    Pachylasma ecaudatum            Hiro, 1939 Animalia Arthropoda  <NA>
#> 11      Hexelasma flavidum           Jones, 2000 Animalia Arthropoda  <NA>
#> 12       Hexelasma foratum           Jones, 2000 Animalia Arthropoda  <NA>
#> 13       Mesolasma fosteri (Newman & Ross, 1981) Animalia Arthropoda  <NA>
#> 14      Hexelasma globosum           Jones, 2000 Animalia Arthropoda  <NA>
#> 15      Hexelasma gracilis          Foster, 1981 Animalia Arthropoda  <NA>
#> 16     Bathylasma hirsutum          (Hoek, 1883) Animalia Arthropoda  <NA>
#> 17    Hexelasma leptoderma (Newman & Ross, 1971) Animalia Arthropoda  <NA>
#> 18      Hexelasma nolearia          Foster, 1978 Animalia Arthropoda  <NA>
#> 19      Hexelasma persicum           Jones, 2000 Animalia Arthropoda  <NA>
#> 20    Hexelasma sandaracum           Jones, 2000 Animalia Arthropoda  <NA>
#> 21      Hexelasma triderma (Newman & Ross, 1971) Animalia Arthropoda  <NA>
#> 22     Hexelasma velutinum            Hoek, 1913 Animalia Arthropoda  <NA>
#>       order          family     genus
#> 1  Sessilia Pachylasmatidae Hexelasma
#> 2  Sessilia Pachylasmatidae Hexelasma
#> 3  Sessilia Pachylasmatidae Hexelasma
#> 4  Sessilia Pachylasmatidae Hexelasma
#> 5  Sessilia Pachylasmatidae Hexelasma
#> 6  Sessilia Pachylasmatidae Hexelasma
#> 7  Sessilia Pachylasmatidae Hexelasma
#> 8  Sessilia Pachylasmatidae Hexelasma
#> 9  Sessilia Pachylasmatidae Hexelasma
#> 10 Sessilia Pachylasmatidae Hexelasma
#> 11 Sessilia Pachylasmatidae Hexelasma
#> 12 Sessilia Pachylasmatidae Hexelasma
#> 13 Sessilia Pachylasmatidae Hexelasma
#> 14 Sessilia Pachylasmatidae Hexelasma
#> 15 Sessilia Pachylasmatidae Hexelasma
#> 16 Sessilia Pachylasmatidae Hexelasma
#> 17 Sessilia Pachylasmatidae Hexelasma
#> 18 Sessilia Pachylasmatidae Hexelasma
#> 19 Sessilia Pachylasmatidae Hexelasma
#> 20 Sessilia Pachylasmatidae Hexelasma
#> 21 Sessilia Pachylasmatidae Hexelasma
#> 22 Sessilia Pachylasmatidae Hexelasma
#>                                                                                                                                                                                                citation
#> 1                            WoRMS (2015). Hexelasma alearum Hoek, 1913. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733743 on 2016-09-29
#> 2          Southward, A. (2004). Hexelasma americanum Pilsbry, 1916. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=106242 on 2016-09-29
#> 3  Ewers-Saucedo, C. (2016). Hexelasma antarcticum Borradaile, 1916. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=883119 on 2016-09-29
#> 4                       WoRMS (2015). Hexelasma arafurae Hoek, 1913. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733262 on 2016-09-29
#> 5               WoRMS (2015). Hexelasma aucklandicum (Hector, 1888). Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733744 on 2016-09-29
#> 6                          WoRMS (2015). Hexelasma aureolum Jones, 2000. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733263 on 2016-09-29
#> 7            WoRMS (2015). Hexelasma brintoni (Newman & Ross, 1971). Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733264 on 2016-09-29
#> 8               WoRMS (2015). Hexelasma callistoderma Pilsbry, 1911. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733265 on 2016-09-29
#> 9                                  WoRMS (2015). Hexelasma corolliforme. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733745 on 2016-09-29
#> 10                   WoRMS (2015). Hexelasma ecaudatum (Hiro, 1939). Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733746 on 2016-09-29
#> 11                         WoRMS (2015). Hexelasma flavidum Jones, 2000. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733266 on 2016-09-29
#> 12                          WoRMS (2015). Hexelasma foratum Jones, 2000. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733267 on 2016-09-29
#> 13              WoRMS (2015). Hexelasma fosteri Newman & Ross, 1971. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733747 on 2016-09-29
#> 14                         WoRMS (2015). Hexelasma globosum Jones, 2000. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733268 on 2016-09-29
#> 15                        WoRMS (2015). Hexelasma gracilis Foster, 1981. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733269 on 2016-09-29
#> 16                    WoRMS (2015). Hexelasma hirsutum (Hoek, 1883). Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733748 on 2016-09-29
#> 17         WoRMS (2015). Hexelasma leptoderma (Newman & Ross, 1971). Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733270 on 2016-09-29
#> 18                    WoRMS (2015). Hexelasma nolearia Foster, 1978. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733271 on 2016-09-29
#> 19                         WoRMS (2015). Hexelasma persicum Jones, 2000. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733272 on 2016-09-29
#> 20                       WoRMS (2015). Hexelasma sandaracum Jones, 2000. Accessed through:  World Register of Marine Species at http://marinespecies.org/aphia.php?p=taxdetails&id=733273 on 2016-09-29
#> 21           WoRMS (2015). Hexelasma triderma (Newman & Ross, 1971). Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=733274 on 2016-09-29
#> 22          Chan, Benny K.K. (2015). Hexelasma velutinum Hoek, 1913. Accessed through:  World Register of Marine Species at http://www.marinespecies.org/aphia.php?p=taxdetails&id=535189 on 2016-09-29
#>                                         lsid isMarine isBrackish
#> 1  urn:lsid:marinespecies.org:taxname:733743        1       <NA>
#> 2  urn:lsid:marinespecies.org:taxname:106242        1       <NA>
#> 3  urn:lsid:marinespecies.org:taxname:883119        1       <NA>
#> 4  urn:lsid:marinespecies.org:taxname:733262        1       <NA>
#> 5  urn:lsid:marinespecies.org:taxname:733744        1       <NA>
#> 6  urn:lsid:marinespecies.org:taxname:733263        1       <NA>
#> 7  urn:lsid:marinespecies.org:taxname:733264        1       <NA>
#> 8  urn:lsid:marinespecies.org:taxname:733265        1       <NA>
#> 9  urn:lsid:marinespecies.org:taxname:733745        1       <NA>
#> 10 urn:lsid:marinespecies.org:taxname:733746        1       <NA>
#> 11 urn:lsid:marinespecies.org:taxname:733266        1       <NA>
#> 12 urn:lsid:marinespecies.org:taxname:733267        1       <NA>
#> 13 urn:lsid:marinespecies.org:taxname:733747        1       <NA>
#> 14 urn:lsid:marinespecies.org:taxname:733268        1       <NA>
#> 15 urn:lsid:marinespecies.org:taxname:733269        1       <NA>
#> 16 urn:lsid:marinespecies.org:taxname:733748        1       <NA>
#> 17 urn:lsid:marinespecies.org:taxname:733270        1       <NA>
#> 18 urn:lsid:marinespecies.org:taxname:733271        1       <NA>
#> 19 urn:lsid:marinespecies.org:taxname:733272        1       <NA>
#> 20 urn:lsid:marinespecies.org:taxname:733273        1       <NA>
#> 21 urn:lsid:marinespecies.org:taxname:733274        1       <NA>
#> 22 urn:lsid:marinespecies.org:taxname:535189        1       <NA>
#>    isFreshwater isTerrestrial isExtinct match_type             modified
#> 1          <NA>          <NA>      <NA>      exact 2013-07-03T10:40:33Z
#> 2          <NA>          <NA>      <NA>      exact 2004-12-21T16:54:05Z
#> 3          <NA>          <NA>      <NA>      exact 2016-08-13T06:12:43Z
#> 4          <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 5          <NA>          <NA>      <NA>      exact 2013-07-03T10:40:33Z
#> 6          <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 7          <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 8          <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 9          <NA>          <NA>      <NA>      exact 2013-07-03T10:40:33Z
#> 10         <NA>          <NA>      <NA>      exact 2013-07-03T10:40:33Z
#> 11         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 12         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 13         <NA>          <NA>      <NA>      exact 2013-07-03T10:40:33Z
#> 14         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 15         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 16         <NA>          <NA>      <NA>      exact 2013-07-03T10:40:33Z
#> 17         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 18         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 19         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 20         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 21         <NA>          <NA>      <NA>      exact 2013-07-03T09:26:15Z
#> 22         <NA>          <NA>      <NA>      exact 2010-10-22T11:24:03Z
```

### PESI

Search for PESI scientific names and associated metadata.


```r
pesi_search(scientific='Ternatea vulgaris')
#>               input                                 GUID
#> 1 Ternatea vulgaris 67C3CC9C-624A-40C5-B63A-AB880E0300D1
#>                                                                                 url
#> 1 http://www.eu-nomen.eu/portal/taxon.php?GUID=67C3CC9C-624A-40C5-B63A-AB880E0300D1
#>      scientificname authority    rank        status
#> 1 Ternatea vulgaris    Kuntze Species is synonym of
#>                             valid_guid        valid_name valid_authority
#> 1 7B5F817E-D94C-4929-956A-0ED57C94D3A0 Clitoria ternatea              L.
#>   kingdom phylum class order family genus
#> 1    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
#>                                                                                                                                                                                                                   citation
#> 1 ILDIS World Database of Legumes  2010. (copyright © ILDIS). Ternatea vulgaris Kuntze. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=67C3CC9C-624A-40C5-B63A-AB880E0300D1
#>   match_type
#> 1      exact
```

Get PESI scientific names from GUIDs


```r
pesi_name_scientific(guid='67C3CC9C-624A-40C5-B63A-AB880E0300D1')
#> [1] "Ternatea vulgaris"
```

Get PESI synonyms from GUIDs


```r
head( pesi_synonyms(guid='A0433E13-D7B5-49F2-86BA-A1777364C559') )
#>                                  input
#> 1 A0433E13-D7B5-49F2-86BA-A1777364C559
#> 2 A0433E13-D7B5-49F2-86BA-A1777364C559
#> 3 A0433E13-D7B5-49F2-86BA-A1777364C559
#> 4 A0433E13-D7B5-49F2-86BA-A1777364C559
#> 5 A0433E13-D7B5-49F2-86BA-A1777364C559
#> 6 A0433E13-D7B5-49F2-86BA-A1777364C559
#>                                   GUID
#> 1 757B4430-51D9-4ABB-A2FF-CA18CA04AB05
#> 2 74F210C9-4F53-4972-8885-E431BCBA3D07
#> 3 8E7A5C45-4F19-4E12-9FC0-00664BF7BD17
#> 4 E2B240D2-B3CA-4E63-8607-914239080259
#> 5 0968760E-A9CD-4DD8-B3B2-427438568862
#> 6 F6834328-FB47-492F-BA46-B621C19B4804
#>                                                                                 url
#> 1 http://www.eu-nomen.eu/portal/taxon.php?GUID=757B4430-51D9-4ABB-A2FF-CA18CA04AB05
#> 2 http://www.eu-nomen.eu/portal/taxon.php?GUID=74F210C9-4F53-4972-8885-E431BCBA3D07
#> 3 http://www.eu-nomen.eu/portal/taxon.php?GUID=8E7A5C45-4F19-4E12-9FC0-00664BF7BD17
#> 4 http://www.eu-nomen.eu/portal/taxon.php?GUID=E2B240D2-B3CA-4E63-8607-914239080259
#> 5 http://www.eu-nomen.eu/portal/taxon.php?GUID=0968760E-A9CD-4DD8-B3B2-427438568862
#> 6 http://www.eu-nomen.eu/portal/taxon.php?GUID=F6834328-FB47-492F-BA46-B621C19B4804
#>               scientificname              authority    rank
#> 1         Charybdis maritima             (L.) Speta Species
#> 2 Ornithogalum anthericoides (Poir.) Link ex Steud. Species
#> 3     Ornithogalum maritimum              (L.) Lam. Species
#> 4       Ornithogalum squilla              Ker Gawl. Species
#> 5       Scilla anthericoides                  Poir. Species
#> 6          Scilla lanceolata                   Viv. Species
#>                status                           valid_guid      valid_name
#> 1   homotypic synonym A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima
#> 2 heterotypic synonym A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima
#> 3   homotypic synonym A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima
#> 4 heterotypic synonym A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima
#> 5 heterotypic synonym A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima
#> 6 heterotypic synonym A0433E13-D7B5-49F2-86BA-A1777364C559 Drimia maritima
#>   valid_authority kingdom phylum class order family genus
#> 1     (L.) Stearn    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
#> 2     (L.) Stearn    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
#> 3     (L.) Stearn    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
#> 4     (L.) Stearn    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
#> 5     (L.) Stearn    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
#> 6     (L.) Stearn    <NA>   <NA>  <NA>  <NA>   <NA>  <NA>
#>                                                                                                                                                                                                                                                                                                        citation
#> 1                     World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Charybdis maritima (L.) Speta. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=757B4430-51D9-4ABB-A2FF-CA18CA04AB05
#> 2 World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Ornithogalum anthericoides (Poir.) Link ex Steud.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=74F210C9-4F53-4972-8885-E431BCBA3D07
#> 3                  World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Ornithogalum maritimum (L.) Lam.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=8E7A5C45-4F19-4E12-9FC0-00664BF7BD17
#> 4                    World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Ornithogalum squilla Ker Gawl.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=E2B240D2-B3CA-4E63-8607-914239080259
#> 5                        World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Scilla anthericoides Poir.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=0968760E-A9CD-4DD8-B3B2-427438568862
#> 6                            World Checklist of Selected Plant Families (2010), copyright © The Board of Trustees of the Royal Botanic Gardens, Kew. Scilla lanceolata Viv.. Accessed through: Euro+Med PlantBase at http://ww2.bgbm.org/euroPlusMed/PTaxonDetail.asp?UUID=F6834328-FB47-492F-BA46-B621C19B4804
#>   match_type
#> 1      exact
#> 2      exact
#> 3      exact
#> 4      exact
#> 5      exact
#> 6      exact
```

### Mycobank

Search for a _Candida boidinii_


```r
myco_search(filter='Name CONTAINS "Candida boidinii"')
#>      _id       creation_date    last_change_date             name  epithet
#> 1 105080 03/02/2004 08:10:28 29/03/2016 15:44:03 Candida boidinii boidinii
#> 2 175286 25/12/2004 17:43:38 29/03/2016 15:46:49 Candida boidinii boidinii
#>      authors nameyear mycobanknr literatureremarks literaturereferencetype
#> 1 C. Ramírez     1953     344025                NA                      NA
#> 2 C. Ramírez     1954     294021                NA                      NA
#>   literaturepagenr description_pt   gender
#> 1              251             NA Feminine
#> 2              100             NA Feminine
#>                                                                               e3787
#> 1 Candida boidinii C. Ramírez, Microbiología Española 6 (3): 251 (1953) [MB#344025]
#> 2                 Candida boidinii C. Ramírez, Revue Mycol.: 100 (1954) [MB#294021]
#>                                       wikipedia
#> 1 http://en.wikipedia.org/wiki/Candida boidinii
#> 2 http://en.wikipedia.org/wiki/Candida boidinii
#>                                          wikispecies
#> 1 http://species.wikipedia.org/wiki/Candida boidinii
#> 2 http://species.wikipedia.org/wiki/Candida boidinii
#>                                            wikimedia
#> 1 http://commons.wikipedia.org/wiki/Candida boidinii
#> 2 http://commons.wikipedia.org/wiki/Candida boidinii
#>                                            google
#> 1 http://www.google.com/search?q=Candida boidinii
#> 2 http://www.google.com/search?q=Candida boidinii
```

## Contributors

* Scott Chamberlain <https://github.com/sckott>
* Francois Michonneau <https://github.com/fmichonneau>

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/taxizesoap/issues).
* License: MIT
* Get citation information for `taxizesoap` in R doing `citation(package = 'taxizesoap')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.

[![ropensci](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
