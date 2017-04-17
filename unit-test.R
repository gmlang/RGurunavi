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
