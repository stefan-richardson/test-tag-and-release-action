# 🚀 Auto Tag and Release Action

A reusable **composite GitHub Action** for automatically tagging, releasing, and preparing the next development snapshot for Java/Gradle projects. Built on [Conventional Commits](https://www.conventionalcommits.org/) and customizable for use across multiple repositories.

---

## 📋 Table of Contents

- [Features](#-features)
- [Usage](#-usage)
- [Inputs](#-inputs)
- [Outputs](#-outputs)
- [Examples](#-examples)
- [Required Secrets](#-required-secrets)
- [Gradle Project Requirements](#-gradle-project-requirements)
- [Tag Format](#-tag-format)
- [Commit Message Format](#-commit-message-format)
- [Dry Run Mode](#-dry-run-mode)
- [Contributing](#-contributing)
- [Versioning](#-versioning)
---

## ✨ Features

- 🔍 Parses commit messages to determine semantic version bump
- 🏷️ Automatically generates and pushes version tags
- 📦 Publishes artifacts to Artifactory
- 🔄 Runs `nextSnapshot` to prep the next development version
- 💬 Supports custom tag prefixes
- 🧪 Dry run support for safe testing
- ☕ Works with Java 8, 11, or 17

---

## 🔧 Usage

```yaml
name: Auto Tag and Release

on:
  push:
    branches:
      - develop

jobs:
  auto-tag:
    runs-on: ubuntu-latest
    steps:
      - name: Auto Tag Action
        uses: stefan-richardson/test-tag-and-release-action@v1
        with:
          commit_message: ${{ github.event.head_commit.message }}
          java_version: "11"
          tag_prefix: "my-library"
          dry_run: "false"
```
## 🛠️ Inputs
| Name           | Required | Default | Description                                                 |
|----------------|----------|---------|-------------------------------------------------------------|
| commit_message | ✅        |         | The commit message to parse and determine version increment |
| tag_prefix     | ✅        |         | Prefix used for Git tag (e.g., my-library)                  |
| java_version   | ❌        | 8	      | Java version to use: 8, 11, or 17                           |
| dry_run        | ❌        | false   | If true, prints what would happen without making changes    |

## 📤 Outputs
This action does not return outputs directly, but it:
- Tags the commit with the new version
- Publishes to Artifactory (unless in dry run)
- Commits the next snapshot version

## 💡 Examples
✅ Full workflow with real tag and release
```
- uses: your-org/auto-tag-action@v1
  with:
    commit_message: ${{ github.event.head_commit.message }}
    java_version: "11"
    tag_prefix: "my-library"
    dry_run: "false"
```
## 🧪 Dry run (no tag or release)
```
- uses: your-org/auto-tag-action@v1
  with:
    commit_message: ${{ github.event.head_commit.message }}
    tag_prefix: "my-library"
    dry_run: "true"
```
## 🔐 Required Secrets

| Secret Name           | Description                                 |
|-----------------------|---------------------------------------------|
| `SSH_KEY_GITHUB`      | SSH key with write access to push tags      |
| `ARTIFACTORY_API_KEY` | API key for authenticating with Artifactory |

## ⚙️ Gradle Project Requirements
This action assumes your project implements the following Gradle task:

- artifactoryPublish
➜ Publishes artifacts to your repository

## 🏷️ Tag Format
Tags are generated using this format:
```
<tag_prefix>-<version>
```
Example:
```
my-library-1.4.0
```
You can set tag_prefix via the workflow input.

## 📝 Commit Message Format
This action uses Conventional Commits to determine version increments:

| Commit Message                   | Increment Type         |
|----------------------------------|------------------------|
| `fix(scope): message`            | Patch                  |
| `feat(scope): message`           | Minor                  |
| `feat(scope)!: message`          | Major                  |
| `refactor(scope): message`       | Patch                  |
| Invalid or non-standard messages | ❌ Workflow fails early |

## 🧪 Dry Run Mode
To preview what the action would do — without tagging, publishing, or pushing — set:
```
dry_run: "true"
```
It will:
- Parse the commit
- Show the version that would be tagged
- Skip Git tag creation, Artifactory publish, and snapshot bump

## 🤝 Contributing
Contributions are welcome! To get started:
1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Submit a pull request
For feature ideas or bugs, open an issue.

## 📦 Versioning
This project follows Semantic Versioning. Releases are published with tags like v1.0.0. Use the major version for reference:
```
uses: stefan-richardson/auto-tag-action@v1

```

