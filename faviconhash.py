import mmh3
import requests
import codecs
import sys
 
if sys.argv[1] != "":
    response = requests.get(sys.argv[1])
    favicon = codecs.encode(response.content,"base64")
    hash = mmh3.hash(favicon)
    print(hash)
else:
    print("Supply url as argument")
    print("Example: faviconhash https://url.com/favicon.ico")