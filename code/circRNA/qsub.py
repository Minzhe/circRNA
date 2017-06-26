###############################################################
###                        job.pl                           ###
###############################################################
# This python script is to submit job.sh in jobs folder
#!/usr/bin/python

import os
import glob

cur_dir = os.path.dirname(os.path.realpath(__file__))
jobs_path = os.path.join(cur_dir, 'jobs')
all_jobs = glob.glob('{}/CLIP*.sh'.format(jobs_path))

for job in all_jobs:
    os.system('qsub {}'.format(job))

control_jobs = glob.glob('{}/Control*.sh'.format(jobs_path))

for job in control_jobs:
    os.system('qsub {}'.format(job))