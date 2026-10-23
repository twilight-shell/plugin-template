# Contributing to plugin-template

Thank you for helping. The guide for every repository of the organization is [here](https://github.com/twilight-shell/.github/blob/main/CONTRIBUTING.md): how to propose a change, the commit messages, the checks and the code style. What follows is what is particular to this repository.

## Working on it

- **What it needs:** Twilight.Core. Clone them next to this one and put their parent folders on `QML_IMPORT_PATH`, separated by `:`, as full paths (not `~`).
- **Try it:** Copy it into a plugins folder under the name you give it (see the README), and switch it on.
- **Tests:** there is no test for the screen: run it and look, and say in the pull request what you tried and on which compositor.
- **Before sending:** run the checks of the guide (`ci/run-tests.sh`, `check-settings.sh`, `check-depends.sh`, `check-install.sh` from the `.github` repository) and add a line to `CHANGELOG.md` under `## Unreleased`.

## Good to know

- Keep it small and readable: it is what people copy. If the plugin interface changes, change this to match and say so in the changelog.

For security problems, please don't open an issue: see [SECURITY.md](https://github.com/twilight-shell/.github/blob/main/SECURITY.md).
