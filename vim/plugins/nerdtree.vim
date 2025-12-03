vim9script

# disallow NERDTree extension from creating unwanted mappings
g:NERDCreateDefaultMappings = 0

g:NERDTreeBookmarksFile = getenv('MYVIM_CACHE_DIR') .. "/NERDTreeBookmarks"

g:NERDTreeShowHidden = 1
