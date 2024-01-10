# Set your GitHub repository details
repo_owner="argadepp"
repo_name="frappe-hrms-create"
workflow_name="Create HRMS Site"

# Set your personal access token with repo scope
token="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"

# Trigger a repository dispatch event
curl -X POST \
  -H "Accept: application/vnd.github.everest-preview+json" \
  -H "Authorization: Bearer $token" \
  "https://api.github.com/repos/$repo_owner/$repo_name/dispatches" \
  -d '{"event_type": "$workflow_name"}'
