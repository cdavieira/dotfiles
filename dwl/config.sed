# amazing sed guide: https://www.grymoire.com/Unix/Sed.html#uh-0
# regular expressions: https://www.grymoire.com/Unix/Regular.html

# disable sloppyfocus
/^static const int sloppyfocus/ s/1/0/g

# remove any Rule from rules[]
# \[ and \] because [ and ] are regex operators (example: [0-9])
/^static const Rule rules\[\] = {/,/^};/ {
	# skip blanks any number of times, {, skip blanks any number of times, "Gimp
	/\s*{\s*"Gimp/ d

	# replace what's inside {} with a null Rule object (taken from
	# https://dwm.suckless.org/customisation/noapps/)
	s/\(\s*\){\(.*\)}/\1{ NULL,  NULL,       0,       0,           -1 }/
}

# setup keyboard layout
/^static const struct xkb_rule_names xkb_rules = {/,/}/ {
	# ignoring line comments
	/\s*\.options = NULL/ c\
\t.rules = "evdev", \
\t.model = "pc105", \
\t.layout = "br",   \
\t.options = NULL,
}

# enable smoother mouse cursor movement
/^static const int repeat_rate/ s/25/40/
/^static const int repeat_delay/ s/600/400/

# disable trackpad and enable only external mouses
/^static const uint32_t send_events_mode =/ s/LIBINPUT_CONFIG_SEND_EVENTS_ENABLED/LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE/

# change modkey from alt to super (windows/unix key)
/^#define\s*MODKEY/ s/ALT/LOGO/

# add FISHCMD wrapper
/#define\s*SHCMD(cmd)/ a\
#define FISHCMD(cmd) { .v = (const char*[]){ "/usr/bin/fish", "-c", cmd, NULL } }

# setup terminal commands for execvp
/static const char \*termcmd/ s/foot/kitty/
/static const char \*menucmd/ {
	s/wmenu/bemenu/
	a\
static const char *waybarcmd[] = { "waybar", NULL };
	a\
static const char *browsercmd[] = { "qutebrowser", NULL };
	a\
static const char * const screenshotcmd = "slurp | grim -g - - | swappy -f -";
	a\
static const char * const screencapturecmd = "wf-recorder -g \\"$(slurp)\\" --audio --file=recording-$(date +%Y%m%d-%H%M%S).mp4";
}

# custom keybindings
/static const Key keys\[\] = {/ {
	i\
//xkb keynames can be found in:
	i\
//#include <xkbcommon/xkbcommon-keysyms.h>
	i\
//#include <linux/input-event-codes.h>
}
/\s*\/\*\s*modifier/ {
	a\
	{ MODKEY,                    XKB_KEY_a,          spawn,          {.v = waybarcmd} },
	a\
	{ MODKEY,                    XKB_KEY_b,          spawn,          {.v = browsercmd} },
	a\
	{ MODKEY,                    XKB_KEY_s,          spawn,          SHCMD(screenshotcmd)},
	a\
	{ MODKEY,                    XKB_KEY_r,          spawn,          FISHCMD(screencapturecmd)},
}

