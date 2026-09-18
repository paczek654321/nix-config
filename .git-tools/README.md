Before making any changes, enable the repository's Git configuration to prevent sensitive data, such as your location (tracked by Noctalia), from being committed.
```bash
git config --local include.path ../.git-tools/gitconfig
```