# SYWebViewBridge Contributing Guide

> This is adapted from [vue-next commit convention](https://github.com/vuejs/vue-next/blob/master/.github/contributing.md).

Hi! I'm really excited that you are interested in contributing to SYWebViewBridge. Before submitting your contribution, please make sure to take a moment and read through the following guidelines.

## Pull Request Guidelines

- Checkout a topic branch from a base branch, e.g. `master`, and merge back against that branch.

- If adding a new feature:

  - Add accompanying test case.
  - Provide a convincing reason to add this feature. Ideally, you should open a suggestion issue first and have it approved before working on it.

- If fixing a bug:

  - If you are resolving a special issue, add `(fix #xxxx[,#xxxx])` (#xxxx is the issue id) in your PR title for a better release log, e.g. `update async call (fix #666)`.
  - Provide a detailed description of the bug in the PR. Live demo preferred.
  - Add appropriate test coverage if applicable.

- It's OK to have multiple small commits as you work on the PR - GitHub can automatically squash them before merging.

- Make sure tests pass!

- Commit messages must follow the [commit message convention](./commit-convention.md) so that changelogs can be automatically generated. Commit messages are automatically validated before commit (by invoking [Git Hooks](https://git-scm.com/docs/githooks) via [husky](https://github.com/typicode/husky)).


## Development Setup

You will need Xocde, and VSCode.

After cloning the repo, run:

A high level overview of tools used:


## Project Structure

- `packages`: Inclued iOS and FE.
- `iOS`: The iOS project.
- `FE`: The FE project.


## Contributing Tests

Unit tests are collocated with the code being tested in each package, inside directories named `__tests__`. 

## Credits

Thank you to all the people who have already contributed to SYWebViewBridge.js!

## Public Docs

`npm run docs:build`