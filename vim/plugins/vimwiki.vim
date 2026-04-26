vim9script

# References:
#   https://mkaz.blog/working-with-vim/vimwiki/
#   https://www.youtube.com/watch?v=nQSUyc2OQ48

g:vimwiki_list = [
	{
		'path': '~/vimwiki',
		'syntax': 'markdown',
		'ext': '.md'
	}
]

# Setting ext to .md will set all our markdown fiels to Vimwiki syntax. We can prevent that by setting the following option
g:vimwiki_global_ext = 0

# Highlight checked list items
g:vimwiki_hl_cb_checked = 1

# Generate an automatic header for the wiki files
g:vimwiki_auto_header = 1
