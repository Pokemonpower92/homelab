#!/bin/bash
set -e

SERVICE_NAME=${1:-"api"}
TARGET_ENV=${TARGET_ENV:-"staging"}

echo "🧪 Running e2e tests for $SERVICE_NAME in $TARGET_ENV"

# Run the appropriate tests
make test-e2e

echo "✅ Tests completed"