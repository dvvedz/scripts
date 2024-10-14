"""
input:
c.u = e=>({
        52: "ClientIndex",
        153: "epic-social-social-modules-LauncherOverlay",
        211: "CartSuccessView",
        230: "ProductAddonsPage",
        322: "ManageProductModsPage",
        481: "ManageProductsPage",
        484: "ArticleView",
        517: "CMSMarketingView",
        661: "NewsView",
        665: "Vendor",
        737: "CartView",
        835: "epic-social-social-modules-LauncherSocialProvider",
        937: "WishlistView"
    }[e] + ".egstore-site." + {
        52: "18ce15b20973b10e7787",
        153: "87da17d29ceec86e3156",
        211: "12630191201b086ef0f5",
        230: "23237510591b4cf25ca0",
        322: "f0d9cf3f2d300110a40f",
        481: "f1b21a0f6b4a507c1c15",
        484: "0977996ba1e1b34412bd",
        517: "a0459101bc6eed21211d",
        661: "a42775934ed8ef80bf58",
        665: "eb22a4dceb38450a71ac",
        737: "f368b715e99941dd4b5b",
        835: "1cf6cb35d1a90625f311",
        937: "addd3a5063085a4b05b5"
    }[e] + "")
"""

import re

d = input("insert lazyloaded function:\n")
# with open("input.txt") as f:
#    d = f.read()

concatChars = re.findall("\+ ?\"([^\"]+)\" ?\+", d)
if len(concatChars) == 0:
    print("Couldn't identify concatination char. You'll need to modify the code to know how to concat the values.")
    exit()
concatChars = concatChars[0]
#print(concatChars)

endingChars = re.findall("\+ ?\"([^\"]+)\"\)", d)
if len(endingChars) == 0:
    print("Couldn't identify file ext. You'll need to modify the code so that it can property identify the file ext.")
    exit()
endingChars = endingChars[0]
#print(endingChars)

res = list(map(lambda x:x.replace("\n", "").strip(), re.findall("([^:\n{}]+:[^,{}]+),?", d, re.MULTILINE)))
d = {}
for l in res:
    l = l.replace('"', "")
    k,v = l.split(":")
    k = k.strip()
    v = v.strip()
    if k in d:
        d[k] = d[k]+concatChars+v
    else:
        d[k] = v

print("\n".join(map(lambda x:x+endingChars, d.values())))
