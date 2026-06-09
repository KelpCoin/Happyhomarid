param([switch]$GeneratePost, [switch]$GenerateEmail)

$Hooks = @(
    "This deck wins by doing something most people refuse to respect until it's too late.",
    "This is not a fair Commander deck. It's a timing exploit disguised as a pile of cards.",
    "You don't pilot this deck. You survive it long enough to understand it.",
    "This list looks casual until it quietly ends the game on turn 6.",
    "Built for table presence, not table permission."
)

if ($GeneratePost) {
    Write-Host "🏁 New Commander Deck Drop`n$(Get-Random $Hooks)`n`nhttps://dreamledger.org`n`nPatrons get early access + build notes."
}

if ($GenerateEmail) {
    Write-Host "Subject: New Commander Deck just dropped`n`nHey,`n`n$(Get-Random $Hooks)`n`nhttps://dreamledger.org`n`n— HappyHomarid"
}