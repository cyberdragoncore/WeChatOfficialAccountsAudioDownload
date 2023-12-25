from urllib import error
import requests
import urllib
import time
import argparse
import csv

def GetListFrom(arg, args_true):
    AudioList = []
    if arg.m:
        with open(args_true[0], 'r') as f:
            ReadFile = csv.reader(f)
            for line in ReadFile:
                AudioList.append(line[0])
    elif arg.u:
        AudioList = [i for i in args_true]
    else:
        print("Error input")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('BV',help = '直接下载')
    parser.add_argument('-m',action = 'store_true')
    parser.add_argument('-u',action = 'store_true')
    start = time.time()
    args, args_true = parser.parse_known_args()
    print("开始读取信息。。。")
    AudioList = GetListFrom(args, args_true)

