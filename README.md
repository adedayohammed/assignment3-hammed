# Assignment 3 — CI/CD with GitHub Actions

This repository implements a local CI pipeline for a Bash utility application using GitHub Actions.

## Directory Structure
- `app/app.sh`: Core application providing host and network utilities.
- `scripts/lint.sh`: Script to verify existence of files and perform Bash syntax checking.
- `scripts/build.sh`: Script to compile the Docker image and run automated smoke tests.
- `tests/test.sh`: Script evaluating 8 unique application capabilities and exit parameters.
- `.github/workflows/ci.yml`: Multi-stage structural pipeline setup using specific job sequences (`validate` -> `test` -> `docker`).

## CI Failure Demonstration Log
1. **Created Branch**: `feature/break-ci`
2. **Introduced Error**: Intentionally injected a syntax error into `app/app.sh` (mismatched brackets).
3. **Pushed & Observed Failure**: The GitHub Actions pipeline triggered on push; the `validate` job failed immediately on syntax parsing, blocking subsequent `test` and `docker` workflows.
4. **Resolved Issue**: Repaired the bracket imbalance in `app/app.sh`.
5. **Pushed & Passed**: The final pipeline run succeeded entirely across all structural check gates.
