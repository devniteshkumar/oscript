#!/usr/bin/env bash
set -euo pipefail

curl -fL https://raw.githubusercontent.com/devniteshkumar/oscript/main/scripts/partition.sh -o /tmp/partition.sh && sudo bash /tmp/partition.sh
curl -fL https://raw.githubusercontent.com/devniteshkumar/oscript/main/scripts/subvolumes.sh -o /tmp/subvolumes.sh && sudo bash /tmp/subvolumes.sh
curl -fL https://raw.githubusercontent.com/devniteshkumar/oscript/main/scripts/nixconf.sh -o /tmp/nixconf.sh && sudo bash /tmp/nixconf.sh