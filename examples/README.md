# Examples

The `openrouter` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-openrouter/tree/main/examples), covering use cases like AI model deployment pipeline, and AI security audit.

1. [AI model deployment pipeline](https://github.com/ballerina-platform/module-ballerinax-openrouter/tree/main/examples/ai-model-deployment-pipeline) - Automate the deployment pipeline for AI models using OpenRouter integration.

2. [AI security audit](https://github.com/ballerina-platform/module-ballerinax-openrouter/tree/main/examples/ai-security-audit) - Perform comprehensive security audits on AI systems and models through OpenRouter.

## Prerequisites

1. Generate OpenRouter credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/openrouter/latest#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    token = "<Access Token>"
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```