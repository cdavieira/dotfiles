config.load_autoconfig()

c.auto_save.session = True
c.downloads.location.directory = "~/temp/"
#c.colors.webpage.darkmode.enabled = True
c.editor.command = ["nvim", "{}"]

start_pages = {
    0: [
        "https://duckduckgo.com",
    ],
    1: [
        "https://archlinux.org/",
        "https://wiki.archlinux.org/",
    ],
    2: [
        "https://sw.kovidgoyal.net/kitty/",
        "https://fishshell.com/",
        "https://www.qutebrowser.org/",
        "https://github.com/djpohly/dwl",
        "https://awesomewm.org/",
        "https://neovim.io/",
    ],
    3: [
        "https://sw.kovidgoyal.net/kitty/overview/",
        "https://fishshell.com/docs/current/index.html",
        "https://qutebrowser.org/doc/help/settings.html",
        "https://dwm.suckless.org/customisation/",
        "https://github.com/djpohly/dwl/wiki",
        "https://awesomewm.org/apidoc/index.html",
        "https://neovim.io/doc/user/vim_diff.html#nvim-features",
        "https://neovim.io/doc/user/lua.html",
    ],
    4: [
        "https://doc.rust-lang.org/book/ch03-01-variables-and-mutability.html", 
        "https://en.cppreference.com/w/",
        "https://www.lua.org/manual/5.4/",
    ],
    5: {
        "https://www.typescriptlang.org/docs/handbook/intro.html",
        "https://react.dev/learn",
    },
    6: {
        "https://developer.mozilla.org/en-US/docs/Web/javascript",
        "https://en.wikipedia.org/wiki/JSX_(JavaScript)",
        "https://www.w3schools.com/Js/js_es6.asp",
        "https://www.w3schools.com/js/js_htmldom.asp",
        "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise",
    },
    7: {
        "https://wiki.archlinux.org/title/NVIDIA",
        "https://wiki.archlinux.org/title/Nouveau",
        "https://wiki.archlinux.org/title/NVIDIA_Optimus",
    },
    8: {
        #
    }
}

c.url.start_pages = [
    "https://chat.openai.com/"
    #"https://raw.githubusercontent.com/qutebrowser/qutebrowser/main/doc/img/cheatsheet-big.png"
]

c.url.start_pages.extend(start_pages[4])
