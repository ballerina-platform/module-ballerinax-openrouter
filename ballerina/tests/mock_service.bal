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

import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new (9090);

// Shared timestamps used across mock responses
final string MOCK_KEY_CREATED_AT = "2025-01-01T00:00:00Z";
final string MOCK_KEY_UPDATED_AT = "2025-01-02T00:00:00Z";

http:Service mockService = service object {

    # List all models and their properties
    resource function get models() returns ModelsListResponse {
        return {data: []};
    }

    # Get total count of available models
    resource function get models/count() returns ModelsCountResponse {
        return {data: {count: 250}};
    }

    # Get remaining credits
    resource function get credits() returns CreditsResponse {
        return {data: {total_credits: 10.00, total_usage: 1.50}};
    }

    # Get current API key
    resource function get 'key() returns CurrentKeyResponse {
        return {
            data: {
                label: "Default",
                'limit: 100.00,
                usage: 1.50,
                usage_daily: 0.50,
                usage_weekly: 1.00,
                usage_monthly: 1.50,
                byok_usage: 0.00,
                byok_usage_daily: 0.00,
                byok_usage_weekly: 0.00,
                byok_usage_monthly: 0.00,
                is_free_tier: false,
                is_management_key: false,
                is_provisioning_key: false,
                limit_remaining: 98.50,
                limit_reset: "monthly",
                include_byok_in_limit: false,
                rate_limit: {requests: -1, interval: "10s", note: "Legacy field – always -1"}
            }
        };
    }

    # List all providers
    resource function get providers() returns ProvidersResponse {
        return {
            data: [
                {name: "OpenAI", slug: "openai", privacy_policy_url: "https://openai.com/privacy"},
                {name: "Anthropic", slug: "anthropic", privacy_policy_url: "https://anthropic.com/privacy"}
            ]
        };
    }

    # Create a chat completion
    resource function post chat/completions(@http:Payload json payload)
            returns ChatResponse {
        return {
            id: "chatcmpl-mock-001",
            'object: "chat.completion",
            created: 1709000000,
            model: "openai/gpt-3.5-turbo",
            choices: [
                {
                    index: 0,
                    finish_reason: "stop",
                    message: {role: "assistant", content: "Hello!"}
                }
            ],
            system_fingerprint: ()
        };
    }

    # List API keys
    resource function get keys() returns KeysListResponse {
        return {
            data: [
                {
                    hash: MOCK_KEY_HASH,
                    name: "test-ballerina-key",
                    label: "Test Key",
                    disabled: false,
                    'limit: 100.00,
                    limit_remaining: 98.50,
                    limit_reset: "monthly",
                    include_byok_in_limit: false,
                    usage: 1.50,
                    usage_daily: 0.50,
                    usage_weekly: 1.00,
                    usage_monthly: 1.50,
                    byok_usage: 0.00,
                    byok_usage_daily: 0.00,
                    byok_usage_weekly: 0.00,
                    byok_usage_monthly: 0.00,
                    created_at: MOCK_KEY_CREATED_AT,
                    updated_at: MOCK_KEY_UPDATED_AT
                }
            ]
        };
    }

    # Create a new API key
    resource function post keys(@http:Payload CreateKeyRequest payload) returns CreateKeyResponse {
        return {
            data: {
                hash: MOCK_KEY_HASH,
                name: payload.name,
                label: payload.name,
                disabled: false,
                'limit: payload?.'limit ?: 100.00,
                limit_remaining: payload?.'limit ?: 100.00,
                limit_reset: "monthly",
                include_byok_in_limit: payload.include_byok_in_limit ?: false,
                usage: 0.00,
                usage_daily: 0.00,
                usage_weekly: 0.00,
                usage_monthly: 0.00,
                byok_usage: 0.00,
                byok_usage_daily: 0.00,
                byok_usage_weekly: 0.00,
                byok_usage_monthly: 0.00,
                created_at: MOCK_KEY_CREATED_AT,
                updated_at: MOCK_KEY_CREATED_AT
            },
            'key: "sk-or-v1-mock-key-for-ballerina-tests"
        };
    }

    # Get a single API key by hash
    resource function get keys/[string hash]() returns KeyDetailsResponse {
        return {
            data: {
                hash: hash,
                name: "test-ballerina-key",
                label: "Test Key",
                disabled: false,
                'limit: 100.00,
                limit_remaining: 98.50,
                limit_reset: "monthly",
                include_byok_in_limit: false,
                usage: 1.50,
                usage_daily: 0.50,
                usage_weekly: 1.00,
                usage_monthly: 1.50,
                byok_usage: 0.00,
                byok_usage_daily: 0.00,
                byok_usage_weekly: 0.00,
                byok_usage_monthly: 0.00,
                created_at: MOCK_KEY_CREATED_AT,
                updated_at: MOCK_KEY_UPDATED_AT
            }
        };
    }

    # Update an API key by hash
    resource function patch keys/[string hash](@http:Payload UpdateKeyRequest payload)
            returns UpdateKeyResponse {
        return {
            data: {
                hash: hash,
                name: payload.name ?: "test-ballerina-key",
                label: payload.name ?: "Test Key",
                disabled: payload.disabled ?: false,
                'limit: payload?.'limit ?: 100.00,
                limit_remaining: payload?.'limit ?: 100.00,
                limit_reset: "monthly",
                include_byok_in_limit: payload.include_byok_in_limit ?: false,
                usage: 1.50,
                usage_daily: 0.50,
                usage_weekly: 1.00,
                usage_monthly: 1.50,
                byok_usage: 0.00,
                byok_usage_daily: 0.00,
                byok_usage_weekly: 0.00,
                byok_usage_monthly: 0.00,
                created_at: MOCK_KEY_CREATED_AT,
                updated_at: MOCK_KEY_UPDATED_AT
            }
        };
    }

    # Delete an API key by hash
    resource function delete keys/[string hash]() returns DeleteKeyResponse {
        return {deleted: true};
    }

    # List guardrails
    resource function get guardrails() returns GuardrailListResponse {
        return {
            data: [
                {
                    id: MOCK_GUARDRAIL_ID,
                    name: "test-ballerina-guardrail",
                    description: "Test guardrail",
                    enforce_zdr: false,
                    created_at: MOCK_KEY_CREATED_AT
                }
            ],
            total_count: 1
        };
    }

    # Create a guardrail
    resource function post guardrails(@http:Payload CreateGuardrailRequest payload)
            returns CreateGuardrailResponse {
        return {
            data: {
                id: MOCK_GUARDRAIL_ID,
                name: payload.name,
                description: payload["description"] ?: "test-guardrail",
                limit_usd: payload["limit_usd"] ?: 0.0d,
                reset_interval: payload.reset_interval,
                enforce_zdr: payload["enforce_zdr"] ?: false,
                created_at: MOCK_KEY_CREATED_AT
            }
        };
    }

    # Get a guardrail by ID
    resource function get guardrails/[string id]() returns GetGuardrailResponse {
        return {
            data: {
                id: id,
                name: "test-ballerina-guardrail",
                description: "Test guardrail",
                enforce_zdr: false,
                created_at: MOCK_KEY_CREATED_AT
            }
        };
    }

    # Update a guardrail by ID
    resource function patch guardrails/[string id](@http:Payload UpdateGuardrailRequest payload)
            returns UpdateGuardrailResponse {
        return {
            data: {
                id: id,
                name: payload.name ?: "test-ballerina-guardrail",
                description: payload["description"] ?: "test-guardrail",
                limit_usd: payload["limit_usd"] ?: 0.0d,
                reset_interval: payload.reset_interval,
                enforce_zdr: payload["enforce_zdr"] ?: false,
                created_at: MOCK_KEY_CREATED_AT,
                updated_at: MOCK_KEY_UPDATED_AT
            }
        };
    }

    # Delete a guardrail by ID
    resource function delete guardrails/[string id]() returns DeleteGuardrailResponse {
        return {deleted: true};
    }
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skipping mock service initialization. Tests are configured to run against live server.");
        return;
    }
    log:printInfo("Tests are configured to run against mock server. Initializing mock service...");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}
