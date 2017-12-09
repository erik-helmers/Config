#!/usr/bin/env python
# WOW NICE THEME
# BY E.H.

# Not using docopt for speed reasons ?
# import docopt

import sys
import os
import subprocess as sb
import string
from coloration import colorize as clr

DEFAULT_USERNAME = "erikh"
DEFAULT_PYTHON_VERSION = "3.6.3"

GIT_STATUS = {
    "A": "A",
    "M": "M",
    "D": "D",
    "R": "R",
    "?": '{red}{bold}!{ec}',
    " ": ""
}


__doc__ = """
E.H.'s prompt.

Usage:
  _get_prompt.py left
  _get_prompt.py right <lastexitcode>

Options:
  -h --help                            Show this screen.
  --version                            Show version.
"""


PROMPT_COLORS = {
    "black": "%{\033[30m%}",
    "red": "%{\033[31m%}",
    "green": "%{\033[32m%}",
    "yellow": "%{\033[33m%}",
    "blue": "%{\033[34m%}",
    "magenta": "%{\033[35m%}",
    "cyan": "%{\033[36m%}",
    "white": "%{\033[37m%}",

    "bg_black": "%{\033[40m%}",
    "bg_red": "%{\033[41m%}",
    "bg_green": "%{\033[42m%}",
    "bg_yellow": "%{\033[43m%}",
    "bg_blue": "%{\033[44m%}",
    "bg_magenta": "%{\033[45m%}",
    "bg_cyan": "%{\033[46m%}",
    "bg_white": "%{\033[47m%}",

    "light_black": "%{\033[90m%}",
    "light_red": "%{\033[91m%}",
    "light_green": "%{\033[92m%}",
    "light_yellow": "%{\033[93m%}",
    "light_blue": "%{\033[94m%}",
    "light_magenta": "%{\033[95m%}",
    "light_cyan": "%{\033[96m%}",
    "light_white": "%{\033[97m%}",

    "light_bg_black": "%{\033[100m%}",
    "light_bg_red": "%{\033[101m%}",
    "light_bg_green": "%{\033[102m%}",
    "light_bg_yellow": "%{\033[103m%}",
    "light_bg_blue": "%{\033[104m%}",
    "light_bg_magenta": "%{\033[105m%}",
    "light_bg_cyan": "%{\033[106m%}",
    "light_bg_white": "%{\033[107m%}",

    "bold": "%{\033[1m%}",
    "ec": "%{\033[0m%}"
}

PROMPT_NO_COLORS = {x: "" for x in PROMPT_COLORS.keys()}


class FormatDict(dict):
    def __missing__(self, key):
        return "{" + key + "}"


FORMATTER = string.Formatter()
MAPPING = FormatDict(**PROMPT_COLORS)
NMAPPING = FormatDict(**PROMPT_NO_COLORS)


def clr(s):
    # return s.format(**PROMPT_COLORS)
    return FORMATTER.vformat(s + "{ec}", (), MAPPING)


def nclr(s):
    return FORMATTER.vformat(s, (), NMAPPING)


def partial_format(s, **kwargs):
    return FORMATTER.vformat(s, (), FormatDict(kwargs))


def path_split(path, remove=None):

    output = []
    path = path.split("/")

    if path[-1] == "":
        path.pop()
    return path


def truncate_path(path, max_len):

    # Check case "/", or "~"

    output = []
    actual_len = 0
    i = 0

    while actual_len <= max_len and i < len(path):
        dir_name_len = len(path[-1 - i])
        if dir_name_len + actual_len <= max_len:
            output.append(path[-1 - i])
            actual_len += dir_name_len
        elif len(output) == 0:
            return [path[-1 - i]], not (1 == len(path))
        else:
            break
        i += 1
    output.reverse()

    return output, not (len(output) == len(path))


def path_list_to_string(path):
    if path[0] == "" and len(path) == 1:
        path[0] = "/"
    return "/".join(path)


