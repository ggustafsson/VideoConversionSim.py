VideoConversionSim.py
=====================

![Preview](https://github.com/ggustafsson/VideoConversionSim.py/raw/master/Preview.png)

Description
-----------
VideoConversionSim.py is the result of a small project in a Computer Science
course at University West, Trollhättan. The program simulates a system that
converts uploaded video files (resources, queues etc). This project was created
under a short amount of time and is therefor not perfect but it can at least be
used as a reference when developing something else.

The best way to understand all of this is to read the file Project Report.pdf.

Components
----------
- **VideoConversionSim.py** - Simulates uploads and video conversions.
- **SimLoop.zsh** - Runs **VideoConversionSim.py** X times and writes down all
  of the interesting results into a CSV file.
- **SimResultsGroup.rb** - Parses the CSV file from **SimLoop.zsh** and group
  the values in 10 equally large range groups.
- **SimResultsGroup-Runner.zsh** - The script i used to automatically run
  **SimResultsGroup.rb** on all of my logged data files.
- **SimResultsHistogram.gpi** - The Gnuplot commands used for creating
  histograms of the collected data.

Dependencies
------------
- **Python 3**
- **SimPy 3**
- **Ruby 2**
- **Zsh**
- **Gnuplot**

License
-------
Released under the BSD 2-Clause License.

    Copyright (c) 2014, Göran Gustafsson. All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

     Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

     Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation
     and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
