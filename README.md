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

### (Optional) Update remote configs

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
  ```
