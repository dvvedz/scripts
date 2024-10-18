/*"""
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
    }[e] + ".js")
"""
*/

let prefixesFirst = {
    // 52: "ClientIndex",
    // 153: "epic-social-social-modules-LauncherOverlay",
    // 211: "CartSuccessView",
    // 230: "ProductAddonsPage",
    // 322: "ManageProductModsPage",
    // 481: "ManageProductsPage",
    // 484: "ArticleView",
    // 517: "CMSMarketingView",
    // 661: "NewsView",
    // 665: "Vendor",
    // 737: "CartView",
    // 835: "epic-social-social-modules-LauncherSocialProvider",
    // 937: "WishlistView"
}

let prefixSecond = ""

let fileNames = {
    0: "1fd945d8560ba20ab23f",
    1: "32d0d5e7a83e00a47a50",
    2: "f9ea2f04743138110cac",
    5: "344ce37a51572bb43402",
    6: "5d8db38367cc3bf14626",
    7: "5e0b58fa3e09501acdb6",
    8: "ec7fffb78fa2968de5de",
    9: "f8e02c4a74d87a732639",
    10: "36448433a07c6beea638",
    11: "d5537f15a4cbc5ec3647",
    12: "a3b97d783cfdc45e0fe1",
    13: "0bfcf999d21b4d5c191d",
    14: "b1109cfe80e57e2433d6",
    15: "fdee266b02532a1528a4",
    16: "c05df8bbddc9ed076001",
    17: "d5d3a58513b9d2b0c2f6",
    18: "91238d78b22b621549d8",
    19: "49edbfcb023d934be7cb",
    20: "d739bb4743be22b31102",
    21: "2f02dee99efdfc5dea82",
    22: "ad9fe1534fb794a50a03",
    23: "1e546fc2d17b1794cc08",
    24: "634ccd0a6292d052f938",
    25: "280112b9f64fab7d78f6",
    26: "3a1720d78cc60351f09a"
}

let suffix = ".js"

let url = "https://parcellab.fulfillment.usdh.ikea.net/mgmnt/"

for (let fn in fileNames) {
    // check if prefixesFirst dont have any values
    if (Object.keys(prefixesFirst).length > 0) {
        for (pf in prefixesFirst) {
            let fileName = fileNames[fn]
            let prefixVal = prefixesFirst[fn]

            if (fn == pf) {
                if (prefixSecond != "" || !null || !undefined)
                    console.log(`${url}${prefixVal}${prefixSecond}.${fileName}${suffix}`);
                // console.log(`${url}${prefixVal}${prefixSecond}.${fileName}${suffix}`);
                else
                    console.log(`${url}${prefixVal}.${fileName}${suffix}`);
            }
        }
        console.log(`${url}${fn}.${fileNames[fn]}${suffix}`)
    } else if (Object.keys(prefixesFirst).length == 0) {
        // if no extensions only run these 
        if (prefixSecond != "" || !null || !undefined)
            console.log(`${url}${fn}${prefixSecond}.${fileNames[fn]}${suffix}`)
        else
            console.log(`${url}${fn}.${fileNames[fn]}${suffix}`)
    }
}
