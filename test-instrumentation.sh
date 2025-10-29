#!/bin/bash
set -e

echo "=== Testing Custom Instrumentation ==="
echo ""
echo "Starting server with custom instrumentation..."
echo ""

# Start server in background
java -javaagent:custom-extension/build/libs/opentelemetry-javaagent.jar \
     -Dotel.traces.exporter=logging \
     -Dotel.metrics.exporter=none \
     -Dotel.logs.exporter=none \
     -jar build/libs/agent-extension-test-1.0-SNAPSHOT.jar &

SERVER_PID=$!

# Wait for server to start
sleep 3

echo ""
echo "=== Making test request ==="
curl -s http://localhost:8080/hello
echo ""
echo ""

# Give time to see output
sleep 2

# Cleanup
kill $SERVER_PID
wait $SERVER_PID 2>/dev/null || true

echo ""
echo "=== Test Complete ==="