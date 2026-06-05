# My dotfiles

Some of my dotfiles. Managed by [chezmoi](https://www.chezmoi.io/).

## Usage

### Load configs from this repo

- Load configs from my Github dotfiles repo on a new, empty machine:

  ```sh
  chezmoi init --apply jalaxy33
  ```

- Updating configs on any machine:

  ```sh
  chezmoi update
  ```

- Update certain config file, for example:

  ```sh
  chezmoi apply ~/.bashrc
  ```

### Sync with local changes

- Manage new configs:

  ```sh
  chezmoi add </path/to/config_file>
  ```

- After editing local configs, update all chezmoi managed configs by:

  ```sh
  chezmoi re-add
  ```

- Commit and push changes

  ```sh
  chezmoi cd
  git add -A
  git commit -m "<commit messages>"
  git push
  exit
  ```

### Check difference with managed files

- Check changed files:

  ```sh
  chezmoi status
  ```

- Check differences

  ```sh
  chezmoi diff
  ```

### Ignore files

Edit `.chezmoiignore`:

```sh
chezmoi cd
vi .chezmoiignore
```

Add files you want to ignore:

```.gitignore
README.md
```

### Manage machine-to-machine differences

Use [template](https://www.chezmoi.io/user-guide/templating/#editing-a-template-file) to manage machine-to-machine differences.

- Add files as template, for example:

  ```sh
  chezmoi add --template ~/.zshrc
  ```

  If a  file is already managed by chezmoi, but is not a template, you can make it a template by:

  ```sh
  chezmoi chattr +template ~/.zshrc
  ```

- Edit a template file:

  ```sh
  chezmoi edit ~/.zshrc
  ```

  Check [this tutorial](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/) for use cases.

- Check template variables:

  ```sh
  chezmoi data
  ```

- Test templates:

  ```sh
  chezmoi execute-template '{{ .chezmoi.hostname }}'
  ```
