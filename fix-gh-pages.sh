#!/bin/bash
# 一次性修复：把 Hexo 生成的 public/ 正确推送到 gh-pages，覆盖错误内容
set -e
cd "$(dirname "$0")"

echo ">>> 生成静态站点..."
npm run clean 2>/dev/null || true
npx hexo generate

echo ">>> 推送 public/ 到 gh-pages 分支..."
rm -rf .deploy_gh_pages
mkdir -p .deploy_gh_pages
cp -r public/. .deploy_gh_pages/
cd .deploy_gh_pages
git init
git add .
git commit -m "Deploy site from public/"
git branch -M main
git remote add origin git@github.com:DelyGo/muxi.git
git push -f origin main:gh-pages
cd ..
rm -rf .deploy_gh_pages
echo ">>> 完成。过 1～2 分钟访问: https://delygo.github.io/muxi/"
