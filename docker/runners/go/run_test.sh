#!/bin/bash
set -e

SUITE=${1:-"test"}

echo "🧪 Running  for $SERVICE_NAME"

# Run the appropriate tests
make $SUITE

echo "✅ Tests completed"