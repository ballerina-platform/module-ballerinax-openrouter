// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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

import ballerina/test;

// Constants used in mock tests
const string MOCK_KEY_HASH = "test-key-hash-mock-001";
const string MOCK_GUARDRAIL_ID = "guardrail-mock-001";
const string TEST_CHAT_MODEL = "openai/gpt-3.5-turbo";

// Configurable variables – set via Config.toml or environment variables
configurable boolean isLiveServer = ?;
configurable string token = ?;

// Module-level state shared across dependent tests
string createdKeyHash = "";
string createdGuardrailId = "";

// Initialize the client pointing to mock or live server
Client testClient = check new (
    {auth: {token: token}},
    isLiveServer ? "https://openrouter.ai/api/v1" : "http://localhost:9090"
);

// ========================= MODELS =========================

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testListModels() returns error? {
    ModelsListResponse response = check testClient->/models();
    test:assertTrue(response.data.length() >= 0, "Should return a list of models");
}

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testGetModelsCount() returns error? {
    ModelsCountResponse response = check testClient->/models/count();
    test:assertTrue(response.data.count >= 0d, "Model count should be a non-negative number");
}

// ========================= CREDITS =========================

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testGetCredits() returns error? {
    CreditsResponse response = check testClient->/credits();
    test:assertTrue(response.data.total_credits >= 0d, "Total credits should be non-negative");
}

// ========================= CURRENT KEY =========================

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testGetCurrentKey() returns error? {
    CurrentKeyResponse response = check testClient->/'key();
    test:assertTrue(response.data.'limit >= 0.0d, "Current key limit should be non-negative");
}

// ========================= PROVIDERS =========================

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testListProviders() returns error? {
    ProvidersResponse response = check testClient->/providers();
    test:assertTrue(response.data.length() >= 0, "Should return a list of providers");
}

// ========================= CHAT COMPLETIONS =========================

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testCreateChatCompletion() returns error? {
    UserMessage userMsg = {role: "user", content: "Say hello in one word."};
    ChatGenerationParams payload = {
        model: TEST_CHAT_MODEL,
        messages: [userMsg],
        max_tokens: 20
    };
    ChatResponse response = check testClient->/chat/completions.post(payload);
    test:assertTrue(response.id.length() > 0, "Chat response should have a non-empty ID");
    test:assertTrue(response.choices.length() > 0, "Chat response should contain at least one choice");
}

// ========================= API KEYS =========================

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testListKeys() returns error? {
    KeysListResponse response = check testClient->/keys();
    test:assertTrue(response.data.length() >= 0, "Should return a list of API keys");
}

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testCreateKey() returns error? {
    CreateKeyRequest payload = {name: "test-ballerina-key"};
    CreateKeyResponse response = check testClient->/keys.post(payload);
    test:assertTrue(response.data.hash.length() > 0, "Created key should have a non-empty hash");
    test:assertTrue(response.'key.length() > 0, "Created key string should be non-empty");
    createdKeyHash = response.data.hash;
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreateKey]
}
function testGetKey() returns error? {
    string hash = isLiveServer ? createdKeyHash : MOCK_KEY_HASH;
    KeyDetailsResponse response = check testClient->/keys/[hash]();
    test:assertTrue(response.data.hash.length() > 0, "Key details should have a non-empty hash");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreateKey]
}
function testUpdateKey() returns error? {
    string hash = isLiveServer ? createdKeyHash : MOCK_KEY_HASH;
    UpdateKeyRequest payload = {name: "updated-ballerina-key"};
    UpdateKeyResponse response = check testClient->/keys/[hash].patch(payload);
    test:assertTrue(response.data.hash.length() > 0, "Updated key should have a non-empty hash");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testGetKey, testUpdateKey]
}
function testDeleteKey() returns error? {
    string hash = isLiveServer ? createdKeyHash : MOCK_KEY_HASH;
    DeleteKeyResponse response = check testClient->/keys/[hash].delete();
    test:assertTrue(response.deleted, "Key deletion should return true");
}

// ========================= GUARDRAILS =========================

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testListGuardrails() returns error? {
    GuardrailListResponse response = check testClient->/guardrails();
    test:assertTrue(response.data.length() >= 0, "Should return a list of guardrails");
}

@test:Config {
    groups: ["mock_tests", "live_tests"]
}
function testCreateGuardrail() returns error? {
    CreateGuardrailRequest payload = {
        name: "test-ballerina-guardrail",
        description: "Test guardrail created by Ballerina connector tests"
    };
    CreateGuardrailResponse response = check testClient->/guardrails.post(payload);
    test:assertTrue(response.data.id.length() > 0, "Created guardrail should have a non-empty ID");
    createdGuardrailId = response.data.id;
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreateGuardrail]
}
function testGetGuardrail() returns error? {
    string id = isLiveServer ? createdGuardrailId : MOCK_GUARDRAIL_ID;
    GetGuardrailResponse response = check testClient->/guardrails/[id]();
    test:assertTrue(response.data.id.length() > 0, "Guardrail details should have a non-empty ID");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testCreateGuardrail]
}
function testUpdateGuardrail() returns error? {
    string id = isLiveServer ? createdGuardrailId : MOCK_GUARDRAIL_ID;
    UpdateGuardrailRequest payload = {name: "updated-ballerina-guardrail"};
    UpdateGuardrailResponse response = check testClient->/guardrails/[id].patch(payload);
    test:assertTrue(response.data.id.length() > 0, "Updated guardrail should have a non-empty ID");
}

@test:Config {
    groups: ["mock_tests", "live_tests"],
    dependsOn: [testGetGuardrail, testUpdateGuardrail]
}
function testDeleteGuardrail() returns error? {
    string id = isLiveServer ? createdGuardrailId : MOCK_GUARDRAIL_ID;
    DeleteGuardrailResponse response = check testClient->/guardrails/[id].delete();
    test:assertTrue(response.deleted, "Guardrail deletion should return true");
}
