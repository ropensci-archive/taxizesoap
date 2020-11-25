taxizesoap
==========



[![R-check](https://github.com/ropensci/taxizesoap/workflows/R-check/badge.svg)](https://github.com/ropensci/taxizesoap/actions?query=workflow%3AR-check)
[![codecov.io](https://codecov.io/github/ropensci/taxizesoap/coverage.svg?branch=master)](https://codecov.io/github/ropensci/taxizesoap?branch=master)

__UPDATE__: WORMS data source is now in `taxize` - for PESI and Mycobank continue to use this package.


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
#> 1 105080 03/02/2004 08:10:28 08/06/2017 14:51:37 Candida boidinii boidinii
#> 2 175286 25/12/2004 17:43:38 08/06/2017 16:37:07 Candida boidinii boidinii
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
