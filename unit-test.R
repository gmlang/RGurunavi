rm(list = ls())

# set paths
r_path = "R"
for (fname in list.files(r_path)) source(file.path(r_path, fname))

# Acquire Area Master API
get_areas(lang="en")
get_areas(lang="ja")
get_areas(lang="zh_cn")
get_areas(lang="zh_tw")
get_areas(lang="ko")

# Acquire Prefecture Master API
get_prefs(lang = "en")
get_prefs(lang = "ja")
get_prefs(lang = "zh_cn")
get_prefs(lang = "zh_tw")
get_prefs(lang = "ko")

# TODO: write a script to merge areas and prefectures

# Acquire Main Business Category Master API
get_bizcats(lang = "en")
get_bizcats(lang = "ja")
get_bizcats(lang = "zh_cn")
get_bizcats(lang = "zh_tw")
get_bizcats(lang = "ko")

# Acquire Business Subcategory Master API
get_bizsubcats(lang = "en")
get_bizsubcats(lang = "ja")
get_bizsubcats(lang = "zh_cn")
get_bizsubcats(lang = "zh_tw")
get_bizsubcats(lang = "ko")

# Acquire Area Large Master API
head(get_areas_large(lang = "en"))
head(get_areas_large(lang = "ja"))
head(get_areas_large(lang = "zh_cn"))
head(get_areas_large(lang = "zh_tw"))
head(get_areas_large(lang = "ko"))

# Acquire Area Middle Master API
head(get_areas_middle(lang = "en"))
head(get_areas_middle(lang = "ja"))
head(get_areas_middle(lang = "zh_cn"))
head(get_areas_middle(lang = "zh_tw"))
head(get_areas_middle(lang = "ko"))

# Acquire Area Small Master API
head(get_areas_small(lang = "en"))
head(get_areas_small(lang = "ja"))
head(get_areas_small(lang = "zh_cn"))
head(get_areas_small(lang = "zh_tw"))
head(get_areas_small(lang = "ko"))
