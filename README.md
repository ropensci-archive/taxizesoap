taxizesoap
=======

[![Build Status](https://api.travis-ci.org/ropensci/taxizesoap.png?branch=master)](https://travis-ci.org/ropensci/taxizesoap)

`taxizesoap` is like [taxize](), but for data sources that use SOAP data transfer protocol, which is hard to support in R. This package won't go on CRAN.

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

## Quickstart

For more examples [click here](http://ropensci.org/tutorials/taxizesoap_tutorial.html)

### Install taxizesoap

#### Development version from GitHub:

You'll need `XMLSchema` and `SSOAP`

```r
install.packages("devtools")
devtools::install_github(c("sckott/XMLSchema", "sckott/SSOAP"))
```

```r
devtools::install_github("taxizesoap", "ropensci")
library('taxizesoap')
```

### examples...

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/taxizesoap/issues).
* License: MIT
* Get citation information for `taxizesoap` in R doing `citation(package = 'taxizesoap')`

[![ropensci](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
