# ============================================================
# Minimal-Patreon-Revenue.ps1
# Fastest path to money from existing patrons
# ============================================================
param([switch]$DryRun)

$ROOT = if (Test-Path "D:\") { "D:\BrownEyeCortex" } else { "C:\BrownEyeCortex" }

# Get Patreon token
$token = Get-CortexSecret 'PATREON_ACCESS_TOKEN' -ErrorAction SilentlyContinue
if (-not $token) {
    Write-Host "Set your token first:" -ForegroundColor Yellow
    Write-Host 'Set-CortexSecret "PATREON_ACCESS_TOKEN" "your-token"'
    exit
}

$headers = @{ Authorization = "Bearer $token" }

# Get campaign
$campaign = (Invoke-RestMethod -Uri "https://www.patreon.com/api/oauth2/v2/campaigns" -Headers $headers).data[0]
$campaignId = $campaign.id

# Get active patrons
$patronsUrl = "https://www.patreon.com/api/oauth2/v2/campaigns/$campaignId/members?include=user&fields[member]=patron_status,email,full_name"
$patrons = (Invoke-RestMethod -Uri $patronsUrl -Headers $headers).data |
           Where-Object { $_.attributes.patron_status -eq "active_patron" }

Write-Host "Active patrons: $($patrons.Count)" -ForegroundColor Cyan

# Simple post
$post = "🏁 New Commander decks are live → https://dreamledger.org`n`nPatrons get bonus templates with every purchase."

if ($DryRun) {
    Write-Host "`n[DRY RUN] Would post:`n$post" -ForegroundColor Yellow
} else {
    $body = @{ data = @{ type = "post"; attributes = @{ title = "New Decks - $(Get-Date -Format 'dd MMM')"; content = $post; is_public = $false }; relationships = @{ campaign = @{ data = @{ type = "campaign"; id = $campaignId } } } } } | ConvertTo-Json -Depth 10
    Invoke-RestMethod -Uri "https://www.patreon.com/api/oauth2/v2/posts" -Method POST -Headers ($headers + @{"Content-Type"="application/json"}) -Body $body | Out-Null
    Write-Host "Posted to Patreon." -ForegroundColor Green
}

# Email active patrons (basic)
foreach ($p in $patrons) {
    $email = $p.attributes.email
    $name = ($p.attributes.full_name -split " ")[0]

    if ($DryRun) {
        Write-Host "Would email: $email"
    } else {
        try {
            $mail = New-Object System.Net.Mail.MailMessage("your@email.com", $email)
            $mail.Subject = "Hey $name — new decks just dropped"
            $mail.Body = "Quick update — new Commander decks are live at https://dreamledger.org`n`nThanks for the support."
            $smtp = New-Object System.Net.Mail.SmtpClient("smtp.gmail.com", 587)
            $smtp.EnableSsl = $true
            $smtp.Credentials = New-Object System.Net.NetworkCredential("your@email.com", "your-app-password")
            $smtp.Send($mail)
            Write-Host "Emailed: $email" -ForegroundColor Green
            Start-Sleep -Seconds 1
        } catch {}
    }
}