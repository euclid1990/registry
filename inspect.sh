#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
set -eu

echo "Total disk space usage for container images"
du -sh ./mnt
