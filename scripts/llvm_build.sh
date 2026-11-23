#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."
scripts/llvm_download.sh

preset_file=llvm-project/llvm/CMakeUserPresets.json
if [[ ! scripts/CMakePresets.json -ef "$preset_file" ]]; then
  ln -s ../../scripts/CMakePresets.json "$preset_file"
fi

cmake --preset "${1:-osx}" -S llvm-project/llvm
cmake --build llvm-project/build --parallel "${CMAKE_BUILD_PARALLEL_LEVEL:-64}" --target all
