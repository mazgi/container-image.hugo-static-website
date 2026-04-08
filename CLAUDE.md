# CLAUDE.md

## Project Overview

Docker container images for Hugo static websites.
Dockerfile: [Dockerfile.d/hugo-static-website/Dockerfile](Dockerfile.d/hugo-static-website/Dockerfile)

## Hugo Version Update

Use `/tag` to update Hugo and create a release tag.

- Commit message format: `update hugo version to x.x.x`
- Tag format: `hugo-{VERSION}-{YYYY}.{M}.{PATCH}` (e.g., `hugo-0.158.0-2026.3.0`)
- `{PATCH}` starts at `0`, incremented for non-Hugo changes (base image, Node.js, etc.)
