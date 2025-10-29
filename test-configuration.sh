#!/bin/bash
set -e

echo "=== Testing Configuration Features ==="
echo ""
echo "Test 1: Default Configuration"
echo "=============================="
echo ""

# Test 1: Default configuration
java -javaagent:custom-extension/build/libs/opentelemetry-javaagent.jar \
     -Dotel.traces.exporter=none \
     -Dotel.metrics.exporter=none \
     -jar build/libs/agent-extension-test-1.0-SNAPSHOT.jar &

SERVER_PID=$!
sleep 3
kill $SERVER_PID 2>/dev/null || true
wait $SERVER_PID 2>/dev/null || true

echo ""
echo ""
echo "Test 2: Custom Configuration with Configurable Sampler"
echo "======================================================="
echo ""

# Test 2: Custom configuration with configurable sampler
java -javaagent:custom-extension/build/libs/opentelemetry-javaagent.jar \
     -Dotel.traces.sampler=demosampler \
     -Dotel.instrumentation.demosampler.ratio=0.5 \
     -Dotel.instrumentation.demosampler.debug=true \
     -Dotel.instrumentation.demosampler.threshold=50 \
     -Dotel.instrumentation.myext.enabled=false \
     -Dotel.traces.exporter=logging \
     -Dotel.metrics.exporter=none \
     -jar build/libs/agent-extension-test-1.0-SNAPSHOT.jar &

SERVER_PID=$!
sleep 3

# Make a request
curl -s http://localhost:8080/hello > /dev/null

sleep 2
kill $SERVER_PID 2>/dev/null || true
wait $SERVER_PID 2>/dev/null || true

echo ""
echo ""
echo "Test 3: Environment Variable Configuration"
echo "==========================================="
echo ""

# Test 3: Environment variables (higher priority than defaults)
OTEL_SERVICE_NAME=env-test-service \
OTEL_INSTRUMENTATION_MYEXT_THRESHOLD=200 \
java -javaagent:custom-extension/build/libs/opentelemetry-javaagent.jar \
     -Dotel.traces.exporter=none \
     -Dotel.metrics.exporter=none \
     -jar build/libs/agent-extension-test-1.0-SNAPSHOT.jar &

SERVER_PID=$!
sleep 3
kill $SERVER_PID 2>/dev/null || true
wait $SERVER_PID 2>/dev/null || true

echo ""
echo "=== Configuration Tests Complete ==="
