# OpenTelemetry Java Agent Extension Test

A test project for experimenting with OpenTelemetry Java agent extensions.

## Overview

Provides a simple HTTP server application to test OpenTelemetry Java agent instrumentation
and custom extensions. It includes a basic web server with sample endpoints and a custom extension module.

## Quick Start

### Build the project

```bash
./gradlew build
```

### Run the application

```bash
./gradlew run
```

The server starts on port 8080 with the following endpoints:
- `http://localhost:8080/hello` - Returns a simple greeting
- `http://localhost:8080/greet?name=YourName` - Returns a personalized greeting

## Testing with OpenTelemetry Agent

Use the provided test scripts to experiment with OpenTelemetry Java agent instrumentation:

```bash
./test-instrumentation.sh
./test-configuration.sh
```