# Solarmicrobe Homebrew Tap

Homebrew formulas for Solarmicrobe-maintained forks and tools.

## ghq

This tap packages the Solarmicrobe fork of `ghq` from:

<https://github.com/solarmicrobe/ghq>

Install:

```sh
brew install solarmicrobe/tap/ghq
```

If Homebrew core's `ghq` formula is already installed, unlink or remove it first:

```sh
brew unlink ghq
brew install solarmicrobe/tap/ghq
```

Upgrade after a new Solarmicrobe fork release:

```sh
brew update
brew upgrade solarmicrobe/tap/ghq
```

## Formula updates

`Formula/ghq.rb` is updated by `.github/workflows/update-ghq-formula.yaml`.
The workflow accepts a `ghq_release` repository dispatch event from
`solarmicrobe/ghq`, downloads the release archives, computes Homebrew SHA-256
values, validates the formula, and commits the update.

Manual update:

```sh
ruby scripts/update-ghq-formula.rb v1.10.1-solarmicrobe.2
brew audit --strict --formula solarmicrobe/tap/ghq
brew style solarmicrobe/tap/ghq
brew fetch --formula solarmicrobe/tap/ghq
```
