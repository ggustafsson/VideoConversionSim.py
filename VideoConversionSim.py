#!/usr/bin/env python3

# Written by Göran Gustafsson <gustafsson.g@gmail.com>.

# Copyright (c) 2014, Göran Gustafsson. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  Redistributions of source code must retain the above copyright notice, this
#  list of conditions and the following disclaimer.
#
#  Redistributions in binary form must reproduce the above copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

import datetime
import random
import simpy
import statistics

SERVERS = 2
JOBS_PER_SERVER = 4
UPLOADS = (24 * 60)
UPLOADS_INTERVAL = (1 * 60)
MAX_WAITING_TIME = (5 * 60)

MIN_VIDEO_LENGTH = 30
MAX_VIDEO_LENGTH = (30 * 60)
CONVERSION_TIME = 0.5

COLOR_NORMAL = "\033[0m"
COLOR_UPLOADED = "\033[1;31m"
COLOR_STARTED = "\033[1;33m"
COLOR_FINISHED = "\033[1;32m"

def time_f(seconds):
    """Takes seconds as input and returns it in one of the following formats:

    30 sec
    657 sec (0:10:57)

    """
    if seconds >= 60:
        time = datetime.timedelta(seconds=seconds)
        time -= datetime.timedelta(microseconds=time.microseconds)
        output = "%d sec (%s)" % (seconds, time)
    else:
        output = "%d sec" % seconds

    return output

def upload(env, uploads, interval, resources):
    """Generates video uploads at random times."""
    for i in range(uploads):
        number = i + 1
        conversion = convert(env, "Video %04d" % number, resources)
        env.process(conversion)

        wait = random.expovariate(1.0 / interval)
        yield env.timeout(wait)

def convert(env, name, resources):
    """Simulates arrival, queuing, conversion and release of resources."""
    global above_max_waiting
    global longest_wait
    global video_lengths
    global waiting_times

    length = random.randint(MIN_VIDEO_LENGTH, MAX_VIDEO_LENGTH)
    video_lengths.append(length)
    duration = length * CONVERSION_TIME

    print("%6d -" % env.now +
          COLOR_UPLOADED + " %s uploaded " % name + COLOR_NORMAL +
          ": Length is %s" % time_f(length))
    arrived = env.now

    with resources.request() as wait_for_slot:
        yield wait_for_slot
        waited = env.now - arrived
        waiting_times.append(waited)

        if waited > MAX_WAITING_TIME:
            above_max_waiting += 1

        if waited > longest_wait:
            longest_wait = waited

        print("%6d -" % env.now +
              COLOR_STARTED + " %s started  " % name + COLOR_NORMAL +
              ": Waited for %s" % time_f(waited))
        yield env.timeout(duration)
        print("%6d -" % env.now +
              COLOR_FINISHED + " %s finished " % name + COLOR_NORMAL +
              ": Duration was %s" % time_f(duration))

above_max_waiting = 0
longest_wait = 0
server_slots = SERVERS * JOBS_PER_SERVER
video_lengths = []
waiting_times = []

print("%d server(s), %d job(s) each = %d conversion(s) at a time" % \
      (SERVERS, JOBS_PER_SERVER, server_slots))
print("%d video files total, 1 new every ~%s\n" % (UPLOADS, \
      time_f(UPLOADS_INTERVAL)))

print("    Video length = %s - %s" % (time_f(MIN_VIDEO_LENGTH), \
      time_f(MAX_VIDEO_LENGTH)))
print(" Conversion time = %d%% of video length" % (CONVERSION_TIME * 100))
print("Max waiting time = %s\n" % time_f(MAX_WAITING_TIME))

env = simpy.Environment()
resources = simpy.Resource(env, capacity=(server_slots))
uploads = upload(env, UPLOADS, UPLOADS_INTERVAL, resources)
env.process(uploads)
env.run()

video_length_mean = statistics.mean(video_lengths)
video_conversion_mean = video_length_mean * CONVERSION_TIME
print("\n   Mean video length: %s" % time_f(video_length_mean))
print("Mean conversion time: %s\n" % time_f(video_conversion_mean))

video_length_median = statistics.median(video_lengths)
video_conversion_median = video_length_median * CONVERSION_TIME
print("   Median video length: %s" % time_f(video_length_median))
print("Median conversion time: %s\n" % time_f(video_conversion_median))

print("   Mean waiting time: %s" % time_f(statistics.mean(waiting_times)))
print(" Median waiting time: %s" % time_f(statistics.median(waiting_times)))
print("Longest waiting time: %s\n" % time_f(longest_wait))

print("Above max waiting time: %d out of %d" % (above_max_waiting, \
      UPLOADS))
