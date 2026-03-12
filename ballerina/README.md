## Overview

[OpenRouter](https://openrouter.ai/) is a unified API platform that provides access to multiple AI language models from various providers, allowing developers to easily switch between and compare different models through a single interface.

The `ballerinax/openrouter` package offers APIs to connect and interact with [OpenRouter API](https://openrouter.ai/docs) endpoints, specifically based on [OpenRouter API v1](https://openrouter.ai/docs/api-reference).
## Setup guide

To use the OpenRouter connector, you must have access to the OpenRouter API through an [OpenRouter developer account](`https://openrouter.ai/docs`) and obtain an API access token. If you do not have an OpenRouter account, you can sign up for one [here](`https://openrouter.ai/`).

### Step 1: Create an OpenRouter Account

1. Navigate to the [OpenRouter website](`https://openrouter.ai/`) and sign up for an account or log in if you already have one.

2. Note that OpenRouter operates on a pay-per-use model with credits, and API access is available to all registered users regardless of plan type.

### Step 2: Generate an API Access Token

1. Log in to your OpenRouter account.

2. Navigate to the Keys section by clicking on your profile in the top right corner and selecting "Keys" from the dropdown menu.

3. Click on "Create Key" to generate a new API key.

4. Provide a name for your key and set any optional restrictions if needed, then click "Create Key".

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
token = "<Your_OpenRouter_API_Token>"
```

2. Create an `openrouter:ConnectionConfig` and initialize the client:

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
        model: "openai/gpt-3.5-turbo",
        messages: [
            {
                role: "user",
                content: "Hello! Can you help me write a simple greeting message?"
            }
        ],
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

1. [Ai model deployment pipeline](https://github.com/ballerina-platform/module-ballerinax-openrouter/tree/main/examples/ai-model-deployment-pipeline) - Demonstrates how to automate AI model deployment processes using Ballerina connector for OpenRouter.
2. [Ai security audit](https://github.com/ballerina-platform/module-ballerinax-openrouter/tree/main/examples/ai-security-audit) - Illustrates conducting security audits for AI systems and models.