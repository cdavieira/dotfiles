config.load_autoconfig()

#c.content.blocking.enabled = False
#c.url.default_page = "https://start.duckduckgo.com/"
#c.colors.webpage.darkmode.threshold.foreground = 120
#c.colors.webpage.darkmode.threshold.background = 255
#c.colors.webpage.darkmode.algorithm = "lightness-hsl"
#c.fonts.default_size = "10pt" # qutebrowser fontsize
#c.fonts.web.size.default = 18 # webpage fontsize
c.fonts.default_family = ["HackNerdFontMono-Italic", "FiraCodeNerdFontMono-Regular", "SourceCodeVF-Upright"]
c.zoom.default = 150
c.colors.webpage.darkmode.enabled = False
c.auto_save.session = False
c.colors.webpage.preferred_color_scheme = "dark"
c.downloads.location.directory = "~/temp/"
c.editor.command = ["kitty", "--config", "/home/carlos/.config/kitty/kitty.conf", "-c", "\"fish", "nvim", "{}", "\""]
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?hl=en&q={}",
    #:open dd something-something
    "d": "https://duckduckgo.com/?q={}",
    #:open yt something-something
    "y": "https://www.youtube.com/results?search_query={}",
    #:open w something-something
    "w": "https://en.wikipedia.org/wiki/{}",
    #:open ge something-something
    "v": "https://www.verbformen.com/?w={}",
    #:open t something-something
    "t": "https://translate.google.com/?hl=pt-BR&sl=en&tl=de&text={}&op=translate",
    #:open ig something-something
    # "i": "https://www.instagram.com/explore/tags/{}",
}

#config.bind('A', 'spawn zathura {url}', mode='normal')
#config.unbind('A', 'normal')

general = {
    "gpt": [
        "https://chat.openai.com/",
    ],
    "vim": [
        "https://www.vim.org/",
        "https://neovim.io/",
    ],
    "arch": [
        "https://archlinux.org/",
        "https://wiki.archlinux.org/",
        "https://wiki.archlinux.org/title/General_recommendations",
        "https://wiki.gentoo.org/wiki/Special:MyLanguage/Handbook:AMD64",
    ],
    "de": [
        "https://translate.google.com/?sl=en&tl=de&op=translate",
        "https://www.verbformen.com/",
    ],
    "misc": [
        "https://sw.kovidgoyal.net/kitty/",
        "https://fishshell.com/",
        "https://www.qutebrowser.org/",
        "https://git.pwmt.org/pwmt/zathura",
        "https://sr.ht/~exec64/imv/",
        "https://github.com/mpv-player/mpv",
    ],
    "dwl": [
        "https://codeberg.org/dwl/dwl",
        "https://wayland-book.com/",
        "https://wayland.freedesktop.org/docs/html/index.html",
        "https://wayland.app/protocols/",
    ],
}

code = {
    "assembly": [
        "https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_toc.html",
        "https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_3.html#SEC25",
        "https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_4.html",
        "https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_5.html",
        "https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_6.html",
        "https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_7.html#SEC90",
        "https://stackoverflow.com/questions/2529185/what-are-cfi-directives-in-gnu-assembler-gas-used-for",
        "https://sourceware.org/binutils/docs/as/index.html#SEC_Contents",
    ],
    "cpp": [
        "https://en.cppreference.com/w/",
        "https://cplusplus.com/",
    ],
    "rust": [
        "https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html", 
    ],
    "lua": [
        "https://www.lua.org/manual/5.4/",
    ],
    "js": [
        "https://developer.mozilla.org/en-US/docs/Web/javascript",
        "https://www.w3schools.com/Js/js_es6.asp",
        "https://www.w3schools.com/js/js_htmldom.asp",
        "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise",
    ],
    "ts": [
        "https://www.typescriptlang.org/docs/handbook/intro.html",
    ],
    "react": [
        "https://react.dev/learn",
        "https://en.wikipedia.org/wiki/JSX_(JavaScript)",
    ],
    "combo": [
        "https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html",
    ],
}

pick = code["combo"]
c.url.start_pages = [pick[0]]
if len(pick) > 1:
    c.url.start_pages.extend(pick[1:])
