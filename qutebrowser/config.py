config.load_autoconfig()

#c.content.blocking.enabled = False
#c.url.default_page = "https://start.duckduckgo.com/"
#c.fonts.default_size = "10pt" # qutebrowser fontsize
#c.fonts.web.size.default = 16 # webpage fontsize
#c.colors.webpage.darkmode.enabled = True
#c.colors.webpage.darkmode.threshold.foreground = 120
#c.colors.webpage.darkmode.threshold.background = 255
#c.colors.webpage.darkmode.algorithm = "lightness-hsl"
c.colors.webpage.preferred_color_scheme = "dark"
c.auto_save.session = True
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
    "vim": [
        "https://www.vim.org/",
        "https://neovim.io/",
    ],
    "arch": [
        "https://archlinux.org/",
        "https://wiki.archlinux.org/",
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
        "https://wayland.freedesktop.org/docs/html/index.html",
        "https://wayland.app/protocols/",
    ],
}

code = {
    "cpp": {
        "https://en.cppreference.com/w/",
        "https://cplusplus.com/",
    },
    "rust": [
        "https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html", 
    ],
    "lua": {
        "https://www.lua.org/manual/5.4/",
    },
    "js": {
        "https://developer.mozilla.org/en-US/docs/Web/javascript",
        "https://www.w3schools.com/Js/js_es6.asp",
        "https://www.w3schools.com/js/js_htmldom.asp",
        "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise",
    },
    "ts": {
        "https://www.typescriptlang.org/docs/handbook/intro.html",
    },
    "react": {
        "https://react.dev/learn",
        "https://en.wikipedia.org/wiki/JSX_(JavaScript)",
    },
}

c.url.start_pages = [
    "https://chat.openai.com/"
]

c.url.start_pages.extend(general["arch"])
