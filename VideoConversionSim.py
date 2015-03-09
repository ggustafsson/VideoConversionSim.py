#!/usr/bin/env python3

# Copyright (c) 2015, Göran Gustafsson. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
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

###############################################################################
# Version: 1.0                                                                #
#     Web: https://github.com/ggustafsson/VideoConversionSim.py               #
#     Git: https://github.com/ggustafsson/VideoConversionSim.py.git           #
#   Email: gustafsson.g@gmail.com                                             #
###############################################################################

import datetime
import random
import simpy
import statistics

servers = 2
jobs_per_server = 4
uploads = (24 * 60)
uploads_interval = (1 * 60)
max_waiting_time = (5 * 60)

min_video_length = 30
max_video_length = (30 * 60)
conversion_time = 0.5

color_normal   = "\033[0m"
color_uploaded = "\033[1;31m"
color_started  = "\033[1;33m"
color_finished = "\033[1;32m"

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

    arrived = env.now
    length = random.randint(min_video_length, max_video_length)
    duration = length * conversion_time
    video_lengths.append(length)

    print("%6d -" % env.now +
          color_uploaded + " %s uploaded " % name + color_normal +
          ": Length is %s" % time_f(length))

    with resources.request() as wait_for_slot:
        yield wait_for_slot
        waited = env.now - arrived
        waiting_times.append(waited)

        if waited > max_waiting_time:
            above_max_waiting += 1

        if waited > longest_wait:
            longest_wait = waited

        print("%6d -" % env.now +
              color_started + " %s started  " % name + color_normal +
              ": Waited for %s" % time_f(waited))
        yield env.timeout(duration)
        print("%6d -" % env.now +
              color_finished + " %s finished " % name + color_normal +
              ": Duration was %s" % time_f(duration))

above_max_waiting = 0
longest_wait = 0
server_slots = servers * jobs_per_server
video_lengths = []
waiting_times = []

print("%d server(s), %d job(s) each = %d conversion(s) at a time" % \
      (servers, jobs_per_server, server_slots))
print("%d video files total, 1 new every ~%s\n" % (uploads, \
      time_f(uploads_interval)))

print("    Video length = %s - %s" % (time_f(min_video_length), \
      time_f(max_video_length)))
print(" Conversion time = %d%% of video length" % (conversion_time * 100))
print("Max waiting time = %s\n" % time_f(max_waiting_time))

env = simpy.Environment()
resources = simpy.Resource(env, capacity=(server_slots))
uploading = upload(env, uploads, uploads_interval, resources)
env.process(uploading)
env.run()

video_length_mean = statistics.mean(video_lengths)
video_conversion_mean = video_length_mean * conversion_time
print("\n   Mean video length: %s" % time_f(video_length_mean))
print("Mean conversion time: %s\n" % time_f(video_conversion_mean))

video_length_median = statistics.median(video_lengths)
video_conversion_median = video_length_median * conversion_time
print("   Median video length: %s" % time_f(video_length_median))
print("Median conversion time: %s\n" % time_f(video_conversion_median))

print("   Mean waiting time: %s" % time_f(statistics.mean(waiting_times)))
print(" Median waiting time: %s" % time_f(statistics.median(waiting_times)))
print("Longest waiting time: %s\n" % time_f(longest_wait))

print("Above max waiting time: %d out of %d" % (above_max_waiting, \
      uploads))
