# AI Security Audit

This example demonstrates how to perform a comprehensive AI platform security audit using OpenRouter. The script analyzes activity logs, creates security guardrails with compliance controls, and reviews API key assignments to ensure enterprise-grade security and governance.

## Prerequisites

1. **OpenRouter Setup**
   > Refer to the [OpenRouter setup guide](https://openrouter.ai/docs#authentication) to obtain your API key.

2. For this example, create a `Config.toml` file with your credentials:

```toml
apiKey = "<Your OpenRouter API Key>"
appUrl = "https://security-audit-app.example.com"
```

## Run the Example

Execute the following command to run the example. The script will print its progress to the console as it performs the security audit.

```bash
bal run
```

The security audit will:
- Retrieve and analyze activity logs for security risks
- Create an enterprise security guardrail with comprehensive controls
- Set up a development team guardrail with restricted access
- Review existing API key assignments for compliance
- Enforce zero data retention policies across all guardrails