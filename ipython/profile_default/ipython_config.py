from os.path import expanduser
from os import system
from os import environ
home = expanduser("~")
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalIPythonApp.display_banner = False
c.InteractiveShellApp.exec_lines = [
    'import numpy as np',
]
c.InteractiveShellApp.exec_files = [
]
c.InteractiveShell.confirm_exit = True
c.InteractiveShell.editor = 'vim'


if "TMUX" in environ:
    system("tmux set-window-option window-status-current-style 'fg=black bg=green'; tmux set-window-option window-status-style 'fg=green' ; tmux rename-window ipython")

# c.PromptManager.in_template  = 'In [\#]: '
# c.PromptManager.in2_template = '   .\D.: '
# c.PromptManager.out_template = 'Out[\#]: '
# c.PromptManager.justify = True
