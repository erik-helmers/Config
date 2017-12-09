""" A simple ANSI colorization helper tool"""

__version__ = "1.0.0"

# Generated with talent
COLORS_NAME =[ 'BLACK', 'RED', 'GREEN', 'YELLOW',
               'BLUE', 'MAGENTA', 'CYAN', 'WHITE']

COLORS = {
    "black": '\033[30m',
    "red": '\033[31m',
    "green": '\033[32m',
    "yellow": '\033[33m',
    "blue": '\033[34m',
    "magenta": '\033[35m',
    "cyan": '\033[36m',
    "white": '\033[37m',

    "bg_black": '\033[40m',
    "bg_red": '\033[41m',
    "bg_green": '\033[42m',
    "bg_yellow": '\033[43m',
    "bg_blue": '\033[44m',
    "bg_magenta": '\033[45m',
    "bg_cyan": '\033[46m',
    "bg_white": '\033[47m',

    "light_black": '\033[90m',
    "light_red": '\033[91m',
    "light_green": '\033[92m',
    "light_yellow": '\033[93m',
    "light_blue": '\033[94m',
    "light_magenta": '\033[95m',
    "light_cyan": '\033[96m',
    "light_white": '\033[97m',

    "light_bg_black": '\033[100m',
    "light_bg_red": '\033[101m',
    "light_bg_green": '\033[102m',
    "light_bg_yellow": '\033[103m',
    "light_bg_blue": '\033[104m',
    "light_bg_magenta": '\033[105m',
    "light_bg_cyan": '\033[106m',
    "light_bg_white": '\033[107m'
}

HEADER = COLORS["magenta"]
OKBLUE = COLORS["blue"]
OKGREEN = COLORS["green"]
WARNING = COLORS["yellow"]
FAIL = COLORS["red"]


BOLD = '\033[1m'
UNDERLINE = '\033[4m'
ENDC = '\033[0m'

shortcuts = COLORS
shortcuts["ec"] = ENDC
shortcuts["bold"] = BOLD

shortcuts_none = {x: "" for x in shortcuts.keys()}


def colorize(s):
    return (s + "{ec}").format(
        **shortcuts
    )


def no_color(s):
    return s.format(
        **shortcuts_none

    )
