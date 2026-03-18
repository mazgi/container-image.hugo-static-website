# CLAUDE.md

## Project Overview

Repository for building Docker container images for Hugo static websites.
The Dockerfile is located at [Dockerfile.d/hugo-static-website/Dockerfile](Dockerfile.d/hugo-static-website/Dockerfile).

## Hugo Version Update Procedure

1. Check the target version exists on the Hugo releases page (https://github.com/gohugoio/hugo/tags)
2. Update `ARG HUGO_VERSION=x.x.x` in `Dockerfile.d/hugo-static-website/Dockerfile`
3. Commit with message in the format: `update hugo version to x.x.x`
4. Create a git tag in the format: `hugo-{VERSION}-{YYYY}.{M}.0`
   - `{VERSION}` is the Hugo version
   - `{YYYY}.{M}.0` is the release year and month

## Tag Naming Convention

```
hugo-{HUGO_VERSION}-{YYYY}.{M}.0
```

Examples:
- `hugo-0.131.0-2026.3.0`
- `hugo-0.129.0-2024.07.0`
