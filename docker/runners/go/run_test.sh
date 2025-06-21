#!/bin/bash
set -e

SERVICE_NAME=${1:-"api"}

echo "🧪 Running e2e tests for $SERVICE_NAME"

# Run the appropriate tests
make test-e2e

echo "✅ Tests completed"