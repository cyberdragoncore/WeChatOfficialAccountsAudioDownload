#!/bin/bash

# 获取当前目录
cur_dir=$(pwd)

for file in ${cur_dir}/*.m4a
do 
    # 获取文件名
    echo "${file}"
    filename=$(basename "${file}")
    filename=${filename%.*}

    # 确认是否继续
    read -p "${filename} 是否需要转换【Y/n】" -n 1 key
    case ${key} in
        "N")
            echo "\n"
            continue
            ;;
        "n")
            echo "\n"
            continue
            ;;
        *)
            ;;
        esac
        
    # 判断是否已经存在
    if [[ ! -f ${cur_dir}/mp3/${filename}.mp3 ]]; then
        # 进行文件转换
        ffmpeg -i "${file}" -c:a libmp3lame -q:a 8 -f mp3 "${cur_dir}/mp3/${filename}.mp3"
    else
        # 已存在文件，提示跳过
        echo "${filename} 已存在，跳过。"
    fi
done
