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
    "src_environments_config-schemas_accordion_config_ts": "e4e172eacecf27a1",
    "src_environments_config-schemas_carousel_config_ts": "1c25ff47bd2096f6",
    "src_environments_config-schemas_catalog_config_ts": "2aa905836b950831",
    "src_environments_config-schemas_contentMapping_config_ts": "23156ca7db8eb60d",
    "src_environments_config-schemas_contentSystems_config_ts": "559163fdd6104a51",
    "src_environments_config-schemas_cookies_config_ts": "c924b6ae555c2aad",
    "src_environments_config-schemas_details_config_ts": "d52f9e697c175351",
    "src_environments_config-schemas_flightSearch_config_ts": "a14fd168b1819ef0",
    "src_environments_config-schemas_ga_config_ts": "346668303cf05add",
    "src_environments_config-schemas_imageSizes_config_ts": "a707d23a036aef68",
    "src_environments_config-schemas_itemAttributes_config_ts": "8fea6cb6290537c3",
    "src_environments_config-schemas_landing_config_ts": "3956735d0f046547",
    "src_environments_config-schemas_languageFromUrl_config_ts": "ca5125bf8ee695ec",
    "src_environments_config-schemas_responsive_config_ts": "2f0c4e17177adfca",
    "src_environments_config-schemas_search_config_ts": "a293f19e4a16bbdb",
    "src_environments_config-schemas_shared_config_ts": "851c6786a980e9ef",
    "src_environments_config-schemas_sort_config_ts": "02bbfbc46a86d255",
    src_environments_environment_prod_ts: "b8dca7aeff6c11a9",
    src_environments_overrides_prod_ts: "33cecf0e3a0f6714",
    src_environments_overrides_ts: "0a1b00ee3c383bc6",
    src_environments_paginator_config_ts: "c55cfe7b85151299",
    theme_environments_overrides_ts: "a82ed44f5d8ef9b5",
    src_app_modules_catalog_catalog_module_ts: "183041ccc5935b2c",
    common: "3b54d3af896c7393",
    src_app_modules_details_details_module_ts: "992196fa7d000c4b",
    "src_app_modules_video-player_video-player_module_ts": "0a008233e2c72a08",
    "src_app_modules_images-modal_images-modal_module_ts": "14bb93c347cbb8e6",
    "node_modules_juggle_resize-observer_lib_exports_resize-observer_js": "7f05dd6b517403ea"
}

let suffix = ".js"

let url = "https://inflightentertainment.finnair.com/"

for (let fn in fileNames) {
    // check if prefixesFirst dont have any values
    if (Object.keys(prefixesFirst).length > 0) {
        for (pf in prefixesFirst) {
            let fileName = fileNames[fn]
            let prefixVal = prefixesFirst[fn]

            if (fn == pf) {
                if (prefixSecond != "" || !null || !undefined)
                    console.log(`${prefixVal}${prefixSecond}.${fileName}${suffix}`);
                else
                    console.log(`${prefixVal}.${fileName}${suffix}`);
            }
        }
        console.log(`${fn}.${fileNames[fn]}${suffix}`)
    } else if (Object.keys(prefixesFirst).length == 0) {
        // if no extensions only run these 
        if (prefixSecond != "" || !null || !undefined)
            console.log(`${fn}${prefixSecond}.${fileNames[fn]}${suffix}`)
        else
            console.log(`${fn}.${fileNames[fn]}${suffix}`)
    }
}
