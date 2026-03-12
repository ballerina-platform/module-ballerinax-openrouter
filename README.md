
# Ballerina openrouter connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-openrouter/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-openrouter/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-openrouter/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-openrouter/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-openrouter/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-openrouter/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-openrouter.svg)](https://github.com/ballerina-platform/module-ballerinax-openrouter/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/openrouter.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%openrouter)

## Overview

[OpenRouter](https://openrouter.ai/) is a unified API that provides access to multiple AI models from various providers, allowing developers to easily switch between and compare different language models through a single interface.

The `ballerinax/openrouter` package offers APIs to connect and interact with [OpenRouter API](https://openrouter.ai/docs) endpoints, specifically based on [OpenRouter API v1](https://openrouter.ai/docs/api-reference).
## Setup guide

To use the OpenRouter connector, you must have access to the OpenRouter API through an [OpenRouter developer account](`https://openrouter.ai/docs`) and obtain an API access token. If you do not have an OpenRouter account, you can sign up for one [here](`https://openrouter.ai/`).

### Step 1: Create an OpenRouter Account

1. Navigate to the [OpenRouter website](`https://openrouter.ai/`) and sign up for an account or log in if you already have one.

2. Note that OpenRouter operates on a pay-per-use model with credits, and API access is available to all registered users without specific plan restrictions.

### Step 2: Generate an API Access Token

1. Log in to your OpenRouter account.

2. Navigate to the Keys section by clicking on your profile in the top right corner, then select "Keys" from the dropdown menu.

3. Click on "Create Key" to generate a new API key.

4. Provide a name for your key and set any desired usage limits or restrictions.

5. Click "Create" to generate your API key.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again in your account settings for security reasons.
## Quickstart

To use the `openrouter` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/openrouter;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the obtained access token:

```toml
token = "<Your_OpenRouter_Access_Token>"
```

2. Create a `openrouter:ConnectionConfig` and initialize the client:

```ballerina
configurable string token = ?;

final openrouter:Client openrouterClient = check new({
    auth: {
        token
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Create a chat completion

```ballerina
public function main() returns error? {
    openrouter:ChatGenerationParams chatRequest = {
        messages: [
            {
                role: "user",
                content: "Hello! Can you help me write a simple Python function?"
            }
        ],
        model: "openai/gpt-3.5-turbo",
        max_tokens: 150,
        temperature: 0.7
    };

    openrouter:ChatResponse response = check openrouterClient->/chat/completions.post(chatRequest);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `openrouter` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-openrouter/tree/main/examples), covering the following use cases:

1. [Ai model deployment pipeline](https://github.com/ballerina-platform/module-ballerinax-openrouter/tree/main/examples/ai-model-deployment-pipeline) - Demonstrates how to create and manage AI model deployment pipelines using the OpenRouter connector.
2. [Ai security audit](https://github.com/ballerina-platform/module-ballerinax-openrouter/tree/main/examples/ai-security-audit) - Illustrates performing security audits on AI models and systems through OpenRouter integration.
## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

    ```bash
    ./gradlew clean build
    ```

2. To run the tests:

    ```bash
    ./gradlew clean test
    ```

3. To build the without the tests:

    ```bash
    ./gradlew clean build -x test
    ```

4. To run tests against different environments:

    ```bash
    ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
    ```

5. To debug the package with a remote debugger:

    ```bash
    ./gradlew clean build -Pdebug=<port>
    ```

6. To debug with the Ballerina language:

    ```bash
    ./gradlew clean build -PbalJavaDebug=<port>
    ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToCentral=true
    ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).


## Useful links

* For more information go to the [`openrouter` package](https://central.ballerina.io/ballerinax/openrouter/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
