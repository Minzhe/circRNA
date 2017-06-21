########################################
###          trim_fastq.py           ###
########################################

# This python script is to trim off low quality fastq reads head and tails.

import argparse
import os
import sys

parser = argparse.ArgumentParser(description='Trim off two ends of input fastq files.')
parser.add_argument('fastq_files', nargs='+',
                    help='fastq files separated by space <input1> <input2> ... (support both relative path and absolute path)')
parser.add_argument('-s', type=int, nargs='?', dest='start_pos',
                    help='start position of reads you want to keep (default is 1, which will not trim)')
parser.add_argument('-e', type=int, nargs='?', dest='end_pos',
                    help='end position of the reads you want to keep (default set to the length of read, which will not trim)')


##########  parse arguments  ##########
args = parser.parse_args()
fastq_files = args.fastq_files
start_pos = args.start_pos
end_pos = args.end_pos

if start_pos is None:
    start_pos = 1
if start_pos == 1 and end_pos is None:
    sys.exit('Error: does not trim files, please specify meaningful -s and -t.')

##########  trim fastq files  ##########
for file in fastq_files:
    if file.split('.')[-1] == 'fastq':
        input_path = os.path.abspath(file)
        if os.path.exists(input_path):
            output_path = input_path.strip('.fastq') + '_trimmed.fastq'

            ### start trim fastq files
            with open(input_path) as r_f:
                with open(output_path, 'w') as w_f:
                    line_num = 0
                    line = r_f.readline().strip('\n')
                    while line:
                        line_num += 1
                        # trim sequence and quality lines
                        if line_num % 4 == 0 or line_num % 4 == 2:
                            if end_pos is not None:
                                line = line[start_pos-1:end_pos]
                            else:
                                line = line[start_pos-1:]
                        # write lines
                        w_f.write(line + '\n')
                        line = r_f.readline().strip('\n')
            print('Done trimming {}.'.format(input_path))

        else:
            print('Error: cannot find file {}.'.format(input_path))
    else:
        print('Error: {} is not a fastq file'.format(file))


