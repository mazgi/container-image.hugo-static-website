# /tag - Hugo version update and git tag creation

Perform the full Hugo version update pipeline: fetch the latest version, update the Dockerfile, commit, create a git tag, and push.

## Steps

### 1. Pre-check: Uncommitted changes

Run `git status` to check for uncommitted changes. If there are any unstaged or staged changes, **abort** and inform the user to commit or stash their changes first.

### 2. Fetch the latest Hugo version

Access the Hugo releases page at `https://github.com/gohugoio/hugo/tags` to determine the latest stable release version.

- Ignore pre-release versions (e.g., versions with `-rc`, `-beta`, `-alpha` suffixes).
- Version selection rule: For each minor version group (same `x.y`), only the highest patch version (`z`) is a valid candidate. Intermediate patch versions must be skipped.
  - Example: If `0.159.0`, `0.159.1`, `0.159.2` exist, only `0.159.2` is considered.
- From the valid candidates, select the one with the highest version as the target.
- Compare it with the current version in `Dockerfile.d/hugo-static-website/Dockerfile` (`ARG HUGO_VERSION=...`).
- If the latest version is the same as the current version, inform the user and ask whether to proceed with creating a tag for the current version anyway (in case a tag hasn't been created yet) or abort.

### 3. Update the Dockerfile

Update the `ARG HUGO_VERSION=` line in `Dockerfile.d/hugo-static-website/Dockerfile` to the new version.

### 4. Commit the change

Create a commit with the message: `update hugo version to {VERSION}`

Follow the project's commit conventions (see CLAUDE.md).

### 5. Determine the tag name

The tag format is: `hugo-{HUGO_VERSION}-{YYYY}.{M}.{PATCH}`

- `{HUGO_VERSION}` is the Hugo version (e.g., `0.159.1`)
- `{YYYY}` is the current year (e.g., `2026`)
- `{M}` is the current month without zero-padding (e.g., `4` for April)
- `{PATCH}` is determined by checking existing tags:
  - List all tags matching `hugo-{HUGO_VERSION}-{YYYY}.{M}.*`
  - If no matching tags exist, use `0`
  - If matching tags exist, take the highest PATCH number and add 1

### 6. Create the git tag

Create an annotated git tag with the determined name.

### 7. Push to remote

Push both the commit and the tag to the remote:

```
git push origin main
git push origin {TAG_NAME}
```

### 8. Summary

Display a summary of what was done:

- Previous Hugo version
- New Hugo version
- Tag name created
- Push status
