###############################################################
###                        job.pl                           ###
###############################################################
# This python script writes shell scripts and submits them.
# The shell scripts handle adaptor removal, alignment and circRNA detection.
# Do not move this script to other folder.
#!/usr/bin/python

import pandas as pd
import os
import glob

cur_dir = os.path.dirname(os.path.realpath(__file__))
project_dir = os.path.abspath(os.path.join(cur_dir, '../..'))
master_path = os.path.join(project_dir, 'docs/CLIP_Seq_data_v11.txt')
circRNA_dir = os.path.join(project_dir, 'data/circRNA/')
genome_dir = os.path.join(project_dir, 'data/library/')
homer_dir = os.path.join(project_dir, 'shiny/www/')
motif_dir = os.path.join(project_dir, 'data/analysis/motif/')
ref_genome = {'Human': 'hg19', 'Mouse': 'mm9', 'Drosophila': 'dm3'}

remove_adaptor_perl = '~/projects/Clirc/bin/remove_adaptor.pl'
find_circRNA_perl = '~/projects/Clirc/bin/find_circRNA.pl'
filter_circRNA_perl = '~/projects/circRNA/code/circRNA/filter_circRNA.pl'


############   functions   #############
def writeHead(file, clip):
    print('#PBS -S /bin/bash', file=file)
    print('#PBS -q qbrc', file=file)
    print('#PBS -l nodes=1:ppn=8', file=file)
    print('#PBS -e ./{}.error.qsub'.format(clip), file=file)
    print('#PBS -o ./{}.log.qsub'.format(clip), file=file)
    print('\n\n', file=file)


def readAdaptor(file):
    '''
    Read adaptor file
    :param file:
    :return:
    '''
    adaptors = dict()
    with open(file=file) as f:
        line = f.readline().strip()
        while line:
            line = line.split(' ')
            if len(line) == 2:
                adaptors[line[0]] = line[1]
            elif len(line) == 1:
                adaptors[line[0]] = None
            else:
                raise IOError('adaptor.txt format error {}.'.format(clip))
            line = f.readline().strip()
    return adaptors


def prepareRemoveAdaptor(script_path, file_path, adaptor):
    '''
    Remove adaptors
    :param script_path:
    :param file_path:
    :param adaptor:
    :return:
    '''
    perl_cmd = 'perl {} fastq {} {} 18 0.2 10 unique'.format(script_path, file_path, adaptor)
    return perl_cmd


def prepareAlignCircRNA(library, input_file, output_file):
    '''
    Align circRNA on genome
    :param library:
    :param input_file:
    :param output_file:
    :return:
    '''
    gsnap_cmd = 'gsnap --use-sarray=0 --no-sam-headers -B 4 -A sam -Q -n 200 ' \
                '--merge-distant-samechr -N 1 -t 12 --nofails --sam-multiple-primaries ' \
                '-D {} ' \
                '-d circRNA_on_genome ' \
                '{} | awk \'{{print $1"\\t"$2"\\t"$3}}\' > {}'.format(library, input_file, output_file)
    return gsnap_cmd


def prepareAlignCircRNAandRef(library, input_file, output_file):
    '''
    Align to reference + circRNA
    :param library:
    :param input_file:
    :param output_file:
    :return:
    '''
    gsnap_cmd = 'gsnap --no-sam-headers -B 4 -A sam -Q -n 5 --query-unk-mismatch=1 ' \
                '--merge-distant-samechr -N 1 -t 12 -m 4 --nofails --sam-multiple-primaries ' \
                '-D {} ' \
                '-d circRNA ' \
                '{} > {}'.format(library, input_file, output_file)
    return gsnap_cmd


def prepareDetectCircRNA(script_path, input_file, output_file):
    '''
    Detect circRNA
    :param script_path:
    :param input_file:
    :param output_file:
    :return:
    '''
    perl_cmd = 'perl {} {} {} 5 0.15 12 0'.format(script_path, input_file, output_file)
    return perl_cmd


def prepareFilterCircRNA(script_path, output_file, library_path, input_files):
    '''
    Filter circRNA
    :param script_path:
    :param output_file:
    :param library_path:
    :param input_files:
    :return:
    '''
    inputs = ''
    for file in input_files:
        inputs += file + ' '
    perl_cmd = 'perl {} 2 0.34 20 {} {} {}'.format(script_path, output_file, library_path, inputs.strip())
    return perl_cmd


def prepareLinearReads(dir):
    '''
    Subtract linear reads
    :param dir:
    :return:
    '''
    shell_cmd = 'cat {}/*.sam | grep chr | grep -v circ | '.format(dir) + \
                'awk \'{if ($2==0) {print $10}}\' | uniq | ' \
                'awk \'BEGIN {i=0} {if (i++ % 100==0) {print ">seq"i"\\n"$0}}\' > ' + \
                '{}/linear_reads_motif'.format(dir)
    return shell_cmd

def prepareHomerLinear(clip_dir, homer_dir, bg_path):
    '''
    Motif analysis for linear reads
    :param clip_dir:
    :param homer_dir:
    :param bg_path:
    :return:
    '''
    homer_cmd = 'findMotifs.pl {}//linear_reads_motif fasta {}/motifResults_linear/ ' \
                '-p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 ' \
                '-fastaBg {}'.format(clip_dir, homer_dir, bg_path)
    return homer_cmd

