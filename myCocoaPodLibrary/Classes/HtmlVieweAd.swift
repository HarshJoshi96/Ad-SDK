//
//  HtmlViewAd.swift
//  Pods
//
//  Created by Harsh.Joshi on 28/07/23.
//

import Foundation
import UIKit
import AVKit
import WebKit
import SafariServices

public class HtmlViewAd: UIView, WKNavigationDelegate {
    private var mediadetails:ProductMediaDetail?
    private var productAdResponse: ProductAdResponse?
    
    var observer: NSKeyValueObservation?
    open var loaded: ((Bool, CGFloat)->())!
    open var advertisementTapped: ((String)->())?
    
    var controller : UIViewController?

     public init(frame: CGRect, controller : UIViewController) {
        self.controller = controller
        super.init(frame: frame)
        initCode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCode()
    }
    
    
    func initCode() {
        renderUIForView()
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    func renderUIForView() {
        let webView = WKWebView(frame:self.bounds)
        webView.navigationDelegate = self
        webView.loadHTMLString("<!DOCTYPE html>\n<html>\n<head>\n    <link rel=\"dns-prefetch\" href=\"https://supply.inmobicdn.net\">\n    <link\n        href='https://supply.inmobicdn.net/template-rewrite/1.3.7/main.banner.1.3.7.1688982096.bundle.css'\n        rel='stylesheet'\n    />\n</head>\n<body>\n    \n    \n    \n    \n    \n    \n    \n    \n        \n    \n    \n\n    \n    \n    \n    \n    \n    \n        \n    \n            <script type='text/javascript' src='https://i.l-ssp.inmobicdn.net/sdk/sdk/1056/ios/mraid.js'></script>\n    \n    \n            \n    \n                        <script type='text/javascript' src='https://supply.inmobicdn.net/javascript/omid-session-client-v1-1-3-17.js'></script>\n        <script type='text/javascript' src='https://supply.inmobicdn.net/javascript/omsdk-v1-1-3-17.js'></script>\n                \n            \n            \n        \n<script type='text/javascript'>\n    var fallbackTemplateData = {\n        publisherID: 'a9b0c4fb476c475ba1316dae07007038',\n        placementID: '1629467887628',\n        sdkVersion: 'i1056',\n        impressionID: '6d7e5fe0-0189-1000-de65-0be01763008d',\n        bundleID: 'com.inmobi.UnifiedTestApp1056',\n        integrationType: 'iOS Sdk',\n        integrationDirect: 'dir',\n        templateID: '2194518987162020242',\n        aBChannel: '$aBChannel',\n        creativeId: '975a30555af54c31aca4ea58a75f5b33',\n        creativeIdentifier: '<adv>88b37efcd5f34d368e60317c706942a4<crid>975a30555af54c31aca4ea58a75f5b33',\n        adType: 'banner',\n    };\n    window.fallbackTemplateData = fallbackTemplateData;\n</script>\n\n<script type='text/javascript'>\n    var isAdChoiceIconDisabled = false;\n    var DSPS_WITH_AD_CHOICE_ICON = [\n        '88b37efcd5f34d368e60317c706942a4',\n        '18537c56d45d490ea66932e7716e7b01',\n        'fc721c15cc224afcbcfe7bcd77551a06',\n        '9a9b24ce5bf3421792d7b41e0b24c82a',\n        '70f089f4247e4606bd981b92e7380de0',\n        '6bf6dff898144f7cb9326d1a1cd9029a',\n        'f9b3e81e09a7463a82cc4b2b6ab19538',\n        'd54c6c137e354b36a1fd53591f8a0a6d',\n        '662176a0697445b883316aa343f8f26a',\n        'ab2b4552e3744c60808052cfcb69758b',\n        '8533f71be3c04f96aa27f5e9f6116f7a',\n        'aba0d18cd26b4c4c92a987d2d9ff5532',\n        '35553d9097324ebfa32072bd60e48a29',\n        '7bb19aa0085344349df1bfb891a58426'\n    ];\n\n    try {\n        var creativeIdentifier = '<adv>88b37efcd5f34d368e60317c706942a4<crid>975a30555af54c31aca4ea58a75f5b33';\n        creativeIdentifier = creativeIdentifier || '';\n        var dspId = creativeIdentifier.substring(creativeIdentifier.indexOf('<adv>') + 5, creativeIdentifier.lastIndexOf('<crid>'));\n        isAdChoiceIconDisabled = DSPS_WITH_AD_CHOICE_ICON.includes(dspId);\n    } catch (e) {\n\n    }\n\n    var templateData = {\n        sdkGreaterThanEqualTo450: 'true',\n        SDK500Onwards: 'true',\n        enableCustomCloseInt: '',\n        staticInterstitialCloseDelay: '',\n        isPlayable: '',\n        isEnableOverlay: '',\n        centreCreative: 'false',\n        isSDKAdPod: 'false',\n        isShineEffect: 'true',\n        isDv360Ad: 'false',\n        impDelayInMs: '0',\n        isRewarded: '',\n        podsStaticIntSkipDelay: '',\n        delayToShowNextAd: '9000',\n        podsRewardedStaticIntSkipDelay: '',\n        closeButtonDim: '',\n        isLazyLoadingEnabledForInt: 'false',\n        isCapturePlayableInteraction: '',\n        impOnBodyLoad: 'false',\n        isVCPM: 'false',\n        isStaticIntAutoClose: 'false',\n        isFireClickViaSDK: 'false',\n        isFireImpressionViaSDK: 'false',\n        isSdkSupportsNativeTracking: 'false',\n        shouldCheckForMraidOnBodyLoad: 'false',\n        optOutUrl: 'https://www.inmobi.com/ad-opt-out?i=%7B%22IDA%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22IDV%22%3A%22B50DEC75-ADF3-47D3-ADB6-D59CF2EBB862%22%7D',\n        incentiveJSON: '',\n        isDisableCreativeResize: 'true',\n        overlayHeight: '',\n        preLoaderDelay: '',\n        shineIterativeDelay: '8',\n        shineAnimationDelay: '4',\n        isFireM120Beacon: 'true',\n        adHeight: '50',\n        adWidth: '320',\n        thirdPartyAdTag: '',\n        isOverrideMraidOpen: 'false',\n        namespace: 'im_7276_',\n        isDv360AdOnePixelExp: 'false',\n        sdkversion: 'i1056',\n        reqSupportsMraid: 'true',\n        buildMorphAdMarkup: 'false',\n        openingLandingUrl: '$openingLandingUrl',\n        title: \"$title\",\n        sponsoredBy: '',\n        cta: '$cta',\n        description: \"$description\",\n        iconUrl: '$iconUrl',\n        mainUrl: '$mainUrl',\n        isTrueViewEnabled: 'true',\n        adType: 'banner',\n        skipDelay: '',\n        skipDelayTimeForRewarded: '',\n        experienceType: '',\n        imaiConfigList: [{\"bcu\":\"http://et-eus.w.inmobi.com/c.asm/HDbou9nw3q7kBSRkFBYV2AgbAlgMJDAwMDAwMDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMDQkQjUwREVDNzUtQURGMy00N0QzLUFEQjYtRDU5Q0YyRUJCODYyHBUAFQIVABXAEBUCJbgFGAVpMTA1NhgDZGlyABMAJcoBGChZMjl0TG1sdWJXOWlhUzVWYm1sbWFXVmtWR1Z6ZEVGd2NERXdOVFl-FrTi1AIcHBaAwMiYgPiv_toBFuX9____h_r_QwAAFTQXAAAAAACATEARFAAcEhkFABa04tQCGANVU0QWmKDWvexeGfUl_qsBmKwBvqwBxqwB2qwB7KwB8KwByrsBkssBlMsBlssBmssB9ssBiMwBmswBnMwBoMwBoswBpMwBsMwByMwBzMwB1swB2swB4MwB1tMB4OIB5pkC4NcCuIcDhuIJjOIJkuIJlOIJmOIJnOIJouIJIRhnDAABCwABAAAAIDg4YjM3ZWZjZDVmMzRkMzY4ZTYwMzE3YzcwNjk0MmE0CgACAAAAAAAXY2UKAAgAAAAAAAS0PwAEAAIAAAAAAAAAAAoABAAAAAAAKpiaCgAFAAAAAAAYR58CAAYAADgXBAABQEyAAAAAAAAEAAI_hHrhR64UewAYtgIDAAEOCAACAAAAEQYABQFABgAGADILAAcAAAAGMTAuNS42CwAIAAAAA0FQUAgACQAAAAICAAoABAAMP3iTdLxqfvoLAA8AAAAMTk9fVEFSR0VUSU5HCAASAAAGOgsAFAAAACBhOWIwYzRmYjQ3NmM0NzViYTEzMTZkYWUwNzAwNzAzOAgAFgAAAAELABcAAAAEMTYuNAIAGAACABkAAgAbAAYAHAAAAgAdAQIAIAECACEBBgAiAAAKACUAAAAAAAAAAAsAKAAAAB1jb20uaW5tb2JpLlVuaWZpZWRUZXN0QXBwMTA1NgYAKgAgBgArAAQGACwAAQYALQAFBgAwAAEIADEAAAFACAAyAAAAMgYAMwAFAgA2AAsAOAAAABhZckhvdjFhS2hVenJLWHRXS1ZXSXZ3PT0AGM0CCgABHnR_ZEqkaZILAAIAAAEpCwABAAAACTUzMDQ4ODM1OQMAAgAGAAZCAAsABwAAAARSVEJEBgAIABMLAAkAAAAhMzA4Mjg3OlNFQVRfSURfSU5NT0JJX1NBTkRCT1hfRFNQCAAOAAAAAAsADwAAAAYzMjBYNTAGABAADwsAEQAAACA4OGIzN2VmY2Q1ZjM0ZDM2OGU2MDMxN2M3MDY5NDJhNAIAFAADABUBAwAXBQMAGAAGABkAAQsAGwAAABVjb20uc2FuZGJveC5idW5kbGUuaWQGABwAAAYAHQAAAgAeAAMAHwACACABAgAiAAoAIwAAAAAAAAAAAwAmAQsAJwAAAAROdWxsCwApAAAAIzMwODI4NzowOlNFQVRfSURfSU5NT0JJX1NBTkRCT1hfRFNQAgArAAIALAAABgAEAA8IAAUAAAAABgAJAAUAABiXAjaYoNa97F64BkJBTk5FUhw8HBaAwMiYgPiv_toBFuX9____h_r_QwAWASIAADn1JYbiCYjMAYziCZLiCZLLAZTLAZTiCZbLAZisAZrLAZjiCZrMAZzMAZziCaDMAaLiCaLMAaTMAbDMAbiHA76sAcasAcjMAcq7AczMAdbTAdbMAdqsAdrMAeDiAeDXAuDMAeaZAuysAfCsAfbLAf6rARwArBUAACwVAACFABIYCDAuMDAyNzkyHBaAwMiYgPiv_toBFuX954n9h_qaQwAlygEVCjggOTc1YTMwNTU1YWY1NGMzMWFjYTRlYTU4YTc1ZjViMzMoCjQyNjM1MDk4NTcUAHcAAAAAAAAAABwAGQwUABERFQQSABgBOBwYFLX0JRK9-fcwSgi3dCG7Qi8jeSOsAAA/f60c327a\",\"ns\":\"im_7276_\",\"lpom\":3,\"fbom\":3,\"sc\":true,\"vbd\":0,\"vff\":false,\"vtc\":\"\\u003cscript type\\u003d\\\"text/javascript\\\" src\\u003d\\\"https://pixel.adsafeprotected.com/jload?anId\\u003d9883\\u0026campId\\u003d975a30555af54c31aca4ea58a75f5b33\\u0026pubId\\u003d4263509857\\u0026chanId\\u003d4MSNP01O\\u0026placementId\\u003d320X50\\\"\\u003e\\u003c/script\\u003e\\u003cscript type\\u003d\\\"text/javascript\\\" src\\u003d\\\"https://z.moatads.com/inmobi718059834551/moatad.js#moatClientLevel1\\u003d88b37efcd5f34d368e60317c706942a4\\u0026moatClientLevel2\\u003d4263509857\\u0026moatClientLevel3\\u003d4263509857\\u0026moatClientLevel4\\u003d975a30555af54c31aca4ea58a75f5b33\\u0026moatClientSlicer1\\u003d4MSNP01O\\u0026moatClientSlicer2\\u003d320X50\\u0026zMoatRT\\u003dDisplay_O1\\u0026zMoatIMv\\u003di1056\\u0026zMoatBundleID\\u003d530488359\\\"\\u003e\\u003c/script\\u003e\\u003cscript src\\u003d\\\"https://cdn.doubleverify.com/dvtp_src.js?ctx\\u003d13661327\\u0026cmp\\u003dDV136123\\u0026sid\\u003dInMobi\\u0026plc\\u003dInMobi-NWV-Video\\u0026advid\\u003d3819603\\u0026adsrv\\u003d0\\u0026tagtype\\u003dvideo\\u0026dvtagver\\u003d6.1.src\\u0026DVPX_PP_IMP_ID\\u003d$IMPRESSION_ID\\u0026DVPX_PP_UID\\u003dtest\\u0026DVP_PP_REP\\u003d1\\u0026DVP_IQM_ID\\u003d26\\u0026DVP_DV_TT\\u003d1\\u0026DVP_DV_CT\\u003d2\\u0026DVP_IM_1\\u003d88b37efcd5f34d368e60317c706942a4\\u0026DVP_IM_2\\u003djs_975a30555af54c31aca4ea58a75f5b33\\u0026DVP_IM_3\\u003djs_4263509857\\u0026DVP_IM_5\\u003d320X50\\u0026DVP_IM_6\\u003di1056\\u0026DVP_IM_7\\u003dIN\\u0026DVP_IM_8\\u003d4MSNP01O\\u0026app\\u003d530488359\\u0026turl\\u003d530488359\\\" type\\u003d\\\"text/javascript\\\"\\u003e\\u003c/script\\u003e\",\"fireBeaconExp\":false,\"forceOpenInChrome\":false,\"eventTrackerMap\":{\"CLICK\":[\"https://c-eus.w.inmobi.com/c.asm/HDbou9nw3q7kBSRkFBYV2AgbAlgMJDAwMDAwMDAwLTAwMDAtMDAwMC0wMDAwLTAwMDAwMDAwMDAwMDQkQjUwREVDNzUtQURGMy00N0QzLUFEQjYtRDU5Q0YyRUJCODYyHBUAFQIVABXAEBUCJbgFGAVpMTA1NhgDZGlyABMBJcoBGChZMjl0TG1sdWJXOWlhUzVWYm1sbWFXVmtWR1Z6ZEVGd2NERXdOVFl-FrTi1AIcHBaAwMiYgPiv_toBFuX9____h_r_QwAAFTQXAAAAAACATEARFAAcEhkFABa04tQCGANVU0QWmKDWvexeGfUl_qsBmKwBvqwBxqwB2qwB7KwB8KwByrsBkssBlMsBlssBmssB9ssBiMwBmswBnMwBoMwBoswBpMwBsMwByMwBzMwB1swB2swB4MwB1tMB4OIB5pkC4NcCuIcDhuIJjOIJkuIJlOIJmOIJnOIJouIJIRhnDAABCwABAAAAIDg4YjM3ZWZjZDVmMzRkMzY4ZTYwMzE3YzcwNjk0MmE0CgACAAAAAAAXY2UKAAgAAAAAAAS0PwAEAAIAAAAAAAAAAAoABAAAAAAAKpiaCgAFAAAAAAAYR58CAAYAADgXBAABQEyAAAAAAAAEAAI_hHrhR64UewAYtgIDAAEOCAACAAAAEQYABQFABgAGADILAAcAAAAGMTAuNS42CwAIAAAAA0FQUAgACQAAAAICAAoABAAMP3iTdLxqfvoLAA8AAAAMTk9fVEFSR0VUSU5HCAASAAAGOgsAFAAAACBhOWIwYzRmYjQ3NmM0NzViYTEzMTZkYWUwNzAwNzAzOAgAFgAAAAELABcAAAAEMTYuNAIAGAACABkAAgAbAAYAHAAAAgAdAQIAIAECACEBBgAiAAAKACUAAAAAAAAAAAsAKAAAAB1jb20uaW5tb2JpLlVuaWZpZWRUZXN0QXBwMTA1NgYAKgAgBgArAAQGACwAAQYALQAFBgAwAAEIADEAAAFACAAyAAAAMgYAMwAFAgA2AAsAOAAAABhZckhvdjFhS2hVenJLWHRXS1ZXSXZ3PT0AGM0CCgABHnR_ZEqkaZILAAIAAAEpCwABAAAACTUzMDQ4ODM1OQMAAgAGAAZCAAsABwAAAARSVEJEBgAIABMLAAkAAAAhMzA4Mjg3OlNFQVRfSURfSU5NT0JJX1NBTkRCT1hfRFNQCAAOAAAAAAsADwAAAAYzMjBYNTAGABAADwsAEQAAACA4OGIzN2VmY2Q1ZjM0ZDM2OGU2MDMxN2M3MDY5NDJhNAIAFAADABUBAwAXBQMAGAAGABkAAQsAGwAAABVjb20uc2FuZGJveC5idW5kbGUuaWQGABwAAAYAHQAAAgAeAAMAHwACACABAgAiAAoAIwAAAAAAAAAAAwAmAQsAJwAAAAROdWxsCwApAAAAIzMwODI4NzowOlNFQVRfSURfSU5NT0JJX1NBTkRCT1hfRFNQAgArAAIALAAABgAEAA8IAAUAAAAABgAJAAUAABiXAjaYoNa97F64BkJBTk5FUhw8HBaAwMiYgPiv_toBFuX9____h_r_QwAWASIAADn1JYbiCYjMAYziCZLiCZLLAZTLAZTiCZbLAZisAZrLAZjiCZrMAZzMAZziCaDMAaLiCaLMAaTMAbDMAbiHA76sAcasAcjMAcq7AczMAdbTAdbMAdqsAdrMAeDiAeDXAuDMAeaZAuysAfCsAfbLAf6rARwArBUAACwVAACFABIYCDAuMDAyNzkyHBaAwMiYgPiv_toBFuX954n9h_qaQwAlygEVCjggOTc1YTMwNTU1YWY1NGMzMWFjYTRlYTU4YTc1ZjViMzMoCjQyNjM1MDk4NTcUAHcAAAAAAAAAABwAGQwUABERFQQSABgBOAA/6829726a?at\\u003d2\\u0026am\\u003d7\\u0026ct\\u003d$TS\\u0026lt\\u003d$LTS\\u0026st\\u003d$STS\"]},\"omidMacros\":{\"$LIMIT_AD_TRACKING\":\"1\",\"#GEO_CC\":\"IN\",\"$SDK_VERSION_ID\":\"i1056\",\"$GEO_LAT\":\"\",\"#GEO_LAT\":\"\",\"$RSAID\":\"00000000-0000-0000-0000-000000000000\",\"#IDA\":\"\",\"#GEO_LNG\":\"\",\"#LIMIT_AD_TRACKING\":\"1\",\"$HANDSET_MAKE\":\"Apple\",\"#HANDSET_MAKE\":\"Apple\",\"#PARTNER_ADV_ID\":\"0\",\"$HANDSET_LANG\":\"en\",\"#HANDSET_LANG\":\"en\",\"$SI_BLIND\":\"4MSNP01O\",\"$GEO_LNG\":\"\",\"#RSAID\":\"00000000-0000-0000-0000-000000000000\",\"#ADVERTISER_ID\":\"88b37efcd5f34d368e60317c706942a4\",\"$IMP_CB\":\"6d7e5fe0-0189-1000-de65-0be01763008d\",\"$GEO_CC\":\"IN\",\"#DEAL_ID\":\"4263509857\",\"#PLACEMENT_DIMENSION\":\"320X50\",\"$PLACEMENT_DIMENSION\":\"320X50\",\"$HANDSET_NAME\":\"iPhone\",\"#SDK_VERSION_ID\":\"i1056\",\"#AD_SLOT\":\"320X50\",\"#HANDSET_NAME\":\"iPhone\",\"$ADVERTISER_ID\":\"88b37efcd5f34d368e60317c706942a4\",\"#SI_BLIND\":\"4MSNP01O\",\"#SI_RAW\":\"530488359\",\"#IMP_CB\":\"6d7e5fe0-0189-1000-de65-0be01763008d\",\"$HANDSET_TYPE\":\"SMARTPHONE\",\"#HANDSET_TYPE\":\"SMARTPHONE\",\"$DEAL_ID\":\"4263509857\",\"#GPID\":\"\",\"#CREATIVE_ID\":\"975a30555af54c31aca4ea58a75f5b33\",\"$BLINDED_SITE_ID\":\"4MSNP01O\",\"$SI_RAW\":\"530488359\",\"#BLINDED_SITE_ID\":\"4MSNP01O\",\"$IDA\":\"\",\"$CREATIVE_ID\":\"975a30555af54c31aca4ea58a75f5b33\",\"$GPID\":\"\",\"$PARTNER_ADV_ID\":\"0\",\"$AD_SLOT\":\"320X50\"},\"zMoatRt\":\"WebView3\",\"omids\":[{\"trackerType\":\"omsdk-viewability\",\"vendor\":\"moat.com-omsdkinmobiinappvideo228060498413\",\"verificationParams\":\"{\\\"zMoatBundleID\\\":\\\"530488359\\\",\\\"moatClientLevel2\\\":\\\"4263509857\\\",\\\"moatClientLevel3\\\":\\\"4263509857\\\",\\\"zMoatRT\\\":\\\"Display_O1\\\",\\\"zMoatIMv\\\":\\\"i1056\\\",\\\"moatClientLevel1\\\":\\\"88b37efcd5f34d368e60317c706942a4\\\",\\\"moatClientLevel4\\\":\\\"975a30555af54c31aca4ea58a75f5b33\\\",\\\"moatClientSlicer2\\\":\\\"320X50\\\",\\\"moatClientSlicer1\\\":\\\"4MSNP01O\\\"}\",\"url\":\"https://z.moatads.com/inmobi718059834551/moatad.js\"},{\"trackerType\":\"omsdk-viewability\",\"vendor\":\"integralads.com\",\"url\":\"https://pixel.adsafeprotected.com/jload?anId\\u003d9883\\u0026campId\\u003d975a30555af54c31aca4ea58a75f5b33\\u0026pubId\\u003d4263509857\\u0026chanId\\u003d4MSNP01O\\u0026placementId\\u003d320X50\"},{\"trackerType\":\"omsdk-viewability\",\"vendor\":\"doubleverify.com-omid\",\"verificationParams\":\"tagtype\\u003dvideo\\u0026msrapi\\u003djsOmid\\u0026ctx\\u003d13661327\\u0026cmp\\u003dDV136123\\u0026sid\\u003dInMobi\\u0026plc\\u003dInMobi-NWV-Video\\u0026advid\\u003d4263509857_3819603\\u0026adsrv\\u003d170\\u0026turl\\u003d4263509857_530488359\\u0026dup\\u003d6d7e5fe0-0189-1000-de65-0be01763008d\\u0026dvtagver\\u003ddvot_2023-05-25_86d4aafbd_6ce8dde\\u0026DVPX_PP_IMP_ID\\u003d$IMPRESSION_ID\\u0026DVPX_PP_UID\\u003d$USER_ID\\u0026DVP_PP_REP\\u003d1\\u0026DVP_IQM_ID\\u003d26\\u0026DVP_DV_TT\\u003d3\\u0026DVP_DV_CT\\u003d2\\u0026DVP_IM_1\\u003d4263509857_88b37efcd5f34d368e60317c706942a4\\u0026DVP_IM_2\\u003d4263509857_975a30555af54c31aca4ea58a75f5b33\\u0026DVP_IM_3\\u003d4263509857_$ADGROUP_ID\\u0026DVP_IM_5\\u003d4263509857_320X50\\u0026DVP_IM_6\\u003d4263509857_i1056\\u0026DVP_IM_7\\u003dIN\\u0026DVP_IM_8\\u003d4263509857_4MSNP01O\\u0026DVP_PP_BUNDLE_ID\\u003d4263509857_530488359\\u0026blk\\u003d0\\u0026mon\\u003d1\\u0026dvp_infra\\u003daws\\u0026dvp_zjsver\\u003d0.21.17\\u0026vstvr\\u003d2.0-r\\u0026dvp_redirect\\u003d2\\u0026dvp_psf\\u003d0\\u0026vidreg\\u003das\",\"url\":\"https://cdn.doubleverify.com/dvtp_src.js#vendor_key\\u003ddoubleverify.com-omid\"}]}],\n        logInfo: {\n            enablePrometheus: 'true',\n            publisherID: 'a9b0c4fb476c475ba1316dae07007038',\n            placementID: '1629467887628',\n            sdkVersion: 'i1056',\n            impressionID: '6d7e5fe0-0189-1000-de65-0be01763008d',\n            bundleID: 'com.inmobi.UnifiedTestApp1056',\n            integrationType: 'iOS Sdk',\n            integrationDirect: 'dir',\n            templateID: '2194518987162020242',\n            aBChannel: '$aBChannel',\n        },\n        creativeIdentifier: '<adv>88b37efcd5f34d368e60317c706942a4<crid>975a30555af54c31aca4ea58a75f5b33',\n        shouldDetectBlankAd: true,\n        enablePostcribe: false,\n        isNewAdChoice: 'false',\n        omidConfigList: [{\"sdkVersion\":\"i1056\",\"omidPartnerName\":\"Inmobi\",\"namespace\":\"im_7276_\",\"sessionClientVersion\":\"1.3.17-iab2651\"}],\n        omid13: 'true',\n        skoverlay: '$skoverlay',\n        isAPI: 'false',\n        mraidJsUrl: 'https://i.l-ssp.inmobicdn.net/sdk/sdk/1056/ios/mraid.js',\n        isAdChoiceIconDisabled: isAdChoiceIconDisabled,\n        isSkOverlayDisabled: false,\n        dealId: '4263509857',\n        backendLoggingEnabled: 'false',\n\n    };\n    window.templateData = templateData;\n\n</script>\n\n<script>\n    var loggerConfig = {\n        SCALE:  0.001,\n    };\n    window.loggerConfig = loggerConfig;\n\n</script>\n\n<script src='https://supply.inmobicdn.net/template-rewrite/1.3.7/main.banner.1.3.7.1688982096.bundle.js'></script>\n\n        <div id=\"ad\">\n        <div id=\"child\">\n            <div id=\"parent_container\" style=\"position: relative; width: 100%; height: 100%\">\n    <div id=\"container\" style=\"background-color:rgba(0, 0, 0, 0.8); position: absolute;\">\n        <div class=\"image\">\n            <a href=\"https://www.inmobi.com/\">\n                <img id= \"image\" src=\"https://supply.inmobicdn.net/sandbox-prod-assets/Inmobi-320x50.jpg\" alt=\"inmobi-creative\" style=\"border-radius: 5px; height: 100vh; width: 100vw; object-fit:contain;\">\n            </a>\n        </div>\n    </div>\n</div>\n        </div>\n    </div>\n    </body>\n</html>\n", baseURL: nil)
        
        self.addSubview(webView)
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
           
           print("Start loading")
       }
       
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            self.loader.hideLoader()
           print("End loading")
       }
       
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           
           var action: WKNavigationActionPolicy?
           
                   defer {
                       decisionHandler(action ?? .allow)
                   }
           
                   guard let url = navigationAction.request.url else { return }
           
                   print(url)
           
                   if navigationAction.navigationType == .linkActivated, url.absoluteString.hasPrefix("https:") {
                       action = .cancel                  // Stop in WebView
                     
                               let config = SFSafariViewController.Configuration()
                               config.entersReaderIfAvailable = true

                               let vc = SFSafariViewController(url: url, configuration: config)
                       controller?.present(vc, animated: true)

                   }
//            switch navigationAction.navigationType {
//            case .linkActivated:
////                if navigationAction.targetFrame == nil {
////                    self.webView?.load(navigationAction.request)// It will load that link in same WKWebView
////
////                }
//            default:
//                break
//
//            }
//
//            if let url = navigationAction.request.url {
//                debugPrint(url.absoluteString) // It will give the selected link URL
//                UIApplication.shared.open(url)
//                decisionHandler(.cancel)
//
//            }
//            else {
//                decisionHandler(.allow)
//            }
           
       }
}
//extension HtmlViewAd: WKNavigationDelegate {
//
//
//}
