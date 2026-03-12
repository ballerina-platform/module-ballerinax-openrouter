// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerinax/openrouter;

configurable string openRouterApiKey = ?;
configurable string appUrl = "https://myapp.example.com";
configurable string appTitle = "AI Model Selection Pipeline";

public function main() returns error? {

    openrouter:ConnectionConfig config = {
        auth: {
            token: openRouterApiKey
        }
    };
    openrouter:Client openRouterClient = check new (config);

    openrouter:ListModelsCountHeaders countHeaders = {
        HTTP\-Referer: appUrl,
        X\-OpenRouter\-Title: appTitle,
        X\-OpenRouter\-Categories: "ai-assistant,text-generation"
    };

    io:println("Step 1: Analyzing available AI models...");
    openrouter:ModelsCountResponse modelsCount = check openRouterClient->/models/count(countHeaders);
    io:println("Available models: " + modelsCount.data.count.toString());

    openrouter:GetCreditsHeaders creditsHeaders = {
        HTTP\-Referer: appUrl,
        X\-OpenRouter\-Title: appTitle
    };

    io:println("\nStep 2: Checking credit balance...");
    openrouter:CreditsResponse creditsBalance = check openRouterClient->/credits(creditsHeaders);
    io:println("Total credits: " + creditsBalance.data.total_credits.toString());
    io:println("Credits used: " + creditsBalance.data.total_usage.toString());

    decimal remainingCredits = <decimal>creditsBalance.data.total_credits - <decimal>creditsBalance.data.total_usage;
    io:println("Remaining credits: " + remainingCredits.toString());

    if remainingCredits <= 0.0d {
        io:println("Insufficient credits for model testing. Please add more credits to your account.");
        return;
    }

    openrouter:ChatGenerationParams testPrompt = {
        model: "openai/gpt-3.5-turbo",
        messages: [
            {
                role: "user",
                content: "Hello! Can you help me understand what you're capable of? Please provide a brief overview of your abilities."
            }
        ],
        max_tokens: 150,
        temperature: 0.7
    };

    openrouter:SendChatCompletionRequestHeaders chatHeaders = {
        HTTP\-Referer: appUrl,
        X\-OpenRouter\-Title: appTitle,
        X\-OpenRouter\-Categories: "ai-assistant,text-generation"
    };

    io:println("\nStep 3: Testing selected model performance...");
    io:println("Testing model: openai/gpt-3.5-turbo");
    io:println("Test prompt: Hello! Can you help me understand what you're capable of?");

    openrouter:ChatResponse chatResponse = check openRouterClient->/chat/completions.post(testPrompt, chatHeaders);
    
    io:println("\nModel Response:");
    io:println("Response ID: " + chatResponse.id.toString());
    io:println("Model used: " + chatResponse.model.toString());
    io:println("Choices: " + chatResponse.choices.toString());
    
    if chatResponse.usage is openrouter:ChatGenerationTokenUsage {
        openrouter:ChatGenerationTokenUsage usage = <openrouter:ChatGenerationTokenUsage>chatResponse.usage;
        io:println("\nToken Usage:");
        io:println("Prompt tokens: " + usage.prompt_tokens.toString());
        io:println("Completion tokens: " + usage.completion_tokens.toString());
        io:println("Total tokens: " + usage.total_tokens.toString());
    }

    io:println("\n✅ AI Model Selection and Deployment Pipeline Complete!");
    io:println("Model validation successful. Ready for full deployment.");
}