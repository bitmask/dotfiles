#!/usr/bin/env python

# Written by David Lyon, 2018

import os, sys, argparse, random

def sam_by_bytes_low_memory(fn, num_lines=10, max_bytes_per_line=280):
    """
    sample a file, randomly show n lines of a file in sorted order of appearance
        - get size of file
        - linspace of file_size in number_of_lines
        - file seek to those positions
        - read and cleanup line
    :param fn: String(FileName)
    :param num_lines: Integer(NumberOfLines)
    :param max_bytes_per_line: Integer
    :return: None
    """
    try:
        size = os.path.getsize(fn) #f.stat
    except:
        return error_(parser)
    with open(fn, "r") as fh:
        positions = sorted([random.randint(0, size) for _ in range(num_lines)])
        for position in positions:
            fh.seek(position)
            fh.readline()
            line = fh.readline(max_bytes_per_line).strip()
            print(line)

def error_(parser):
    sys.stderr.write("Please pass a file name to the function e.g. \n'sam very_big_file.txt'\n\n\t...and get me a beer :)\n\n\n")
    parser.print_help()
    sys.exit(2)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='sam', usage="%(prog)s [options]\ntype 'sam -h' for help\n\nusage examples:\n'sam big_file.txt'\n'sam -n 3 big_file.txt'")
    parser.add_argument("file_name", help="File name to sample a number of lines from")
    parser.add_argument("-n", "--num_lines", default=10, help="Number of lines to sample and print", type=int)
    parser.add_argument("-m", "--max_bytes_per_line", default=280, help="Maximum number of bytes per line to be printed", type=int)
    args = parser.parse_args()
    sam_by_bytes_low_memory(args.file_name, args.num_lines)
