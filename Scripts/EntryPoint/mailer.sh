#!/bin/bash

# Exit with error if a command returns a non-zero status
set -e

echo "Start Sandstorm Mailer Daemon..."
. /etc/default/sandstorm-newsletter-sender
exec /usr/local/bin/sandstorm-newsletter-sender
