#!/bin/bash

PLAYER="spotify"
ICON="" 

if playerctl -p "$PLAYER" status &> /dev/null; then
    STATUS=$(playerctl -p "$PLAYER" status 2> /dev/null)
    ARTIST=$(playerctl -p "$PLAYER" metadata artist 2> /dev/null)
    TITLE=$(playerctl -p "$PLAYER" metadata title 2> /dev/null)

    if [ "$STATUS" = "Playing" ]; then
        TEXT="$ARTIST - $TITLE"
        CLASS="playing"
    elif [ "$STATUS" = "Paused" ]; then
        TEXT="Пауза: $ARTIST - $TITLE"
        CLASS="paused"
    else
        echo ""
        exit 0
    fi
    
    # --- БЛОК ОГРАНИЧЕНИЯ ДЛИНЫ (Вставьте это) ---
    MAX_LEN=40 # Здесь можно изменить лимит символов
    if [ ${#TEXT} -gt $MAX_LEN ]; then
        TEXT=$(echo "$TEXT" | cut -c1-$MAX_LEN)"..."
    fi
    # ---------------------------------------------

    # Output the JSON
    echo '{"text": "'"$ICON $TEXT"'", "class": "custom-spotify-'"$CLASS"'", "alt": "'"$ARTIST - $TITLE"'"}'
else
    echo ""
fi
