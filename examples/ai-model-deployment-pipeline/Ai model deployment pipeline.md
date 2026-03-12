# AI Model Deployment Pipeline

This example demonstrates how to create an automated AI model selection and deployment pipeline using OpenRouter. The script analyzes available models, checks credit balance, and tests model performance before deployment.

## Prerequisites

1. **OpenRouter Setup**
   > Refer to the [OpenRouter setup guide](https://openrouter.ai/docs/quick-start) to obtain your API key.

2. For this example, create a `Config.toml` file with your credentials:

```toml
openRouterApiKey = "<Your OpenRouter API Key>"
appUrl = "https://myapp.example.com"
appTitle = "AI Model Selection Pipeline"
```

## Run the example

Execute the following command to run the example. The script will print its progress to the console as it goes through the deployment pipeline steps.

```shell
bal run
```

The pipeline will:
1. Analyze available AI models in your specified categories
2. Check your current credit balance and usage
3. Test the selected model with a sample prompt
4. Display comprehensive results including token usage and performance metrics