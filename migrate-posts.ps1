# Hugo 文章迁移脚本
# 从 Jekyll 格式转换为 Hugo 格式

$sourceDir = "g:\web\blog-chirpy\_posts"
$targetDir = "g:\web\blog-hugo\content\posts"

$files = @(
    @{
        Source = "2026-06-15-ai-prompts-collection.md"
        Title = "大理大学第一附属医院通用办公AI提示词合集"
        Description = "8大类60+实用AI提示词模板，即拿即用"
        Tags = @("AI工具", "办公自动化", "提示词工程", "效率提升")
        Category = "技术实践"
    },
    @{
        Source = "2026-06-15-archive-label-printer.md"
        Title = "大附院档案卷脊封面打印管理系统"
        Description = "Vue.js + Flask 全栈项目，效率提升1800倍"
        Tags = @("档案管理", "Web开发", "打印系统", "小程序", "办公自动化")
        Category = "技术实践"
    },
    @{
        Source = "2026-06-15-autobiography-first-meeting.md"
        Title = "自传续写：初见"
        Description = "1998年洱海边的浪漫邂逅，从相识到相守的爱情故事"
        Tags = @("自传", "生活随笔", "回忆录", "家庭教育")
        Category = "生活感悟"
    }
)

foreach ($file in $files) {
    $sourcePath = Join-Path $sourceDir $file.Source
    $targetPath = Join-Path $targetDir $file.Source
    
    if (Test-Path $sourcePath) {
        # 读取原始文件
        $content = Get-Content $sourcePath -Raw -Encoding UTF8
        
        # 找到第一个 --- 之后的内容（文章内容）
        $parts = $content -split '---', 3
        if ($parts.Count -ge 3) {
            $articleContent = $parts[2].Trim()
            
            # 创建新的 Front Matter
            $tagsStr = ($file.Tags | ForEach-Object { "`"$_`"" }) -join ", "
            $newFrontMatter = @"
---
title: "$($file.Title)"
date: 2026-06-15T10:00:00+08:00
draft: false
tags: [$tagsStr]
categories: ["$($file.Category)"]
author: "李海峰"
description: "$($file.Description)"
---

"@
            
            # 写入新文件
            $newContent = $newFrontMatter + $articleContent
            Set-Content $targetPath -Value $newContent -Encoding UTF8 -NoNewline
            
            Write-Host "✓ 已转换: $($file.Source)" -ForegroundColor Green
        } else {
            Write-Host "✗ 文件格式错误: $($file.Source)" -ForegroundColor Red
        }
    } else {
        Write-Host "✗ 源文件不存在: $($file.Source)" -ForegroundColor Red
    }
}

Write-Host "`n完成！所有文章已转换。" -ForegroundColor Cyan
