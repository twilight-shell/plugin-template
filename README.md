# twilight-shell/plugin-template

[![ci](https://github.com/twilight-shell/plugin-template/actions/workflows/ci.yml/badge.svg)](https://github.com/twilight-shell/plugin-template/actions/workflows/ci.yml)

A plugin for the [twilight-shell](https://github.com/twilight-shell) organization's
shell to start from: a card with a greeting in the bottom-left corner of the
screen, with settings you can change in the settings window and an IPC call that
hides and shows it. How plugins work is in the
[plugins](https://github.com/twilight-shell/plugins) README.

## Trying it

The repository is the plugin folder. Clone it into the folder the shell looks in,
under the name you want to give the plugin:

```sh
git clone git@github.com:twilight-shell/plugin-template.git \
    ~/.local/share/twilight-shell/plugins/my-plugin
```

Switch it on, in the settings window or in `~/.config/twilight-shell/plugins.toml`:

```toml
enabled = ["my-plugin"]
```

The card appears, a star appears in the bar that hides and shows it,
`my-plugin.toml` is made in `~/.config/twilight-shell/`, and the
settings window has a page called "My plugin".

```sh
qs -c shell ipc call my-plugin toggle      # hide it, show it again
```

## Making it your own

Press "Use this template" on the repository's page to get a repository of your own
with these files, and clone that into the plugins folder as above.

1. Pick a name, say `weather`: letters, digits, `-` and `_`.
2. In `plugin.toml` change `name`, `title`, `description` and `author`.
3. Rename `my-plugin.defaults.toml` and `my-plugin.schema.toml` to
   `weather.defaults.toml` and `weather.schema.toml`.
4. In `Plugin.qml` change the settings file's `name` and the file it points at
   (`ConfigFile`), and the IPC `target`.
5. Replace what the window and the bar island show with your own. Take the island
   out (the `barSlot` and `barWidget` properties) if the plugin doesn't need one.

| File | |
|---|---|
| `plugin.toml` | What the shell reads to find the plugin. |
| `Plugin.qml` | The file it starts from: any QML, usually a `Scope` that owns windows. |
| `<name>.defaults.toml` | The settings and their defaults, the only place the defaults are written. The settings file is made from it. |
| `<name>.schema.toml` | How the settings window shows them: a toggle, a range, a choice, a text or a command for each. Optional; without it the plugin has no page, and its file can still be edited by hand. |

Use `ConfigFile`, `Sticker`, `StyledText` and `Theme` from `Twilight.Core`, and the
plugin looks like the rest of the shell and follows its palette. Other
components can be imported the same way (`Twilight.Compositor` for the
workspaces and the focused window, say), as long as they are installed.

## Developing

Qt keeps the QML it has loaded, so after editing a file run
`qs -c shell ipc call plugins reload`, which loads the shell again. What is wrong
with a plugin that doesn't start is in the shell's log and in
`qs -c shell ipc call plugins list`.

Check the settings files without the shell: with the
[checks](https://github.com/twilight-shell/.github) and Qt's `qml` tool,

```sh
ci/check-settings.sh path/to/your-plugin path/to/core
```

## Sharing it

Plugins are code that runs with the rights of whoever switches them on, so say what
yours does in its README. If you share it as a repository, anyone can clone it
into their plugins folder as above.

## Contributing

Contributions are welcome: see [CONTRIBUTING.md](CONTRIBUTING.md). Agents and the like: [AGENTS.md](AGENTS.md).

## License

MIT, see `LICENSE`: change it to what you want for your own plugin.
