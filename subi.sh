curl -s "https://crt.sh/?q=%25.${1}&output=json" | jq -r .[].name_value | sed 's/\*\.//g' | sort -u | tee temp.txt 
curl -s "https://dns.bufferover.run/dns?q=.${1}" | jq -r .FDNS_A[] |cut -d "," -f2|sort -u >> temp.txt
curl -s "https://riddler.io/search/exportcsv?q=pld:${1}" | grep -Po "(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sort -u >>temp.txt
curl -s "http://web.archive.org/cdx/search/cdx?url=*.${1}/*&output=text&fl=original&collapse=urlkey" | sed -e 's_https*://__' -e "s/\/.*//" | cut -d ":" -f1 | sort -u >> temp.txt
curl -s 'https://securitytrails.com/list/apex_domain/${1}' | grep -Po '((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+' | grep '.${1}' | sort -u >> temp.txt
sort -u temp.txt | tee result.txt



