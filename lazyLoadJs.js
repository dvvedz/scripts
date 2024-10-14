const https = require('https');

let url = "https://inflightentertainment.finnair.com/"
let prefixes = []
let appendix = ".js";
let lazyNames = {
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

for (let [key, value] of Object.entries(lazyNames)) {
    if (prefixes.length > 0) {
        for (let e of prefixes) {
            let u = `${url}${e}${value}${appendix}`
            https.get(u, res => {
                var body = '';
                res.on('data', function(chunk) {
                    body += chunk;
                });
                res.on('end', function() {
                    if (res.statusCode == 200 && !body.includes("enable JavaScript")) {
                        console.log(u);
                    }
                });
            }).on('error', err => {
                console.log('Error: ', err.message);
            });
        }
    }

    let u2 = `${url}${key}.${value}${appendix}`

    https.get(u2, res => {
        var body = '';
        res.on('data', function(chunk) {
            body += chunk;
        });
        res.on('end', function() {
            if (res.statusCode == 200 && !body.includes("enable JavaScript")) {
                console.log(u2);
            }
        });
    }).on('error', err => {
        console.log('Error: ', err.message);
    });
}
