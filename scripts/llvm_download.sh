#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."
# AscendNPU-IR@f91ec30e, third-party/llvm-project.
llvm_sha=89964933a2bf8bdb93831de22cbf5b6fc99c54f7
llvm_url=https://gitcode.com/Ascend/llvm-project.git

git init -q llvm-project
cd llvm-project
# The previous build script placed its preset at LLVM's project preset path.
if [[ -L llvm/CMakePresets.json && llvm/CMakePresets.json -ef ../scripts/CMakePresets.json ]]; then
  rm llvm/CMakePresets.json
fi
if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin "$llvm_url"
fi
git sparse-checkout set --cone cmake llvm mlir third-party
if ! git cat-file -e "$llvm_sha^{commit}" 2>/dev/null; then
  git fetch --depth 1 "$llvm_url" "$llvm_sha"
fi
git checkout --detach "$llvm_sha"