def reduce_path(origin="/home/erikh", origin_sym_color="~",
                origin_sym="", max_len=20, path=None):

    if path is None:
        path = os.getcwd()

    if path[-1] != "/":
        path += "/"

    if origin[-1] != "/":
        origin += "/"

    removed_origin = path.startswith(origin)
    if removed_origin:
        path = path[len(origin):]
        if len(path) > 0 and path[0] == "/":
            path = path[1:]

    path = path_split(path)

    if removed_origin:
        max_len -= len(origin_sym) + 1  #  +1 for "/" space

    path, truncated = truncate_path(path, max_len)

    if truncated:
        path.insert(0, "…")
    if removed_origin:
        path.insert(0, "")
    if removed_origin and path == [""]:
        return origin_sym_color, ""
    return origin_sym_color, path_list_to_string(path)


def parse_git_status(status):

    output = {x: False for x in ["A", "M", "D", "R", "C", "?", " "]}

    for x in status:
        try:
            output[x[1]] = True
        except IndexError:
            pass
    return output


def format_git_status(parsed):
    output = []
    for k, v in parsed.items():
        if v:
            output.append(GIT_STATUS[k])
    return "".join(output)


def get_git_status():

    gitproc = sb.Popen(["git", "status", "--porcelain"], stdout=sb.PIPE)
    gitproc.wait()
    status = gitproc.communicate()[0].decode("utf-8")

    parsed = parse_git_status(status.split("\n"))

    return format_git_status(parsed)


def get_git_root_dir():

    gitproc = sb.Popen(["git", "rev-parse", "--show-toplevel"], stdout=sb.PIPE)
    gitproc.wait()
    return gitproc.communicate()[0].decode("utf-8")[:-1]


class NotGitDir(Exception):
    pass


def get_git_infos():

    gitproc = sb.Popen(["git", "rev-parse", "--is-inside-work-tree"],
                       stdout=sb.DEVNULL, stderr=sb.DEVNULL)
    gitproc.wait()

    if gitproc.returncode != 0:
        raise NotGitDir()
    return get_git_root_dir(), get_git_status()


def get_python_env():

    python_env = os.environ.get("VIRTUAL_ENV")
    if python_env is None or python_env == "":
        return ""
    else:
        return "{light_green}({bold}{yellow}%s{ec}{light_green}){ec}" % (path_split(python_env)[-1])


def left_prompt():
    """Return left prompt (PROMPT)"""
    try:
        rootDir, gitStatus = get_git_infos()
        rootSym = os.path.split(rootDir)[1]
        rootSym_color = "{magenta}{bold}%s{ec}" % (rootSym)
    except NotGitDir:
        rootDir, gitStatus = "/home/erikh", ""
        rootSym = "~"
        rootSym_color = "{blue}{bold}~{ec}"

    #rootSym_color = DIR_ROOT_SYM % (rootSym)
    sym, reductedPath = reduce_path(rootDir, rootSym_color, rootSym)

    #print(sym,reductedPath, " ", gitStatus, "➜ ", sep="")

    valued = partial_format("{sym}{light_magenta}{path}{ec} {git_status}{python_env}{light_black}{bold} > {ec}",
                            sym=sym, path=reductedPath, git_status=gitStatus, python_env=get_python_env())

    print(clr(valued))


def right_prompt(x):
    """Return right prompt (RPROMPT)"""

    if x != 0:
        print(clr("{yellow}[{bold}%s{ec}{yellow}]{ec}" % (x)))


def print_usage():
    """Print usage"""
    print(__doc__)


def main():

    args = sys.argv[1:]

    if 1 <= len(args) <= 2:
        if args[0] == "left" and len(args) == 1:
            return left_prompt()
        elif args[0] == "right"and len(args) == 2:
            return right_prompt(int(args[1]))
    print_usage()
    sys.exit(128)


main()
