#!/bin/bash
set -euo pipefail

exec "$(dirname "$0")/llvm_build.sh" osx_lld