def prepareHomerCircRNA(clip_dir, homer_dir, bg_path):
    '''
    Motif analysis for circRNA
    :param clip_dir:
    :param homer_dir:
    :param bg_path:
    :return:
    '''
    homer_cmd = 'findMotifs.pl {}//all_circ.txt_motif fasta {}/motifResults/ ' \
                '-p 6 -noconvert -chopify -len 4,5,6,7,8,9,10 ' \
                '-fastaBg {}'.format(clip_dir, homer_dir, bg_path)
    return homer_cmd


### -------------- read master file ----------------- ###
master_info = pd.read_table(master_path, sep='\t', header=0, index_col=0)
clip_list = list(master_info.index)
species = master_info['Species'].to_dict()
librarys = dict()
for key in species.keys():
    librarys[key] = os.path.join(genome_dir, ref_genome.get(species[key]), 'gsnap')


### -------------- assign tasks ------------------- ###
### create jobs folder
jobs_dir = os.path.join(cur_dir, 'jobs')
if not os.path.exists(jobs_dir):
    os.mkdir(jobs_dir)

### write job shell script
for clip in clip_list:
    job_sh = os.path.join(jobs_dir, clip + '.sh')
    with open(job_sh, 'w') as f:
        ## write head
        writeHead(file=f, clip=clip)

        ## remove adaptor, align and detect circRNA for each fastq file
        cur_circRNA_dir = os.path.join(circRNA_dir, clip)
        adaptors = readAdaptor(os.path.join(cur_circRNA_dir, 'adaptor.txt'))                                # read adaptor.txt
        fastq_files = [os.path.basename(file) for file in glob.glob('{}/*.fastq'.format(cur_circRNA_dir))]  # all fastq files

        for fastq in fastq_files:
            fastq_path = os.path.join(cur_circRNA_dir, fastq)
            print('### ----------------- {} ----------------- ###'.format(fastq), file=f)
            # ------- remove adaptor --------- #
            print('# remove adaptor', file=f)
            if adaptors.get(fastq) is not None:
                for adaptor in adaptors.get(fastq).split(','):
                    perl_cmd_1 = prepareRemoveAdaptor(script_path=remove_adaptor_perl,
                                                    file_path=fastq_path,
                                                    adaptor=adaptor)
                    fastq_path = fastq_path + '.removed'
                    print(perl_cmd_1, file=f)
            # ------ align to circRNA on genome ------ #
            print('# align to circRNA on genome', file=f)
            gsnap_cmd_1 = prepareAlignCircRNA(library=librarys[clip],
                                              input_file=fastq_path,
                                              output_file=fastq_path.split('.')[0]+'.on_genome.txt')
            print(gsnap_cmd_1, file=f)
            # ------ align to reference + circRNA ------ #
            print('# align to reference + circRNA', file=f)
            gsnap_cmd_2 = prepareAlignCircRNAandRef(library=librarys[clip],
                                                    input_file=fastq_path,
                                                    output_file=fastq_path.split('.')[0] + '.sam')
            print(gsnap_cmd_2, file=f)
            # ------ detect circRNA ------ #
            print('# detect circRNA', file=f)
            perl_cmd_2 = prepareDetectCircRNA(script_path=find_circRNA_perl,
                                              input_file=fastq_path.split('.')[0] + '.sam',
                                              output_file=fastq_path.split('.')[0] + '.circ.txt')
            print(perl_cmd_2, file=f)
            print('\n', file=f)

        ## filter circRNA and motif analysis
        print('### filter circRNA', file=f)
        circ_paths = [file.strip('.fastq') + '.circ.txt' for file in glob.glob('{}/*.fastq'.format(cur_circRNA_dir))]       # all circ.txt
        perl_cmd_3 = prepareFilterCircRNA(script_path=filter_circRNA_perl,
                                          output_file=os.path.join(cur_circRNA_dir, 'all_circ.txt'),
                                          library_path=genome_dir,
                                          input_files=circ_paths)
        print(perl_cmd_3, file=f)

        ##  motif analysis for linear reads
        print('### motif analysis for linear reads', file=f)
        shell_cmd = prepareLinearReads(dir=cur_circRNA_dir)
        print(shell_cmd, file=f)
        homer_cmd_1 = prepareHomerLinear(clip_dir=cur_circRNA_dir,
                                       homer_dir=os.path.join(homer_dir, clip),
                                       bg_path=motif_dir + ref_genome.get(species[clip]) + '_bg.fa')
        print(homer_cmd_1, file=f)

        ## motif analysis for circRNA reads
        print('### motif analysis for circRNA reads', file=f)
        homer_cmd_2 = prepareHomerCircRNA(clip_dir=cur_circRNA_dir,
                                          homer_dir=os.path.join(homer_dir, clip),
                                          bg_path=motif_dir + ref_genome.get(species[clip]) + '_bg.fa')
        print(homer_cmd_2, file=f)

        ## processed flag
        print('\ntouch {}'.format(os.path.join(cur_circRNA_dir, 'processed.tag')), file=f)
