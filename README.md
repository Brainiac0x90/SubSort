# SubSort

**Setup:**
chmod +x SubSort.sh

**Usage:**
`./SubSort <URL> <domain>` 
Ex: `./SubSort www.example.com example`


**OUTPUT FILES:**
-`index.html` --> the html page source code 
-`subAliases.txt` --> for every address but sometimes you just get the aliases.
-`valid.txt` --> for valid subdomains.
-`subd.txt` --> for all subdomains (valid & not valid).

**{HOW THE TOOL WORK}:**
~The file `index.html` is basically the source code of the URL you typed.
~The tool basically search and grab all the subdomains within the `index.html`.
~It also tests every single subdomain found and pings it to make sure it's working.
~Then it applies the: `host <Whatever_subdomain>` command to collect all the ips for every single subdomain.

