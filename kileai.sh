#!/bin/bash

# 克隆仓库
git clone https://github.com/Gzgod/Kile_Ai_Bot.git
cd Kile_Ai_Bot || exit

# 安装依赖
npm install

# 运行Python脚本
python generated_questions.py

# 获取用户钱包地址
echo "请输入您的钱包地址 (以0x开头):"
read wallet_address

# 验证钱包地址是否以0x开头
if [[ ! $wallet_address =~ ^0x ]]; then
    echo "钱包地址必须以0x开头。"
    exit 1
fi

# 将钱包地址写入文件
echo "$wallet_address" > wallets.txt

# 询问是否使用代理
echo "您是否需要使用代理？(y/n):"
read use_proxy

if [[ $use_proxy == "y" || $use_proxy == "Y" ]]; then
    echo "请输入代理地址，格式为 http://username:password@ip:port:"
    read proxy_address
    
    # 验证代理地址格式是否正确
    if [[ ! $proxy_address =~ ^http://[a-zA-Z0-9]+:[a-zA-Z0-9]+@[0-9.]+:[0-9]+$ ]]; then
        echo "代理地址格式错误，请确保格式为 http://username:password@ip:port。"
        exit 1
    fi
    
    # 设置环境变量以使用代理
    export HTTP_PROXY=$proxy_address
    export HTTPS_PROXY=$proxy_address
    echo "已设置代理: $proxy_address"
else
    echo "不使用代理。"
fi

# 运行项目
npm run start
