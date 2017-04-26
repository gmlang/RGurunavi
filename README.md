RGurunavi
=========

Overview
--------

A R wrapper of [Gurunavi's](https://www.gnavi.co.jp) API that supports 5 languages: Japanese, English, Simplified Chinese, Traditional Chinese, and Korean.

Click [here](http://api.gnavi.co.jp/api/index_e.html) for the official API doc.

You need an API key and ours is provided by default. To use your own, click [here](https://ssl.gnavi.co.jp/api/regist/?p=input) to register and obtain your own *key* first.

Installation
------------

``` r
install.packages("devtools")
devtools::install_github("gmlang/RGurunavi")
```

Usage
-----

Load it with:

``` r
library(RGurunavi)
```

Acquire Broad Areas 
``` r
get_areas(lang="en")
get_areas(lang="ja")
get_areas(lang="zh_cn")
get_areas(lang="zh_tw")
get_areas(lang="ko")
```

Acquire Prefectures
``` r
get_prefs(lang = "en")
get_prefs(lang = "ja")
get_prefs(lang = "zh_cn")
get_prefs(lang = "zh_tw")
get_prefs(lang = "ko")
``` 

Acquire Main Business Category 
``` r
get_bizcats(lang = "en")
get_bizcats(lang = "ja")
get_bizcats(lang = "zh_cn")
get_bizcats(lang = "zh_tw")
get_bizcats(lang = "ko")
```

Acquire Business Subcategory
``` r
get_bizsubcats(lang = "en")
get_bizsubcats(lang = "ja")
get_bizsubcats(lang = "zh_cn")
get_bizsubcats(lang = "zh_tw")
get_bizsubcats(lang = "ko")
```

Acquire Large Areas 
``` r
get_areas_large(lang = "en")
get_areas_large(lang = "ja")
get_areas_large(lang = "zh_cn")
get_areas_large(lang = "zh_tw")
get_areas_large(lang = "ko")
```

Acquire Area Middle Master API
``` r
get_areas_middle(lang = "en")
get_areas_middle(lang = "ja")
get_areas_middle(lang = "zh_cn")
get_areas_middle(lang = "zh_tw")
get_areas_middle(lang = "ko")
```

Acquire Small Areas
``` r 
get_areas_small(lang = "en")
get_areas_small(lang = "ja")
get_areas_small(lang = "zh_cn")
get_areas_small(lang = "zh_tw")
get_areas_small(lang = "ko")
```

Search Restaurants
``` r 
get_shops(lang = "en", pref = "PREF27", 
		  areacode_s = "AREAS3144", category_l = "RSFST02000",
		  card = 1)
get_shops(lang = "ja", pref = "PREF27",
          category_l = "RSFST02000", 
          category_s = "RSFST02001")
get_shops(lang = "zh_cn", pref = "PREF27",
          chinese_menu = 1, chinese_speaking = 1)
get_shops(lang = "zh_tw", pref = "PREF27",
          chinese_menu = 1, wifi = 1, card = 1)
get_shops(lang = "ko", pref = "PREF27", 
		  korean_speaking = 1, korean_menu = 1)
```
