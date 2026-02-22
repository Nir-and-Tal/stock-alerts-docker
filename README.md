# stock-alerts-docker

Base Docker image for the [Stock Alerts System](https://github.com/Nir-and-Tal/Stock-Alerts-System).

Provides the Python runtime and system dependencies. The application repo layers its own code and pip dependencies on top of this image.

## What's included

- `python:3.12.12-slim` base
- `procps` (provides `pgrep` for container healthchecks)
- Working directory set to `/app`
- `PYTHONPATH`, `PYTHONUNBUFFERED`, and `PATH` configured for `--user` pip installs

## Image

```
docker pull tal101d56/stock-alert-bot:<version>
```

## Versioning

The `VERSION` file holds the current SemVer tag. On every merge to `main`, the CI pipeline:

1. Lints the Dockerfile (hadolint)
2. Builds and validates the image
3. Scans for vulnerabilities (Trivy — blocks on CRITICAL/HIGH)
4. Auto-increments the patch version
5. Publishes to Docker Hub with the new tag + `latest`

PRs are auto-merged when the pipeline passes.

## Usage in the app repo

```dockerfile
FROM tal101d56/stock-alert-bot:1.0.1

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

COPY src/ ./src/

ENTRYPOINT ["python", "-m", "src.main"]
```

## Required secrets

Set these in the repo's GitHub Actions secrets:

- `DOCKERHUB_USERNAME` — Docker Hub username
- `DOCKERHUB_TOKEN` — Docker Hub access token
