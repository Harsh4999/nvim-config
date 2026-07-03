# Neovim Keybindings Cheatsheet

Leader key: `Space`

## Terminals
| Key | Action |
|-----|--------|
| `<leader>1-5` | Toggle numbered terminal (1-5) |
| `<leader>st` | Toggle default terminal |
| `<leader>0` | Hide ALL terminals |
| `Ctrl-h/j/k/l` | Navigate between windows (works in terminal too) |
| `Ctrl-\ Ctrl-n` | Exit terminal mode to normal mode |

## Git
| Key | Action |
|-----|--------|
| `<leader>gg` | **Lazygit** - Full floating git UI |
| `<leader>gD` | Diffview - Side-by-side diffs |
| `<leader>gh` | File history (current file) |
| `<leader>gH` | File history (all files) |
| `<leader>gq` | Close Diffview |
| `<leader>gn` | Neogit - Magit-style interface |
| `<leader>gs` | Git status picker |
| `<leader>gd` | Git diff hunks |
| `<leader>gb` | Git branches |
| `<leader>gl` | Git log |
| `<leader>gL` | Git log (current line) |
| `<leader>gf` | Git log (current file) |
| `<leader>gS` | Git stash |
| `<leader>gB` | Git browse (open in browser) |

## File Navigation
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>sf` | Find files |
| `<leader>fg` | Find git files |
| `<leader>fr` | Recent files |
| `<leader>/` | Grep (search in files) |
| `<leader><space>` | Smart find files |
| `<leader>,` | Open buffers |

## LSP / Code
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `<leader>ss` | LSP symbols (current file) |
| `<leader>sS` | LSP symbols (workspace) |
| `<leader>sd` | Diagnostics |

## Splits
| Key | Action |
|-----|--------|
| `<leader>\|` | Vertical split (same file) |
| `<leader>-` | Horizontal split (same file) |
| `<leader>sx` | Close split |
| `<leader>se` | Equal split sizes |
| `Ctrl-h/j/k/l` | Navigate between splits |
| `Ctrl-w >/<` | Increase/decrease width |
| `Ctrl-w +/-` | Increase/decrease height |

## Buffers
| Key | Action |
|-----|--------|
| `<leader>bd` | Close buffer |
| `<leader>,` | Buffer picker |

## Search
| Key | Action |
|-----|--------|
| `<leader>sg` | Grep |
| `<leader>sw` | Search word under cursor |
| `<leader>sb` | Search buffer lines |
| `<leader>sh` | Help pages |
| `<leader>sk` | Keymaps |
| `<leader>sm` | Marks |
| `<leader>s"` | Registers |

## UI Toggles
| Key | Action |
|-----|--------|
| `<leader>z` | Zen mode |
| `<leader>Z` | Zoom current window |
| `<leader>ud` | Toggle diagnostics |
| `<leader>ul` | Toggle line numbers |
| `<leader>uw` | Toggle word wrap |
| `<leader>us` | Toggle spelling |

## Claude Code
| Key | Action |
|-----|--------|
| `<leader>cc` | Claude with open buffers context |
| `<leader>ct` | Claude with Terraform context |
| `Ctrl-,` | Toggle Claude Code |
| `Esc Esc` | Close Claude float (in terminal mode) |

## Other
| Key | Action |
|-----|--------|
| `<leader>?` | Show this keybindings cheatsheet |
| `<leader>:` | Command history |
| `<leader>n` | Notifications history |
| `;` | Enter command mode (same as `:`) |
| `jk` | Exit insert mode (same as `Esc`) |
| `Ctrl-l` | Accept Copilot suggestion (insert mode) |

## Lazygit Controls (inside lazygit)
| Key | Action |
|-----|--------|
| `j/k` | Navigate |
| `Space` | Stage/unstage |
| `c` | Commit |
| `p` | Push |
| `P` | Pull |
| `b` | Branches |
| `?` | Show all keybinds |
| `q` | Quit |
