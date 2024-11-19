import os

config.load_autoconfig()

c.new_instance_open_target = "tab-silent"

c.auto_save.session = True

#c.colors.webpage.darkmode.threshold.foreground = 120
#c.colors.webpage.darkmode.threshold.background = 255
#c.colors.webpage.darkmode.algorithm = "lightness-hsl"
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = False

#c.content.blocking.enabled = False
c.content.autoplay = False
c.content.images = True

c.downloads.location.directory = "~/temp/"

c.editor.command = ["kitty", "--config", "/home/carlos/.config/kitty/kitty.conf", "-c", "\"bash", "vim", '{}']

# fonts can be found in '/usr/share/fonts/TTF/'
#c.fonts.default_size = "10pt" # qutebrowser fontsize
#c.fonts.web.size.default = 18 # webpage fontsize
c.fonts.default_family = ["Liberation Mono"
                          "SymbolsNerdFontMono-Regular",
                          "HackNerdFontMono-Italic",
                          "FiraCodeNerdFontMono-Regular",
                          "SourceCodeVF-Upright"]

c.session.lazy_restore = True

c.tabs.last_close = "startpage"

c.zoom.default = 150

#config.unbind('A', 'normal')
#config.bind('A', 'spawn zathura {url}', mode='normal')

#c.url.default_page = "https://start.duckduckgo.com/"
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?hl=en&q={}",
    "d": "https://duckduckgo.com/?q={}",
    "y": "https://www.youtube.com/results?search_query={}",
    "wi": "https://en.wikipedia.org/wiki/{}",
    "w": "https://wiki.archlinux.org/?search={}",
    "v": "https://www.verbformen.com/?w={}",
    "t": "https://translate.google.com/?hl=pt-BR&sl=en&tl=de&text={}&op=translate",
    "l": "https://www.linguee.com.br/alemao-portugues/traducao/{}.html",
}
# "https://start.duckduckgo.com/"
# "https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html"
# "https://www.vim.org/",
# "https://neovim.io/",
# "https://archlinux.org/",
# "https://wiki.archlinux.org/",
# "https://wiki.gentoo.org/wiki/Handbook:AMD64",
# "https://www.lua.org/manual/5.4/",
# "https://www.typescriptlang.org/docs/handbook/intro.html",
# "https://developer.mozilla.org/en-US/docs/Web/javascript",
c.url.start_pages = ["https://start.duckduckgo.com/"]
