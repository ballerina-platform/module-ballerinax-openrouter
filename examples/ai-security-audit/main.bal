import ballerina/io;
import ballerinax/openrouter;
import ballerina/http;

configurable string apiKey = ?;
configurable string appUrl = "https://security-audit-app.example.com";

public function main() returns error? {
    
    openrouter:ConnectionConfig config = {
        auth: {
            token: apiKey
        }
    };
    
    openrouter:Client openRouterClient = check new (config);
    
    io:println("=== AI Platform Security Audit ===\n");
    
    // Step 1: Retrieve activity logs for security analysis
    io:println("Step 1: Retrieving activity logs for security analysis...");
    
    openrouter:GetUserActivityHeaders activityHeaders = {
        hTTPReferer: appUrl,
        xOpenRouterTitle: "Security Audit Tool",
        xOpenRouterCategories: "security-audit,compliance"
    };
    
    openrouter:ActivityResponse activityResponse = check openRouterClient->/activity(
        headers = activityHeaders,
        date = "2024-01-15"
    );
    
    io:println("Activity logs retrieved:");
    io:println(activityResponse);
    io:println();
    
    // Step 2: Create custom guardrails based on security findings
    io:println("Step 2: Creating custom security guardrails...");
    
    openrouter:CreateGuardrailHeaders guardrailHeaders = {
        hTTPReferer: appUrl,
        xOpenRouterTitle: "Security Audit Tool",
        xOpenRouterCategories: "security-audit,compliance"
    };
    
    // Create a comprehensive security guardrail
    openrouter:CreateGuardrailRequest securityGuardrail = {
        name: "Enterprise Security Guardrail",
        description: "Comprehensive security controls for enterprise AI usage",
        limit_usd: 1000.0,
        reset_interval: "monthly",
        allowed_providers: ["openai", "anthropic", "google"],
        ignored_providers: ["unknown-provider"],
        allowed_models: ["gpt-4", "gpt-3.5-turbo", "claude-3-opus", "gemini-pro"],
        enforce_zdr: true
    };
    
    openrouter:CreateGuardrailResponse guardrailResponse = check openRouterClient->/guardrails.post(
        securityGuardrail,
        headers = guardrailHeaders
    );
    
    io:println("Security guardrail created:");
    io:println("Guardrail ID: " + guardrailResponse.data.id.toString());
    io:println("Name: " + guardrailResponse.data.name.toString());
    string? guardrailDescription = guardrailResponse.data?.description;
    io:println("Description: " + (guardrailDescription ?: "No description").toString());
    decimal? guardrailLimitUsd = guardrailResponse.data?.limit_usd;
    io:println("Monthly Limit: $" + (guardrailLimitUsd ?: 0).toString());
    boolean? guardrailEnforceZdr = guardrailResponse.data?.enforce_zdr;
    io:println("Zero Data Retention Enforced: " + (guardrailEnforceZdr ?: false).toString());
    io:println();
    
    // Create a development team guardrail with stricter limits
    openrouter:CreateGuardrailRequest devTeamGuardrail = {
        name: "Development Team Guardrail",
        description: "Restricted access for development and testing environments",
        limit_usd: 100.0,
        reset_interval: "weekly",
        allowed_providers: ["openai"],
        allowed_models: ["gpt-3.5-turbo", "gpt-4"],
        enforce_zdr: true
    };
    
    openrouter:CreateGuardrailResponse devGuardrailResponse = check openRouterClient->/guardrails.post(
        devTeamGuardrail,
        headers = guardrailHeaders
    );
    
    io:println("Development team guardrail created:");
    io:println("Guardrail ID: " + devGuardrailResponse.data.id.toString());
    io:println("Name: " + devGuardrailResponse.data.name.toString());
    decimal? devGuardrailLimitUsd = devGuardrailResponse.data?.limit_usd;
    io:println("Weekly Limit: $" + (devGuardrailLimitUsd ?: 0).toString());
    io:println();
    
    // Step 3: Review existing key assignments for compliance
    io:println("Step 3: Reviewing API key assignments for compliance...");
    
    openrouter:ListKeyAssignmentsHeaders assignmentHeaders = {
        hTTPReferer: appUrl,
        xOpenRouterTitle: "Security Audit Tool",
        xOpenRouterCategories: "security-audit,compliance"
    };
    
    openrouter:GuardrailKeyAssignmentsResponse keyAssignments = check openRouterClient->/guardrails/assignments/keys(
        headers = assignmentHeaders,
        offset = 0,
        'limit = 50
    );
    
    io:println("Current key assignments audit:");
    io:println("Total assignments found: " + keyAssignments.total_count.toString());
    io:println("Assignment data:");
    io:println(keyAssignments.data);
    io:println();
    
    io:println("=== Security Audit Complete ===");
    io:println("Summary:");
    io:println("- Activity logs analyzed for security risks");
    io:println("- Enterprise security guardrail created with comprehensive controls");
    io:println("- Development team guardrail created with restricted access");
    io:println("- API key assignments reviewed for compliance");
    io:println("- All guardrails enforce zero data retention for enhanced security");
}